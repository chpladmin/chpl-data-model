-- Deployment file for version 20.16.1
--     as of 2022-05-31
-- ./changes/ocd-3921.sql
UPDATE openchpl.deprecated_api
SET deleted = true
WHERE removal_date = '04-15-2022'
and api_operation = '/meaningful_use/upload';

UPDATE openchpl.deprecated_response_field
SET deleted = true
WHERE removal_date = '04-15-2022'
AND response_field = 'meaningfulUseUserHistory';
;
-- ./changes/ocd-3923.sql
UPDATE openchpl.deprecated_api
SET deleted = true
WHERE http_method = 'DELETE'
and api_operation = '/listings/pending';;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('20.16.1', '2022-05-31', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
