-- Deployment file for version 19.0.0
--     as of 2020-03-09
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('19.0.0', '2020-03-09', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql