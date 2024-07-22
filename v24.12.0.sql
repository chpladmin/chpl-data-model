-- Deployment file for version 24.12.0
--     as of 2024-07-22
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('24.12.0', '2024-07-22', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
