-- Deployment file for version 24.6.1
--     as of 2024-02-20
-- ./changes/ocd-4478.sql
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 210;
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('24.6.1', '2024-02-20', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
