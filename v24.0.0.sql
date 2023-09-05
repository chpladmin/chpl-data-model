-- Deployment file for version 24.0.0
--     as of 2023-09-05
-- ./changes/ocd-3959.sql
drop table if exists openchpl.cures_criteria_statistics_by_acb;
drop table if exists openchpl.cures_listing_statistics_by_acb;
drop table if exists openchpl.listing_cures_status_statistic;
drop table if exists openchpl.listing_to_criterion_for_cures_achievement_statistic;
drop table if exists openchpl.privacy_and_security_listing_statistic;

;
-- ./changes/ocd-4269.sql
-- Drop criteria columns that are not useful
ALTER TABLE openchpl.certification_criterion DROP COLUMN IF EXISTS automated_numerator_capable;
ALTER TABLE openchpl.certification_criterion DROP COLUMN IF EXISTS automated_measure_capable;
ALTER TABLE openchpl.certification_criterion DROP COLUMN IF EXISTS requires_sed;
ALTER TABLE openchpl.certification_criterion DROP COLUMN IF EXISTS parent_criterion_id;

-- Make edition nullable to certified products
ALTER TABLE openchpl.certified_product ALTER COLUMN certification_edition_ID DROP NOT NULL;;
-- ./changes/ocd-4272.sql
alter table openchpl.certification_criterion add column if not exists start_day date;

alter table openchpl.certification_criterion add column if not exists end_day date;

alter table openchpl.certification_criterion add column if not exists rule_id bigint;

alter table openchpl.certification_criterion drop constraint if exists rule_fk;
alter table openchpl.certification_criterion add constraint rule_fk foreign key (rule_id)
    references openchpl.rule (id)
    match simple on update no action on delete restrict;
	
-- fill in the rules
UPDATE openchpl.certification_criterion
SET rule_id = (SELECT id FROM openchpl.rule WHERE name = '2011')
WHERE number LIKE '170.30%';

UPDATE openchpl.certification_criterion
SET rule_id = (SELECT id FROM openchpl.rule WHERE name = '2014')
WHERE number LIKE '170.314%';

UPDATE openchpl.certification_criterion
SET rule_id = (SELECT id FROM openchpl.rule WHERE name = '2015')
WHERE number LIKE '170.315%' and title NOT LIKE '%Cures Update%';

UPDATE openchpl.certification_criterion
SET rule_id = (SELECT id FROM openchpl.rule WHERE name = 'Cures')
WHERE number LIKE '170.315%' and title LIKE '%Cures Update%';

--
-- fix criteria attributes that are incorrectly showing for certain criteria
--

-- No 2015 criteria should have test procedures
UPDATE openchpl.certification_criterion_attribute
SET test_procedure = FALSE
WHERE criterion_id <= 60 OR criterion_id >= 165;
;
-- ./changes/ocd-4292.sql
update openchpl.measure set removed = true where id in (12, 14, 20, 22, 28, 30);
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('24.0.0', '2023-09-05', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
