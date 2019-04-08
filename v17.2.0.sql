-- Deployment file for version 17.2.0
--     as of 2019-04-08
-- ocd-2809.sql
ALTER TABLE openchpl.pending_certified_product DROP COLUMN IF EXISTS error_count;
ALTER TABLE openchpl.pending_certified_product DROP COLUMN IF EXISTS warning_count;

ALTER TABLE openchpl.pending_certified_product ADD COLUMN error_count int;
ALTER TABLE openchpl.pending_certified_product ADD COLUMN warning_count int;;
-- ocd-2797.sql
update openchpl.activity_concept set concept='PENDING_SURVEILLANCE' where concept='PENDING SURVEILLANCE';
 
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('17.2.0', '2019-04-08', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
