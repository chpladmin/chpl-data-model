select cr.certified_product_id
from openchpl.certified_product_details cpd 
join openchpl.certification_result cr on cr.certified_product_id = cpd.certified_product_id
join openchpl.certification_result_code_Set crcs on cr.certification_result_id = crcs.certification_result_id
where cr.certification_criterion_id = 167
and cr.deleted = false
and crcs.deleted = false
and cr.success = true;

--
-- Remove cert result+code set mappings if the attested criteria is b3
--
DELETE FROM openchpl.certification_result_code_set
WHERE certification_result_id IN 
	(SELECT certification_result_id 
	FROM openchpl.certification_result 
	WHERE success = true 
	AND deleted = FALSE 
	AND certification_criterion_id = 167);

--
-- Remove code set mappings for b3
--
DELETE FROM openchpl.code_set_criteria_map
WHERE certification_criterion_id = 167;

-- 
-- Update b3 to not be allowed to have code sets
--
UPDATE openchpl.certification_criterion_attribute
SET code_set = FALSE
WHERE criterion_id = 167;

--
-- Delete results about b3 not being up-to-date 
-- (this works because the ONLY reason b3 could not be up-to-date at this time is because of code sets)
--
DELETE FROM openchpl.updated_criterion_status_report ucsr
USING openchpl.certification_result cr
WHERE ucsr.certification_result_id = cr.certification_result_id
AND cr.certification_criterion_id = 167;

