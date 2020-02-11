-- Deployment file for version 18.2.0
--     as of 2020-02-11
-- ocd-3234.sql
alter table openchpl.vendor drop column if exists self_developer cascade;
alter table openchpl.vendor add column self_developer bool not null default false;
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('18.2.0', '2020-02-11', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
