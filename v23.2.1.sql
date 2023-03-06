-- Deployment file for version 23.2.1
--     as of 2023-03-06
-- ./changes/ocd-4050.sql
-- remove the developers with no listings

UPDATE openchpl.vendor
SET deleted = true
WHERE vendor_id IN (710, 1645, 937, 1464, 1644, 34, 1744, 647);
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('23.2.1', '2023-03-06', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
