-- Deployment file for version 20.12.0
--     as of 2022-02-22
-- ./changes/ocd-3692.sql
-- this column was never defined with "default false" as all other "deleted" columns are
ALTER TABLE openchpl.certification_result_test_functionality ALTER COLUMN deleted SET DEFAULT false;
ALTER TABLE openchpl.certification_result_optional_standard ALTER COLUMN deleted SET DEFAULT false;
ALTER TABLE openchpl.certification_result_ucd_process ALTER COLUMN deleted SET DEFAULT false;

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
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_api WHERE http_method = 'POST' and api_operation LIKE '/certified_products/upload');;
-- ./changes/ocd-3717.sql
ALTER TYPE openchpl.attestation RENAME TO transparency_attestation;

-- Old Tables or Previous designs
DROP TABLE IF EXISTS openchpl.change_request_attestation CASCADE;
DROP TABLE IF EXISTS openchpl.developer_attestation CASCADE;
DROP TABLE IF EXISTS openchpl.attestation_answer CASCADE;
DROP TABLE IF EXISTS openchpl.attestation_question CASCADE;
DROP TABLE IF EXISTS openchpl.attestation_category CASCADE;

-- New Tables
DROP TABLE IF EXISTS openchpl.change_request_attestation_response CASCADE;
DROP TABLE IF EXISTS openchpl.change_request_attestation_submission CASCADE;
DROP TABLE IF EXISTS openchpl.developer_attestation_response CASCADE;
DROP TABLE IF EXISTS openchpl.developer_attestation_submission CASCADE;
DROP TABLE IF EXISTS openchpl.attestation_form CASCADE;
DROP TABLE IF EXISTS openchpl.attestation_period CASCADE;
DROP TABLE IF EXISTS openchpl.attestation_valid_response CASCADE;
DROP TABLE IF EXISTS openchpl.attestation CASCADE;
DROP TABLE IF EXISTS openchpl.attestation_condition CASCADE;

-- Clear out the Change requests for now, since they have been psuedo orphaned by removing the CR Attestation tables	
delete from openchpl.change_request_status;
delete from openchpl.change_request;

CREATE TABLE IF NOT EXISTS openchpl.attestation_period (
	id bigserial NOT NULL,
	period_start date NOT NULL,
	period_end date NOT NULL,
	submission_start date NOT NULL,
	submission_end date NOT NULL,
	description text NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT attestation_period_pk PRIMARY KEY (id)
);
CREATE TRIGGER attestation_period_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.attestation_period FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER attestation_period_timestamp BEFORE UPDATE on openchpl.attestation_period FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

INSERT INTO openchpl.attestation_period (period_start, period_end, submission_start, submission_end, description, last_modified_user)
SELECT '2021-01-01', '2022-03-31', '2022-01-01', '2022-04-30', 'First Period', -1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.attestation_period
	WHERE period_start = '2021-01-01'
	AND period_end = '2022-03-31');

------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS openchpl.attestation_condition (
	id bigserial NOT NULL,
	name text NOT NULL,
	sort_order bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT attestation_condition_pk PRIMARY KEY (id)
);
CREATE TRIGGER attestation_condition_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.attestation_condition FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER attestation_condition_timestamp BEFORE UPDATE on openchpl.attestation_condition FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

INSERT INTO openchpl.attestation_condition (name, sort_order, last_modified_user)
SELECT 'Information Blocking', 1, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_condition
	WHERE name = 'Information Blocking');	


INSERT INTO openchpl.attestation_condition (name, sort_order, last_modified_user)
SELECT 'Assurances', 2, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_condition
	WHERE name = 'Assurances');

INSERT INTO openchpl.attestation_condition (name, sort_order, last_modified_user)
SELECT 'Communications', 3, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_condition
	WHERE name = 'Communications');

INSERT INTO openchpl.attestation_condition (name, sort_order, last_modified_user)
SELECT 'Application Programming Interfaces (APIs)', 4, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_condition
	WHERE name = 'Application Programming Interfaces (APIs)');

INSERT INTO openchpl.attestation_condition (name, sort_order, last_modified_user)
SELECT 'Real World Testing', 5, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_condition
	WHERE name = 'Real World Testing');

------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS openchpl.attestation (
	id bigserial NOT NULL,
	attestation_condition_id bigint NOT NULL,
	description text NOT NULL,
	sort_order bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT attestation_pk PRIMARY KEY (id),
	CONSTRAINT attestation_condition_id_fk FOREIGN KEY (attestation_condition_id)
      REFERENCES openchpl.attestation_condition (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TRIGGER attestation_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.attestation FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER attestation_timestamp BEFORE UPDATE on openchpl.attestation FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

INSERT INTO openchpl.attestation (description, attestation_condition_id, sort_order, last_modified_user)
SELECT 'We attest to compliance with the Information Blocking Condition of Certification requirement described in [§170.401](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.401).', 
	(SELECT id FROM openchpl.attestation_condition WHERE name = 'Information Blocking'),
	1,
	-1
WHERE NOT EXISTS (
    SELECT ques.*
	FROM openchpl.attestation ques
		INNER JOIN openchpl.attestation_condition cat
			ON cat.id = ques.attestation_condition_id
	WHERE ques.description = 'We attest to compliance with the Information Blocking Condition of Certification requirement described in [§170.401](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.401).'
	AND cat.name = 'Information Blocking');

INSERT INTO openchpl.attestation (description, attestation_condition_id, sort_order, last_modified_user)
SELECT 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in [§170.402](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.402).', 
	(SELECT id FROM openchpl.attestation_condition WHERE name = 'Assurances'),
	2,
	-1
WHERE NOT EXISTS (
    SELECT ques.*
	FROM openchpl.attestation ques
		INNER JOIN openchpl.attestation_condition cat
			ON cat.id = ques.attestation_condition_id
	WHERE ques.description = 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in [§170.402](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.402).'
	AND cat.name = 'Assurances');

INSERT INTO openchpl.attestation (description, attestation_condition_id, sort_order, last_modified_user)
SELECT 'We attest to compliance with the Communications Condition and Maintenance of Certification requirements described in [§170.403](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.403).', 
	(SELECT id FROM openchpl.attestation_condition WHERE name = 'Communications'),
	3,
	-1
WHERE NOT EXISTS (
    SELECT ques.*
	FROM openchpl.attestation ques
		INNER JOIN openchpl.attestation_condition cat
			ON cat.id = ques.attestation_condition_id
	WHERE ques.description = 'We attest to compliance with the Communications Condition and Maintenance of Certification requirements described in [§170.403](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.403).'
	AND cat.name = 'Communications');

INSERT INTO openchpl.attestation (description, attestation_condition_id, sort_order, last_modified_user)
SELECT 'We attest to compliance with the APIs Condition and Maintenance of Certification requirements described in [§170.404](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.404).', 
	(SELECT id FROM openchpl.attestation_condition WHERE name = 'Application Programming Interfaces (APIs)'),
	4,
	-1
WHERE NOT EXISTS (
    SELECT ques.*
	FROM openchpl.attestation ques
		INNER JOIN openchpl.attestation_condition cat
			ON cat.id = ques.attestation_condition_id
	WHERE ques.description = 'We attest to compliance with the APIs Condition and Maintenance of Certification requirements described in [§170.404](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.404).'
	AND cat.name = 'Application Programming Interfaces (APIs)');


INSERT INTO openchpl.attestation (description, attestation_condition_id, sort_order, last_modified_user)
SELECT 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in [§170.405](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.405).', 
	(SELECT id FROM openchpl.attestation_condition WHERE name = 'Real World Testing'),
	5,
	-1
WHERE NOT EXISTS (
    SELECT ques.*
	FROM openchpl.attestation ques
		INNER JOIN openchpl.attestation_condition cat
			ON cat.id = ques.attestation_condition_id
	WHERE ques.description = 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in [§170.405](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.405).'
	AND cat.name = 'Real World Testing');

------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS openchpl.attestation_valid_response (
	id bigserial NOT NULL,
	response text NOT NULL,
	meaning text,
	sort_order bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT attestation_valid_response_pk PRIMARY KEY (id)
);
CREATE TRIGGER attestation_valid_response_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.attestation_valid_response FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER attestation_valid_response_timestamp BEFORE UPDATE on openchpl.attestation_valid_response FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

INSERT INTO openchpl.attestation_valid_response (response, sort_order, last_modified_user)
SELECT 'Compliant', 1, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_valid_response
	WHERE response = 'Compliant');

INSERT INTO openchpl.attestation_valid_response (response, sort_order, last_modified_user)
SELECT 'Compliant with the requirements of §45 CFR §170.402; certifies to the criterion at §45 CFR §170.315(b)(10) and provides all of its customers of certified health IT with health IT certified to the certification criterion in §45 CFR §170.315(b)(10)', 2, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_valid_response
	WHERE response = 'Compliant with the requirements of §45 CFR §170.402; certifies to the criterion at §45 CFR §170.315(b)(10) and provides all of its customers of certified health IT with health IT certified to the certification criterion in §45 CFR §170.315(b)(10)');

INSERT INTO openchpl.attestation_valid_response (response, sort_order, last_modified_user)
SELECT 'Compliant with the requirements of §45 CFR §170.402; does not certify to the criterion at §45 CFR §170.315(b)(10) or does not provide all of its customers of certified health IT with health IT certified to the certification criterion in §45 CFR §170.315(b)(10)', 3, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_valid_response
	WHERE response = 'Compliant with the requirements of §45 CFR §170.402; does not certify to the criterion at §45 CFR §170.315(b)(10) or does not provide all of its customers of certified health IT with health IT certified to the certification criterion in §45 CFR §170.315(b)(10)');

INSERT INTO openchpl.attestation_valid_response (response, sort_order, last_modified_user)
SELECT 'Noncompliant', 10, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_valid_response
	WHERE response = 'Noncompliant');

INSERT INTO openchpl.attestation_valid_response (response, sort_order, last_modified_user)
SELECT 'Not Applicable', 20, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_valid_response
	WHERE response = 'Not Applicable');

------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS openchpl.attestation_form (
	id bigserial NOT NULL,
	attestation_id bigint NOT NULL,
	attestation_valid_response_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT attestation_form_pk PRIMARY KEY (id),
	CONSTRAINT attestation_id_fk FOREIGN KEY (attestation_id)
      REFERENCES openchpl.attestation (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT attestation_valid_response_id_fk FOREIGN KEY (attestation_valid_response_id)
      REFERENCES openchpl.attestation_valid_response (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TRIGGER attestation_form_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.attestation_form FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER attestation_form_timestamp BEFORE UPDATE on openchpl.attestation_form FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();


INSERT INTO openchpl.attestation_form (attestation_id, attestation_valid_response_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation WHERE description = 'We attest to compliance with the Information Blocking Condition of Certification requirement described in [§170.401](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.401).'),
	(SELECT id from openchpl.attestation_valid_response WHERE response = 'Compliant'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation ques
			ON form.attestation_id = ques.id
		INNER JOIN openchpl.attestation_valid_response ans
			ON form.attestation_valid_response_id = ans.id
	WHERE ques.description = 'We attest to compliance with the Information Blocking Condition of Certification requirement described in [§170.401](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.401).'
	AND ans.response = 'Compliant');

INSERT INTO openchpl.attestation_form (attestation_id, attestation_valid_response_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation WHERE description = 'We attest to compliance with the Information Blocking Condition of Certification requirement described in [§170.401](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.401).'),
	(SELECT id from openchpl.attestation_valid_response WHERE response = 'Noncompliant'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation ques
			ON form.attestation_id = ques.id
		INNER JOIN openchpl.attestation_valid_response ans
			ON form.attestation_valid_response_id = ans.id
	WHERE ques.description = 'We attest to compliance with the Information Blocking Condition of Certification requirement described in [§170.401](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.401).'
	AND ans.response = 'Noncompliant');
	
INSERT INTO openchpl.attestation_form (attestation_id, attestation_valid_response_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation WHERE description = 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in [§170.402](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.402).'),
	(SELECT id from openchpl.attestation_valid_response WHERE response = 'Compliant with the requirements of §45 CFR §170.402; certifies to the criterion at §45 CFR §170.315(b)(10) and provides all of its customers of certified health IT with health IT certified to the certification criterion in §45 CFR §170.315(b)(10)'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation ques
			ON form.attestation_id = ques.id
		INNER JOIN openchpl.attestation_valid_response ans
			ON form.attestation_valid_response_id = ans.id
	WHERE ques.description = 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in [§170.402](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.402).'
	AND ans.response = 'Compliant with the requirements of §45 CFR §170.402; certifies to the criterion at §45 CFR §170.315(b)(10) and provides all of its customers of certified health IT with health IT certified to the certification criterion in §45 CFR §170.315(b)(10)');

	
INSERT INTO openchpl.attestation_form (attestation_id, attestation_valid_response_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation WHERE description = 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in [§170.402](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.402).'),
	(SELECT id from openchpl.attestation_valid_response WHERE response = 'Compliant with the requirements of §45 CFR §170.402; does not certify to the criterion at §45 CFR §170.315(b)(10) or does not provide all of its customers of certified health IT with health IT certified to the certification criterion in §45 CFR §170.315(b)(10)'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation ques
			ON form.attestation_id = ques.id
		INNER JOIN openchpl.attestation_valid_response ans
			ON form.attestation_valid_response_id = ans.id
	WHERE ques.description = 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in [§170.402](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.402).'
	AND ans.response = 'Compliant with the requirements of §45 CFR §170.402; does not certify to the criterion at §45 CFR §170.315(b)(10) or does not provide all of its customers of certified health IT with health IT certified to the certification criterion in §45 CFR §170.315(b)(10)');

INSERT INTO openchpl.attestation_form (attestation_id, attestation_valid_response_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation WHERE description = 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in [§170.402](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.402).'),
	(SELECT id from openchpl.attestation_valid_response WHERE response = 'Noncompliant'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation ques
			ON form.attestation_id = ques.id
		INNER JOIN openchpl.attestation_valid_response ans
			ON form.attestation_valid_response_id = ans.id
	WHERE ques.description = 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in [§170.402](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.402).'
	AND ans.response = 'Noncompliant');

INSERT INTO openchpl.attestation_form (attestation_id, attestation_valid_response_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation WHERE description = 'We attest to compliance with the Communications Condition and Maintenance of Certification requirements described in [§170.403](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.403).'),
	(SELECT id from openchpl.attestation_valid_response WHERE response = 'Compliant'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation ques
			ON form.attestation_id = ques.id
		INNER JOIN openchpl.attestation_valid_response ans
			ON form.attestation_valid_response_id = ans.id
	WHERE ques.description = 'We attest to compliance with the Communications Condition and Maintenance of Certification requirements described in [§170.403](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.403).'
	AND ans.response = 'Compliant');

INSERT INTO openchpl.attestation_form (attestation_id, attestation_valid_response_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation WHERE description = 'We attest to compliance with the Communications Condition and Maintenance of Certification requirements described in [§170.403](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.403).'),
	(SELECT id from openchpl.attestation_valid_response WHERE response = 'Noncompliant'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation ques
			ON form.attestation_id = ques.id
		INNER JOIN openchpl.attestation_valid_response ans
			ON form.attestation_valid_response_id = ans.id
	WHERE ques.description = 'We attest to compliance with the Communications Condition and Maintenance of Certification requirements described in [§170.403](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.403).'
	AND ans.response = 'Noncompliant');

INSERT INTO openchpl.attestation_form (attestation_id, attestation_valid_response_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation WHERE description = 'We attest to compliance with the APIs Condition and Maintenance of Certification requirements described in [§170.404](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.404).'),
	(SELECT id from openchpl.attestation_valid_response WHERE response = 'Compliant'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation ques
			ON form.attestation_id = ques.id
		INNER JOIN openchpl.attestation_valid_response ans
			ON form.attestation_valid_response_id = ans.id
	WHERE ques.description = 'We attest to compliance with the APIs Condition and Maintenance of Certification requirements described in [§170.404](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.404).'
	AND ans.response = 'Compliant');

INSERT INTO openchpl.attestation_form (attestation_id, attestation_valid_response_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation WHERE description = 'We attest to compliance with the APIs Condition and Maintenance of Certification requirements described in [§170.404](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.404).'),
	(SELECT id from openchpl.attestation_valid_response WHERE response = 'Noncompliant'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation ques
			ON form.attestation_id = ques.id
		INNER JOIN openchpl.attestation_valid_response ans
			ON form.attestation_valid_response_id = ans.id
	WHERE ques.description = 'We attest to compliance with the APIs Condition and Maintenance of Certification requirements described in [§170.404](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.404).'
	AND ans.response = 'Noncompliant');

INSERT INTO openchpl.attestation_form (attestation_id, attestation_valid_response_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation WHERE description = 'We attest to compliance with the APIs Condition and Maintenance of Certification requirements described in [§170.404](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.404).'),
	(SELECT id from openchpl.attestation_valid_response WHERE response = 'Not Applicable'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation ques
			ON form.attestation_id = ques.id
		INNER JOIN openchpl.attestation_valid_response ans
			ON form.attestation_valid_response_id = ans.id
	WHERE ques.description = 'We attest to compliance with the APIs Condition and Maintenance of Certification requirements described in [§170.404](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.404).'
	AND ans.response = 'Not Applicable');

----
INSERT INTO openchpl.attestation_form (attestation_id, attestation_valid_response_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation WHERE description = 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in [§170.405](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.405).'),
	(SELECT id from openchpl.attestation_valid_response WHERE response = 'Compliant'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation ques
			ON form.attestation_id = ques.id
		INNER JOIN openchpl.attestation_valid_response ans
			ON form.attestation_valid_response_id = ans.id
	WHERE ques.description = 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in [§170.405](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.405).'
	AND ans.response = 'Compliant');

INSERT INTO openchpl.attestation_form (attestation_id, attestation_valid_response_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation WHERE description = 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in [§170.405](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.405).'),
	(SELECT id from openchpl.attestation_valid_response WHERE response = 'Noncompliant'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation ques
			ON form.attestation_id = ques.id
		INNER JOIN openchpl.attestation_valid_response ans
			ON form.attestation_valid_response_id = ans.id
	WHERE ques.description = 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in [§170.405](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.405).'
	AND ans.response = 'Noncompliant');

INSERT INTO openchpl.attestation_form (attestation_id, attestation_valid_response_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation WHERE description = 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in [§170.405](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.405).'),
	(SELECT id from openchpl.attestation_valid_response WHERE response = 'Not Applicable'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation ques
			ON form.attestation_id = ques.id
		INNER JOIN openchpl.attestation_valid_response ans
			ON form.attestation_valid_response_id = ans.id
	WHERE ques.description = 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in [§170.405](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.405).'
	AND ans.response = 'Not Applicable');

------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS openchpl.change_request_attestation_submission (
	id bigserial NOT NULL,
	change_request_id bigint NOT NULL,
	attestation_period_id bigint NOT NULL,
	signature text NOT NULL,
	signature_email text NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT change_request_attestations_submission_pk PRIMARY KEY (id),
	CONSTRAINT change_request_id_fk FOREIGN KEY (change_request_id)
      REFERENCES openchpl.change_request (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT attestation_period_id_fk FOREIGN KEY (attestation_period_id)
      REFERENCES openchpl.attestation_period (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);


CREATE TABLE IF NOT EXISTS openchpl.change_request_attestation_response (
	id bigserial NOT NULL,
	change_request_attestation_submission_id bigint NOT NULL,
	attestation_id bigint NOT NULL,
	attestation_valid_response_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT change_request_attestations_response_pk PRIMARY KEY (id),
	CONSTRAINT change_request_attestation_submission_id_fk FOREIGN KEY (change_request_attestation_submission_id)
      REFERENCES openchpl.change_request_attestation_submission (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT attestation_id_fk FOREIGN KEY (attestation_id)
      REFERENCES openchpl.attestation (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT attestation_valid_response_id_fk FOREIGN KEY (attestation_valid_response_id)
      REFERENCES openchpl.attestation_valid_response (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS openchpl.developer_attestation_submission (
	id bigserial NOT NULL,
	developer_id bigint NOT NULL,
	attestation_period_id bigint NOT NULL,
	signature text NOT NULL,
	signature_email text NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT developer_attestation_submission_pk PRIMARY KEY (id),
	CONSTRAINT developer_id_fk FOREIGN KEY (developer_id)
      REFERENCES openchpl.vendor (vendor_id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT attestation_period_id_fk FOREIGN KEY (attestation_period_id)
      REFERENCES openchpl.attestation_period (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TRIGGER developer_attestation_submission_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.developer_attestation_submission FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER developer_attestation_submission_timestamp BEFORE UPDATE on openchpl.developer_attestation_submission FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

CREATE TABLE IF NOT EXISTS openchpl.developer_attestation_response (
	id bigserial NOT NULL,
	developer_attestation_submission_id bigint NOT NULL,
	attestation_id bigint NOT NULL,
	attestation_valid_response_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT developer_attestations_response_pk PRIMARY KEY (id),
	CONSTRAINT developer_attestation_id_fk FOREIGN KEY (developer_attestation_submission_id)
      REFERENCES openchpl.developer_attestation_submission (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT attestation_id_fk FOREIGN KEY (attestation_id)
      REFERENCES openchpl.attestation (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT attestation_valid_response_id_fk FOREIGN KEY (attestation_valid_response_id)
      REFERENCES openchpl.attestation_valid_response (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TRIGGER developer_attestation_response_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.developer_attestation_response FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER developer_attestation_response_timestamp BEFORE UPDATE on openchpl.developer_attestation_response FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('20.12.0', '2022-02-22', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
