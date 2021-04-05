-- Deployment file for version 19.13.2
--     as of 2021-04-05
-- ./changes/ocd-3627.sql
UPDATE openchpl.upload_template_version
SET deleted = true
WHERE name = '2015 CHPL Upload Template v18';
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('19.13.2', '2021-04-05', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
