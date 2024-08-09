-- Deployment file for version 25.0.0
--     as of 2024-08-05
-- ./changes/ocd-4625.sql
DROP TABLE IF EXISTS openchpl.cures_criterion_upgraded_without_original_listing_statistic;
DROP TABLE IF EXISTS openchpl.criterion_upgraded_from_original_listing_statistic;
DROP TABLE IF EXISTS openchpl.criterion_listing_statistic;
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('25.0.0', '2024-08-05', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
