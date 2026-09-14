-- Deployment file for version 28.9.0
--     as of 2026-09-14
-- ./changes/ocd-5417.sql
UPDATE openchpl.report_metadata
SET title = 'Surveillance Non-conformities'
WHERE title = 'Non-conformities'
AND report_group = 'onc-dashboard';
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('28.9.0', '2026-09-14', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
