ALTER TABLE openchpl.certified_product
ADD COLUMN IF NOT EXISTS rwt_plan_url text NULL;

ALTER TABLE openchpl.certified_product
ADD COLUMN IF NOT EXISTS rwt_plan_submission_date date NULL;

ALTER TABLE openchpl.certified_product
ADD COLUMN IF NOT EXISTS rwt_results_url text NULL;

ALTER TABLE openchpl.certified_product
ADD COLUMN IF NOT EXISTS rwt_results_submission_date date NULL;

insert into openchpl.questionable_activity_trigger
(name, level, last_modified_user)
select 'Real World Testing Removed', 'Listing', -1
where not exists (select * from openchpl.questionable_activity_trigger where name = 'Real World Testing Removed' and level ='Listing');