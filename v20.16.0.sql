-- Deployment file for version 20.16.0
--     as of 2022-05-16
-- ./changes/ocd-3898.sql
-- TODO: After OCD-3921 gets merged, find any records in deprecated_response_field_api that no longer have any deprecated_response_fields and clean those up


-- versionId deprecation
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}/ics_relationships'),
	'version -> versionId',
	'This field is deprecated and will be removed from the response data in a future release. Please use version -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}/ics_relationships') and response_field = 'version -> versionId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{chplPrefix}-{identifier}/ics_relationships'),
	'version -> versionId',
	'This field is deprecated and will be removed from the response data in a future release. Please use version -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{chplPrefix}-{identifier}/ics_relationships') and response_field = 'version -> versionId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{certifiedProductId:^-?\\d+$}/ics_relationships'),
	'version -> versionId',
	'This field is deprecated and will be removed from the response data in a future release. Please use version -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{certifiedProductId:^-?\\d+$}/ics_relationships') and response_field = 'version -> versionId');;
-- ./changes/ocd-3915.sql
-- Correct the triggers on cures_update_event table
DROP TRIGGER IF EXISTS cures_update_event_timestamp ON openchpl.cures_update_event;
CREATE TRIGGER cures_update_event_timestamp BEFORE UPDATE on openchpl.cures_update_event FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();


--********************************************************
-- Listing 10850 had an update that removed it's Cures Update designation. 
-- The update should have left cures update = true.
--********************************************************/
DELETE FROM openchpl.cures_update_event
WHERE id = 1645;

DELETE FROM openchpl.cures_update_event
WHERE id = 1658;
		
--********************************************************
--Listing 10861 should have been uploaded as cures = true
--********************************************************/
		
UPDATE openchpl.cures_update_event
SET cures_update = true
WHERE id = 1646;

DELETE FROM openchpl.cures_update_event
WHERE id = 1659;

--********************************************************
--Listing 10869 should have been uploaded as cures = true
--********************************************************/
		
UPDATE openchpl.cures_update_event
SET cures_update = true
WHERE id = 1655;

DELETE FROM openchpl.cures_update_event
WHERE id = 1660;;
-- ./changes/ocd-3934.sql
-- SCHEMA: shared_store

CREATE SCHEMA IF NOT EXISTS shared_store
    AUTHORIZATION openchpl_dev;

GRANT ALL ON SCHEMA shared_store TO openchpl_dev;
GRANT USAGE ON SCHEMA shared_store TO openchpl;

CREATE TABLE IF NOT EXISTS shared_store.shared_store (
	domain TEXT NOT NULL,
	key TEXT NOT NULL,
	value TEXT,
	put_date TIMESTAMP NOT NULL DEFAULT NOW(),
	CONSTRAINT shared_store_pk PRIMARY KEY (domain, key)
);
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('20.16.0', '2022-05-16', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
