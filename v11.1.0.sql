----------------------------------------
-- OCD-1408: Add activity concept for pending surveillance
----------------------------------------

BEGIN;
SELECT setval('openchpl.activity_concept_activity_concept_id_seq', (SELECT MAX(activity_concept_id) FROM openchpl.activity_concept));
WITH pendingSurveillanceConcept as (SELECT 'PENDING SURVEILLANCE'::text as concept)
INSERT INTO openchpl.activity_concept (concept, last_modified_user)
        SELECT (SELECT concept FROM pendingSurveillanceConcept), -1
	WHERE NOT EXISTS (
	    SELECT *
	            FROM openchpl.activity_concept
		            WHERE activity_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = (SELECT concept FROM pendingSurveillanceConcept))
			    );
			    END;

