-- Deployment file for version 20.13.0
--     as of 2022-03-07
-- ./changes/ocd-3824.sql
-- change email address for jira api key
UPDATE openchpl.api_key
SET email = 'CSrinadhu@ainq.com',
name_organization = 'Ai Jira Team'
WHERE api_key_id = 605;

-- delete data from deprecated response field table
UPDATE openchpl.deprecated_response_field
SET deleted = TRUE
WHERE removal_date = '2022-03-01';

-- delete views 
DROP VIEW IF EXISTS openchpl.acb_developer_transparency_mappings;
DROP VIEW IF EXISTS openchpl.developers_with_attestations;
DROP VIEW IF EXISTS openchpl.certified_product_details;

-- delete tables
DROP TABLE IF EXISTS openchpl.acb_vendor_map;
ALTER TABLE openchpl.pending_certified_product DROP COLUMN IF EXISTS vendor_transparency_attestation;

-- delete columns
DROP TYPE IF EXISTS openchpl.transparency_attestation;
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('20.13.0', '2022-03-07', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
