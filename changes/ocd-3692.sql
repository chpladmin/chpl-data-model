-- this column was never defined with "default false" as all other "deleted" columns are
ALTER TABLE openchpl.certification_result_test_functionality ALTER COLUMN deleted SET DEFAULT false;

DROP TABLE openchpl.certified_product_upload;
DROP TYPE openchpl.certified_product_upload_status;

CREATE TYPE openchpl.certified_product_upload_status as enum ('UPLOAD_PROCESSING', 'UPLOAD_SUCCESS', 'UPLOAD_FAILURE',
	'CONFIRMATION_PROCESSING', 'CONFIRMED', 'REJECTED');
	
CREATE TABLE openchpl.certified_product_upload (
	id bigserial NOT NULL,
	chpl_product_number text NOT NULL,
	certification_body_id bigint NOT NULL,
	vendor_name text,
	product_name text,
	version_name text,
	certification_date date,
	error_count integer,
	warning_count integer,
	status openchpl.certified_product_upload_status,
	contents text NOT NULL,
	certified_product_id bigint,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT certified_product_upload_pk PRIMARY KEY (id),
	CONSTRAINT certification_body_fk FOREIGN KEY (certification_body_id)
      REFERENCES openchpl.certification_body (certification_body_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT certified_product_id_fk FOREIGN KEY (certified_product_id)
      REFERENCES openchpl.certified_product (certified_product_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

-- add soft delete triggers specific to deprecated usage tables so we can remove some of the data below
CREATE OR REPLACE FUNCTION openchpl.deprecated_api_soft_delete()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE openchpl.deprecated_api_usage as src SET deleted = NEW.deleted WHERE src.deprecated_api_id = NEW.id;
    RETURN NEW;
END;
$$ language 'plpgsql';
DROP TRIGGER IF EXISTS deprecated_api_soft_delete on openchpl.deprecated_api;
CREATE TRIGGER deprecated_api_soft_delete AFTER UPDATE of deleted on openchpl.deprecated_api FOR EACH ROW EXECUTE PROCEDURE openchpl.deprecated_api_soft_delete();

CREATE OR REPLACE FUNCTION openchpl.deprecated_response_field_api_soft_delete()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE openchpl.deprecated_response_field as src SET deleted = NEW.deleted WHERE src.deprecated_api_id = NEW.id;
	UPDATE openchpl.deprecated_response_field_api_usage as src SET deleted = NEW.deleted WHERE src.deprecated_response_field_api_id = NEW.id;
    RETURN NEW;
END;
$$ language 'plpgsql';
DROP TRIGGER IF EXISTS deprecated_response_field_api_soft_delete on openchpl.deprecated_response_field_api;
CREATE TRIGGER deprecated_response_field_api_soft_delete AFTER UPDATE of deleted on openchpl.deprecated_response_field_api FOR EACH ROW EXECUTE PROCEDURE openchpl.deprecated_response_field_api_soft_delete();

-- remove apis with deprecated response fields where the API itself is now deprecated
UPDATE openchpl.deprecated_response_field_api
SET deleted = TRUE
WHERE http_method = 'POST'
AND api_operation LIKE '/certified_products/pending/{pcpId:^-?\\d+$}/beta/confirm';

UPDATE openchpl.deprecated_response_field_api
SET deleted = TRUE
WHERE http_method = 'POST'
AND api_operation LIKE '/certified_products/upload';

UPDATE openchpl.deprecated_response_field_api
SET deleted = TRUE
WHERE http_method = 'GET'
AND api_operation LIKE '/certified_products/pending/{pcpId:^-?\\d+$}';

-- add newly deprecated endpoints
INSERT INTO openchpl.deprecated_api (http_method, api_operation, request_parameter, change_description, removal_date, last_modified_user)
SELECT 'POST',
	'/certified_products/pending/{pcpId:^-?\d+$}/beta/confirm',
	NULL,
	'This endpoint is deprecated and will be removed in a future release. Please POST to /listings/pending/{id} to confirm an uploaded listing.',
	'2022-07-15',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_api WHERE http_method = 'POST' and api_operation LIKE '/certified_products/pending/{pcpId:^-?\\d+$}/beta/confirm');

INSERT INTO openchpl.deprecated_api (http_method, api_operation, request_parameter, change_description, removal_date, last_modified_user)
SELECT 'DELETE',
	'/certified_products/pending',
	NULL,
	'This endpoint is deprecated and will be removed in a future release. Please DELETE from /listings/pending to bulk reject uploaded listings.',
	'2022-07-15',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_api WHERE http_method = 'DELETE' and api_operation LIKE '/certified_products/pending');

INSERT INTO openchpl.deprecated_api (http_method, api_operation, request_parameter, change_description, removal_date, last_modified_user)
SELECT 'DELETE',
	'/certified_products/pending/{pcpId:^-?\d+$}',
	NULL,
	'This endpoint is deprecated and will be removed in a future release. Please DELETE from /listings/pending/{id} to reject an uploaded listing.',
	'2022-07-15',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_api WHERE http_method = 'DELETE' and api_operation LIKE '/certified_products/pending/{pcpId:^-?\\d+$}');

INSERT INTO openchpl.deprecated_api (http_method, api_operation, request_parameter, change_description, removal_date, last_modified_user)
SELECT 'GET',
	'/certified_products/pending/{pcpId:^-?\d+$}',
	NULL,
	'This endpoint is deprecated and will be removed in a future release. Please GET from /listings/pending/{id} to get an uploaded listing.',
	'2022-07-15',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_api WHERE http_method = 'GET' and api_operation LIKE '/certified_products/pending/{pcpId:^-?\\d+$}');

INSERT INTO openchpl.deprecated_api (http_method, api_operation, request_parameter, change_description, removal_date, last_modified_user)
SELECT 'GET',
	'/certified_products/pending/metadata',
	NULL,
	'This endpoint is deprecated and will be removed in a future release. Please GET from /listings/pending to get all uploaded listings available for processing.',
	'2022-07-15',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_api WHERE http_method = 'GET' and api_operation LIKE '/certified_products/pending/metadata');

INSERT INTO openchpl.deprecated_api (http_method, api_operation, request_parameter, change_description, removal_date, last_modified_user)
SELECT 'POST',
	'/certified_products/upload',
	NULL,
	'This endpoint is deprecated and will be removed in a future release. Please POST to /listings/upload to upload a new listing.',
	'2022-07-15',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_api WHERE http_method = 'POST' and api_operation LIKE '/certified_products/upload');