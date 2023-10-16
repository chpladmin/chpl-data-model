-- Deployment file for version 24.2.0
--     as of 2023-10-16
-- ./changes/ocd-4282.sql
UPDATE openchpl.certified_product
SET svap_notice_url = NULL
WHERE svap_notice_url = '';

UPDATE openchpl.certified_product
SET report_file_location = NULL
WHERE report_file_location = '';

UPDATE openchpl.certified_product
SET mandatory_disclosures = NULL
WHERE mandatory_disclosures = '';

UPDATE openchpl.certified_product
SET sed_report_file_location = NULL
WHERE sed_report_file_location = '';

UPDATE openchpl.certified_product
SET sed_intended_user_description = NULL
WHERE sed_intended_user_description = '';

-- RWT Plans URL, RWT Results URL, ACB Certification ID have no empty ('') VALUES
;
-- ./changes/ocd-4321.sql
DROP VIEW openchpl.requirement_type;
DROP VIEW openchpl.nonconformity_type;

ALTER TABLE openchpl.certification_criterion
DROP COLUMN IF EXISTS removed;
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('24.2.0', '2023-10-16', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
