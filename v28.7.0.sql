-- Deployment file for version 28.7.0
--     as of 2026-06-22
-- ./changes/ocd-5304.sql
ALTER TABLE openchpl.report_metadata ALTER COLUMN report_key DROP NOT NULL;

UPDATE openchpl.report_metadata
SET title = 'Service Base URL List'
WHERE title = 'Service Base URL List Report';

UPDATE openchpl.report_metadata
SET title = 'Non-conformity Counts'
WHERE title = 'Non-Conformity Counts';

UPDATE openchpl.report_metadata
SET title = 'Real World Testing'
WHERE title = 'Real World Testing Summary';

UPDATE openchpl.report_metadata
SET title = 'Non-conformities'
WHERE title = 'Non-Conformities';;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('28.7.0', '2026-06-22', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
