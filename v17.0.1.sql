-- Deployment file for version 17.0.1
--     as of 2019-03-28
-- ocd-2825.sql
---------------------------------------
-- OCD-2825
---------------------------------------
update openchpl.certification_status set deleted = true where certification_status = 'Pending';
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('17.0.1', '2019-03-28', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
