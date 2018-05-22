--
-- OCD-2226: Clean up Test Tools
--

-- Consolidate all Direct Certificate Discovery Tool + 2015 Direct Certificate Discovery Tool to "Direct Certificate Discovery Tool"
update openchpl.test_tool tt
set deleted = true
where tt.test_tool_id > (select min(test_tool_id) from openchpl.test_tool tt where tt.name like '%Direct Certificate Discovery Tool%' and tt.deleted = false)
and tt.name like '%Direct Certificate Discovery Tool%';

update openchpl.certification_result_test_tool
set test_tool_id = (select min(test_tool_id) from openchpl.test_tool tt where tt.name like '%Direct Certificate Discovery Tool%' and tt.deleted = false)
where test_tool_id = any(select test_tool_id from openchpl.test_tool tt where tt.name like '%Direct Certificate Discovery Tool%' and tt.deleted = true);

update openchpl.pending_certification_result_test_tool
set test_tool_id = (select min(test_tool_id) from openchpl.test_tool tt where tt.name like '%Direct Certificate Discovery Tool%' and tt.deleted = false)
where test_tool_id = any(select test_tool_id from openchpl.test_tool tt where tt.name like '%Direct Certificate Discovery Tool%' and tt.deleted = true);

-- Consolidate HL7 v2 Electronic Laboratory Reporting (ELR) Validation Tool (x2) and HL7 v2 Electronic Laboratory Reporting Validation Tool to "HL7 v2 Electronic Laboratory Reporting (ELR) Validation Tool"
update openchpl.test_tool tt
set deleted = true
where tt.test_tool_id > (select min(test_tool_id) from openchpl.test_tool tt where tt.name like '%Electronic Laboratory Reporting%' and tt.deleted = false)
and tt.name like '%Electronic Laboratory Reporting%';

update openchpl.certification_result_test_tool
set test_tool_id = (select min(test_tool_id) from openchpl.test_tool tt where tt.name like '%Electronic Laboratory Reporting%' and tt.deleted = false)
where test_tool_id = any(select test_tool_id from openchpl.test_tool tt where tt.name like '%Electronic Laboratory Reporting%' and tt.deleted = true);

update openchpl.pending_certification_result_test_tool
set test_tool_id = (select min(test_tool_id) from openchpl.test_tool tt where tt.name like '%Electronic Laboratory Reporting%' and tt.deleted = false)
where test_tool_id = any(select test_tool_id from openchpl.test_tool tt where tt.name like '%Electronic Laboratory Reporting%' and tt.deleted = true);

-- "Electronic Prescribing" + "ePrescribing Validation Tool" = "Electronic Prescribing"
update openchpl.test_tool tt
set deleted = true
where tt.test_tool_id = 1;

update openchpl.certification_result_test_tool
set test_tool_id = 13
where test_tool_id = 1;

update openchpl.pending_certification_result_test_tool
set test_tool_id = 13
where test_tool_id = 1;

-- "Transport Test Tool" + "Transport Testing Tool" = "Transport Testing Tool"
update openchpl.test_tool tt
set deleted = true
where tt.test_tool_id = 15;

update openchpl.certification_result_test_tool
set test_tool_id = 7
where test_tool_id = 15;

update openchpl.pending_certification_result_test_tool
set test_tool_id = 7
where test_tool_id = 15;

-- "Healthcare Associated Infections (HAI) Validator" -> CDC's NHSN CDA Validator
-- "Edge Test Tool" -> "Edge Testing Tool"
update openchpl.test_tool tt
set name = 'CDC''s NHSN CDA Validator'
where test_tool_id = 24;
update openchpl.test_tool tt
set name = 'Edge Testing Tool'
where test_tool_id = 16;

----
-- OCD-2260 - Add new activity concept and change relevant activity
--

INSERT INTO openchpl.activity_concept(
	activity_concept_id, concept, last_modified_user)
--cannot use the bigserial sequence here because all preloaded concepts declared the ID
SELECT 15, 'CORRECTIVE_ACTION_PLAN', -1 
	WHERE NOT EXISTS (SELECT 1 FROM openchpl.activity_concept WHERE concept = 'CORRECTIVE_ACTION_PLAN');
	
UPDATE openchpl.activity
SET activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept where concept = 'CORRECTIVE_ACTION_PLAN')
WHERE UPPER(description) LIKE '%CORRECTIVE ACTION PLAN%';

