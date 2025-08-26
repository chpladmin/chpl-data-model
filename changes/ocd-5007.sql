RAISE NOTICE 'Below are all the listing IDs that attest to g10 and use the test data ONC Test Method';
select cr.certified_product_id
from openchpl.certified_product_details cpd 
join openchpl.certification_result cr on cr.certified_product_id = cpd.certified_product_id
join openchpl.certification_result_test_data crtd on cr.certification_result_id = crtd.certification_result_id
where cr.certification_criterion_id = 182
and crtd.test_data_id = 1
and cr.deleted = false
and crtd.deleted = false
and cr.success = true;

--
-- Remove cert result+test data mappings if the attested criteria is g10
--
DELETE FROM openchpl.certification_result_test_data
WHERE certification_result_id IN 
	(SELECT certification_result_id 
	FROM openchpl.certification_result 
	WHERE success = true 
	AND deleted = FALSE 
	AND certification_criterion_id = 182)

--
-- Remove test data mappings for g10
--
DELETE FROM openchpl.test_data_criteria_map
WHERE criteria_id = 182;

--
-- Remove test data Drummond G10+ FHIR API powered by Touchstone
--
DELETE FROM openchpl.test_data
WHERE id = 5;

-- 
-- Update g10 to not be allowed to have test data
--
UPDATE openchpl.certification_criterion_attribute
SET test_data = FALSE
WHERE criteria_id = 182;
