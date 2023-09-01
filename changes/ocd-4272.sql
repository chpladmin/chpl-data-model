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
