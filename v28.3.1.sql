-- Deployment file for version 28.3.1
--     as of 2026-02-04
-- ./changes/ocd-5097.sql
--
-- Remove all calculated updated criteria status data from before the ticket OCD-5059
-- was deployed to prod and the first overnight calculation job ran after that deployment.
-- The calculated data was not entirely correct up until that ticket was deployed to production.
--
DELETE FROM openchpl.updated_criterion_status_report
WHERE report_day < '2025-12-23';
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('28.3.1', '2026-02-04', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
