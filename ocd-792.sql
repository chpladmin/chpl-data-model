UPDATE openchpl.education_type
SET name = 'Doctorate degree (e.g., MD, DNP, DMD, PhD)'
WHERE name = 'Doctorate degree';

UPDATE openchpl.test_participant
SET education_type_id = (SELECT education_type_id from openchpl.education_type WHERE name = 'Doctorate degree (e.g., MD, DNP, DMD, PhD)')
WHERE education_type_id = (SELECT education_type_id from openchpl.education_type WHERE name = 'Professional degree (MD, DO, DMD)');

UPDATE openchpl.pending_test_participant
SET education_type_id = (SELECT education_type_id from openchpl.education_type WHERE name = 'Doctorate degree (e.g., MD, DNP, DMD, PhD)')
WHERE education_type_id = (SELECT education_type_id from openchpl.education_type WHERE name = 'Professional degree (MD, DO, DMD)');

UPDATE openchpl.test_task_result
SET education_type_id = (SELECT education_type_id from openchpl.education_type WHERE name = 'Doctorate degree (e.g., MD, DNP, DMD, PhD)')
WHERE education_type_id = (SELECT education_type_id from openchpl.education_type WHERE name = 'Professional degree (MD, DO, DMD)');

DELETE FROM openchpl.education_type
WHERE name = 'Professional degree (MD, DO, DMD)';