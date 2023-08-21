-- Deployment file for version 23.13.0
--     as of 2023-08-21
-- ./changes/ocd-4297.sql
ALTER TABLE openchpl.subscriber ALTER COLUMN subscriber_role_id DROP NOT NULL;
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('23.13.0', '2023-08-21', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
