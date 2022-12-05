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
