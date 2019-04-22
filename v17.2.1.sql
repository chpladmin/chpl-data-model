-- Deployment file for version 17.2.1
--     as of 2019-04-22
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('17.2.1', '2019-04-22', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
