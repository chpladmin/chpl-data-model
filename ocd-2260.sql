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
