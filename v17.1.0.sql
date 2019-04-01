-- Deployment file for version 17.1.0
--     as of 2019-04-01
-- ocd-2825.sql
---------------------------------------
-- OCD-2825
---------------------------------------
update openchpl.certification_status set deleted = true where certification_status = 'Pending';

-- remove certification status reference from pending listing table
ALTER TABLE openchpl.pending_certified_product DROP COLUMN IF EXISTS certification_status_id;;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('17.1.0', '2019-04-01', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
