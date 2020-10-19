-- Deployment file for version 19.7.0
--     as of 2020-10-19
-- ocd-3393.sql
-- This needs to be dropped because the may have been updated to include the old names for
-- the RWT fields.
DROP VIEW IF EXISTS openchpl.certified_product_details CASCADE;

ALTER TABLE openchpl.certified_product
DROP COLUMN IF EXISTS rwt_plan_url;

ALTER TABLE openchpl.certified_product
DROP COLUMN IF EXISTS rwt_plan_submission_date;

ALTER TABLE openchpl.certified_product
DROP COLUMN IF EXISTS rwt_results_submission_date;

ALTER TABLE openchpl.certified_product
ADD COLUMN IF NOT EXISTS rwt_plans_url text NULL;

ALTER TABLE openchpl.certified_product
ADD COLUMN IF NOT EXISTS rwt_plans_check_date date NULL;

ALTER TABLE openchpl.certified_product
ADD COLUMN IF NOT EXISTS rwt_results_url text NULL;

ALTER TABLE openchpl.certified_product
ADD COLUMN IF NOT EXISTS rwt_results_check_date date NULL;

insert into openchpl.questionable_activity_trigger
(name, level, last_modified_user)
select 'Real World Testing Removed', 'Listing', -1
where not exists (select * from openchpl.questionable_activity_trigger where name = 'Real World Testing Removed' and level ='Listing');

insert into openchpl.url_type
(name, last_modified_user)
select 'Real World Testing Plans', -1
where not exists (select * from openchpl.url_type where name = 'Real World Testing Plans');

insert into openchpl.url_type
(name, last_modified_user)
select 'Real World Testing Results', -1
where not exists (select * from openchpl.url_type where name = 'Real World Testing Results');
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('19.7.0', '2020-10-19', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
