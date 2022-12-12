-- Deployment file for version 22.0.0
--     as of 2022-12-12
-- ./changes/ocd-4012.sql
drop table if exists openchpl.surveillance_nonconformity_document;

drop table if exists openchpl.pending_surveillance_validation;
drop table if exists openchpl.pending_surveillance_nonconformity;
drop table if exists openchpl.pending_surveillance_requirement;
drop table if exists openchpl.pending_surveillance;

delete from openchpl.questionable_activity_trigger where name = 'Removed Non-Conformity added to Surveillance';
delete from openchpl.questionable_activity_trigger where name = 'Removed Requirement added to Surveillance';
;
-- ./changes/ocd-4013.sql
UPDATE openchpl.complainant_type
SET name = 'Other'
WHERE name = 'Other - [Please Describe]';

UPDATE openchpl.complainant_type
SET name = 'Third Party Organization'
WHERE name = 'Third  Party Organization';
;
-- ./changes/ocd-4071.sql
-- Expect to select 10
select distinct cpd.certified_product_id
from openchpl.certified_product cpd
join openchpl.cqm_result cqmRes on cqmRes.certified_product_id = cpd.certified_product_id and cqmRes.deleted = false
join openchpl.cqm_result_criteria cqmResCrit on cqmResCrit.cqm_result_id = cqmRes.cqm_result_id and cqmResCrit.deleted =false
join openchpl.certification_result cr on cr.certified_product_id = cpd.certified_product_id and cr.success = true and cr.deleted = false
where cpd.deleted = false
and cqmResCrit.certification_criterion_id = 27
and cr.certification_criterion_id = 172;

-- Expect to select 0
select distinct cpd.certified_product_id
from openchpl.certified_product cpd
join openchpl.cqm_result cqmRes on cqmRes.certified_product_id = cpd.certified_product_id and cqmRes.deleted = false
join openchpl.cqm_result_criteria cqmResCrit on cqmResCrit.cqm_result_id = cqmRes.cqm_result_id and cqmResCrit.deleted =false
join openchpl.certification_result cr on cr.certified_product_id = cpd.certified_product_id and cr.success = true and cr.deleted = false
where cpd.deleted = false
and cqmResCrit.certification_criterion_id = 172
and cr.certification_criterion_id = 27;

-- Expect 340 rows affected (10 listings with many CQMs each)
UPDATE openchpl.cqm_result_criteria
SET certification_criterion_id = 172
WHERE cqm_result_criteria_id IN (
	select distinct cqmResCrit.cqm_result_criteria_id
	from openchpl.certified_product cpd
	join openchpl.cqm_result cqmRes on cqmRes.certified_product_id = cpd.certified_product_id and cqmRes.deleted = false
	join openchpl.cqm_result_criteria cqmResCrit on cqmResCrit.cqm_result_id = cqmRes.cqm_result_id and cqmResCrit.deleted =false
	join openchpl.certification_result cr on cr.certified_product_id = cpd.certified_product_id and cr.success = true and cr.deleted = false
	where cpd.deleted = false
	and cqmResCrit.certification_criterion_id = 27
	and cr.certification_criterion_id = 172
);

-- Expect to select 0
select distinct cpd.certified_product_id
from openchpl.certified_product cpd
join openchpl.cqm_result cqmRes on cqmRes.certified_product_id = cpd.certified_product_id and cqmRes.deleted = false
join openchpl.cqm_result_criteria cqmResCrit on cqmResCrit.cqm_result_id = cqmRes.cqm_result_id and cqmResCrit.deleted =false
join openchpl.certification_result cr on cr.certified_product_id = cpd.certified_product_id and cr.success = true and cr.deleted = false
where cpd.deleted = false
and cqmResCrit.certification_criterion_id = 27
and cr.certification_criterion_id = 172;

-- Expect to select 0
select distinct cpd.certified_product_id
from openchpl.certified_product cpd
join openchpl.cqm_result cqmRes on cqmRes.certified_product_id = cpd.certified_product_id and cqmRes.deleted = false
join openchpl.cqm_result_criteria cqmResCrit on cqmResCrit.cqm_result_id = cqmRes.cqm_result_id and cqmResCrit.deleted =false
join openchpl.certification_result cr on cr.certified_product_id = cpd.certified_product_id and cr.success = true and cr.deleted = false
where cpd.deleted = false
and cqmResCrit.certification_criterion_id = 172
and cr.certification_criterion_id = 27;
;
-- ./changes/ocd-4079.sql
ALTER TABLE openchpl.ehr_certification_id
DROP CONSTRAINT IF EXISTS unique_year_key;

ALTER TABLE openchpl.ehr_certification_id
DROP COLUMN IF EXISTS key CASCADE;;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('22.0.0', '2022-12-12', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
