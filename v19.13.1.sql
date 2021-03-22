-- Deployment file for version 19.13.1
--     as of 2021-03-22
-- ./changes/ocd-3323.sql
insert into openchpl.filter_type (name, last_modified_user)
select 'ONC-ATL Report', -1
where not exists (select * from openchpl.filter_type where name = 'ONC-ATL Report');

;
-- ./changes/ocd-3527.sql
-- Undelete summary stats for use in the new PDF
UPDATE openchpl.summary_statistics
SET deleted = false
WHERE end_date > '2021-01-01'::date;

;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('19.13.1', '2021-03-22', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
