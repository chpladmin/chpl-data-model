-- Deployment file for version 27.3.1
--     as of 2025-07-07
-- ./changes/ocd-4889.sql
UPDATE openchpl.report_metadata
SET height = '2800px'
WHERE title = 'Criteria Attributes';

;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('27.3.1', '2025-07-07', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
