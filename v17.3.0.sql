-- Deployment file for version 17.3.0
--     as of 2019-05-08
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('17.3.0', '2019-05-08', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
