-- Deployment file for version 27.4.2
--     as of 2025-09-29
-- ./changes/ocd-5011.sql
\echo 'Listings attesting to b3 with Dec-25 code set';
select cr.certified_product_id
from openchpl.certified_product_details cpd 
join openchpl.certification_result cr on cr.certified_product_id = cpd.certified_product_id
join openchpl.certification_result_code_Set crcs on cr.certification_result_id = crcs.certification_result_id
where cr.certification_criterion_id = 167
and cr.deleted = false
and crcs.deleted = false
and cr.success = true;

\echo 'Listings attesting to removed b3 with Dec-25 code set';
select cr.certified_product_id
from openchpl.certified_product_details cpd 
join openchpl.certification_result cr on cr.certified_product_id = cpd.certified_product_id
join openchpl.certification_result_code_Set crcs on cr.certification_result_id = crcs.certification_result_id
where cr.certification_criterion_id = 18
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
-- Remove cert result+code set mappings if the attested criteria is removed b3
--
DELETE FROM openchpl.certification_result_code_set
WHERE certification_result_id IN 
	(SELECT certification_result_id 
	FROM openchpl.certification_result 
	WHERE success = true 
	AND deleted = FALSE 
	AND certification_criterion_id = 18);

--
-- Remove code set mappings for b3
--
DELETE FROM openchpl.code_set_criteria_map
WHERE certification_criterion_id = 167;

--
-- Remove code set mappings for removed b3
--
DELETE FROM openchpl.code_set_criteria_map
WHERE certification_criterion_id = 18;

-- 
-- Update b3 to not be allowed to have code sets
--
UPDATE openchpl.certification_criterion_attribute
SET code_set = FALSE
WHERE criterion_id = 167;

-- 
-- Update removed b3 to not be allowed to have code sets
--
UPDATE openchpl.certification_criterion_attribute
SET code_set = FALSE
WHERE criterion_id = 18;

--
-- Delete results about b3 not being up-to-date 
-- (this works because the ONLY reason b3 could not be up-to-date at this time is because of code sets)
--
DELETE FROM openchpl.updated_criterion_status_report ucsr
USING openchpl.certification_result cr
WHERE ucsr.certification_result_id = cr.certification_result_id
AND cr.certification_criterion_id = 167;

;
-- ./changes/ocd-5023.sql
UPDATE openchpl.measure
SET removed = true
WHERE id IN (33, 34);
;
-- ./changes/ocd-5045.sql
-- delete the listing
UPDATE openchpl.certified_product
SET deleted = true
WHERE certified_product_id = 11695;
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('27.4.2', '2025-09-29', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
