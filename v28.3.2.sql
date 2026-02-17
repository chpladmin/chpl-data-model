-- Deployment file for version 28.3.2
--     as of 2026-02-17
-- ./changes/ocd-4971.sql
--
-- Move all "instructions" to the instructions field
-- Some of them were hardcoded in the UI but they can all go here and allow us 
-- to have varying instructions per attestation period over time.
--
UPDATE openchpl.form
SET instructions = E'As a health IT developer of certified health IT that had an active certification under the ONC Health IT Certification Program at any time during the Attestation Period, please indicate your compliance, noncompliance, or the inapplicability of each Condition and Maintenance of Certification requirement for the portion of the Attestation Period you had an active certification.\n\nSelect only one response for each statement.'
WHERE id = 1;

UPDATE openchpl.form
SET instructions = E'As a health IT developer of certified health IT that had an active certification under the ONC Health IT Certification Program at any time during the Attestation Period, please indicate your compliance, noncompliance, or the inapplicability of each Condition and Maintenance of Certification requirement for the portion of the Attestation Period you had an active certification.\n\nSelect only one response for each statement.\n\nIf "Noncompliant" is selected, you may, but are not required to, indicate the status of a Corrective Action Plan (CAP) under the Certification Program.'
WHERE id = 2;

UPDATE openchpl.form
SET instructions = E'As a health IT developer of certified health IT that had an active certification under the ONC Health IT Certification Program at any time during the Attestation Period, please indicate your compliance, noncompliance, or the inapplicability of each Condition and Maintenance of Certification requirement for the portion of the Attestation Period you had an active certification.\n\nSelect only one response for each statement.\n\nIf "Noncompliant" is selected, you may, but are not required to, indicate the status of a Corrective Action Plan (CAP) under the Certification Program.'
WHERE id = 3;

UPDATE openchpl.form
SET instructions = E'As a health IT developer of certified health IT that had an active certification under the ONC Health IT Certification Program at any time during the Attestation Period, please indicate your compliance, noncompliance, or the inapplicability of each Condition and Maintenance of Certification requirement for the portion of the Attestation Period you had an active certification.\n\nSelect only one response for each statement.\n\nIf "Noncompliant" is selected, you may, but are not required to, indicate the status of a Corrective Action Plan (CAP) under the Certification Program.'
WHERE id = 4;

INSERT INTO openchpl.form (description, instructions, last_modified_sso_user)
SELECT 'Attestation Period 2025-10-01 to 2026-03-31', 
	E'Developers that had an active certification under the ONC Health IT Certification Program at any time during the Attestation Period, please indicate your compliance, noncompliance, or the inapplicability of each Condition and Maintenance of Certification requirement for the portion of the Attestation Period you had an active certification.\n\nSelect only one response for each statement.\n\nIf "Noncompliant" is selected, you may, but are not required to, indicate the status of a Corrective Action Plan (CAP) under the Certification Program.',
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.form WHERE description = 'Attestation Period 2025-10-01 to 2026-03-31'
);

-- 
-- create the new form
--
INSERT INTO openchpl.form (description, instructions, last_modified_sso_user)
SELECT 'Attestation Period 2025-10-01 to 2026-03-31', 
	'If "Noncompliant" is selected, you may, but are not required to, indicate the status of a Corrective Action Plan (CAP) under the Certification Program.',
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.form WHERE description = 'Attestation Period 2025-10-01 to 2026-03-31'
);

--
-- add the newly worded RWT question
-- Note the 'E' at the beginning of the question, this is needed to properly escape the newline character in the question
--
INSERT INTO openchpl.question (question, response_cardinality_type_id, section_heading_id, last_modified_sso_user)
SELECT E'On June 30, 2025 ASTP issued the [Real World Testing Condition and Maintenance of Certification Requirements Enforcement Discretion Notice](https://www.healthit.gov/topic/real-world-testing-condition-and-maintenance-certification-requirements-enforcement). Please note that this enforcement discretion impacts Real World Testing requirements for this Attestation period.\n\nWe attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in [45 CFR 170.405](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.405).',
	1,
	4,
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.question WHERE
	question LIKE 'On June 30, 2025%impacts Real World Testing%'
);

-- 
-- add allowed responses to the new RWT question
--
INSERT INTO openchpl.question_allowed_response_map (question_id, allowed_response_id, sort_order, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.question where question LIKE 'On June 30, 2025%impacts Real World Testing%'),
	1,
	10, 
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.question_allowed_response_map
	WHERE question_id = (SELECT id FROM openchpl.question where question LIKE 'On June 30, 2025%impacts Real World Testing%')
	AND allowed_response_id = 1
);

INSERT INTO openchpl.question_allowed_response_map (question_id, allowed_response_id, sort_order, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.question where question LIKE 'On June 30, 2025%impacts Real World Testing%'),
	2,
	20, 
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.question_allowed_response_map
	WHERE question_id = (SELECT id FROM openchpl.question where question LIKE 'On June 30, 2025%impacts Real World Testing%')
	AND allowed_response_id = 2
);

INSERT INTO openchpl.question_allowed_response_map (question_id, allowed_response_id, sort_order, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.question where question LIKE 'On June 30, 2025%impacts Real World Testing%'),
	3,
	30, 
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.question_allowed_response_map
	WHERE question_id = (SELECT id FROM openchpl.question where question LIKE 'On June 30, 2025%impacts Real World Testing%')
	AND allowed_response_id = 3
);

--
-- add form items to the form that reference the existing questions plus the newly worded RWT question
--
INSERT INTO openchpl.form_item (form_id, question_id, parent_form_item_id, parent_response_id, sort_order, required, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-10-01 to 2026-03-31'),
	1,
	NULL,
	NULL,
	1,
	true,
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.form_item
	WHERE form_id = (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-10-01 to 2026-03-31')
	AND question_id = 1
);

INSERT INTO openchpl.form_item (form_id, question_id, parent_form_item_id, parent_response_id, sort_order, required, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-10-01 to 2026-03-31'),
	7,
	NULL,
	NULL,
	2,
	true,
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.form_item
	WHERE form_id = (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-10-01 to 2026-03-31')
	AND question_id = 7
);

INSERT INTO openchpl.form_item (form_id, question_id, parent_form_item_id, parent_response_id, sort_order, required, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-10-01 to 2026-03-31'),
	3,
	NULL,
	NULL,
	3,
	true,
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.form_item
	WHERE form_id = (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-10-01 to 2026-03-31')
	AND question_id = 3
);

INSERT INTO openchpl.form_item (form_id, question_id, parent_form_item_id, parent_response_id, sort_order, required, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-10-01 to 2026-03-31'),
	4,
	NULL,
	NULL,
	4,
	true,
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.form_item
	WHERE form_id = (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-10-01 to 2026-03-31')
	AND question_id = 4
);

INSERT INTO openchpl.form_item (form_id, question_id, parent_form_item_id, parent_response_id, sort_order, required, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-10-01 to 2026-03-31'),
	(SELECT id FROM openchpl.question WHERE question LIKE 'On June 30, 2025%impacts Real World Testing%'),
	NULL,
	NULL,
	5,
	true,
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.form_item
	WHERE form_id = (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-10-01 to 2026-03-31')
	AND question_id = (SELECT id FROM openchpl.question WHERE question LIKE 'On June 30, 2025%impacts Real World Testing%')
);

INSERT INTO openchpl.form_item (form_id, question_id, parent_form_item_id, parent_response_id, sort_order, required, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-10-01 to 2026-03-31'),
	6,
	(SELECT id FROM openchpl.form_item WHERE form_id = (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-10-01 to 2026-03-31') AND question_id = 1),
	2,
	1,
	false,
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.form_item
	WHERE form_id = (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-10-01 to 2026-03-31')
	AND parent_form_item_id = 	(SELECT id FROM openchpl.form_item WHERE form_id = (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-10-01 to 2026-03-31') AND question_id = 1)
	AND question_id = 6
);

INSERT INTO openchpl.form_item (form_id, question_id, parent_form_item_id, parent_response_id, sort_order, required, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-10-01 to 2026-03-31'),
	6,
	(SELECT id FROM openchpl.form_item WHERE form_id = (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-10-01 to 2026-03-31') AND question_id = 7),
	2,
	1,
	false,
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.form_item
	WHERE form_id = (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-10-01 to 2026-03-31')
	AND parent_form_item_id = 	(SELECT id FROM openchpl.form_item WHERE form_id = (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-10-01 to 2026-03-31') AND question_id = 7)
	AND question_id = 6
);

INSERT INTO openchpl.form_item (form_id, question_id, parent_form_item_id, parent_response_id, sort_order, required, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-10-01 to 2026-03-31'),
	6,
	(SELECT id FROM openchpl.form_item WHERE form_id = (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-10-01 to 2026-03-31') AND question_id = 3),
	2,
	1,
	false,
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.form_item
	WHERE form_id = (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-10-01 to 2026-03-31')
	AND parent_form_item_id = 	(SELECT id FROM openchpl.form_item WHERE form_id = (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-10-01 to 2026-03-31') AND question_id = 3)
	AND question_id = 6
);

INSERT INTO openchpl.form_item (form_id, question_id, parent_form_item_id, parent_response_id, sort_order, required, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-10-01 to 2026-03-31'),
	6,
	(SELECT id FROM openchpl.form_item WHERE form_id = (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-10-01 to 2026-03-31') AND question_id = 4),
	2,
	1,
	false,
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.form_item
	WHERE form_id = (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-10-01 to 2026-03-31')
	AND parent_form_item_id = 	(SELECT id FROM openchpl.form_item WHERE form_id = (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-10-01 to 2026-03-31') AND question_id = 4)
	AND question_id = 6
);

INSERT INTO openchpl.form_item (form_id, question_id, parent_form_item_id, parent_response_id, sort_order, required, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-10-01 to 2026-03-31'),
	6,
	(SELECT id FROM openchpl.form_item WHERE form_id = 
		(SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-10-01 to 2026-03-31') 
		AND question_id = (SELECT id FROM openchpl.question WHERE question LIKE 'On June 30, 2025%impacts Real World Testing%')),
	2,
	1,
	false,
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.form_item
	WHERE form_id = (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-10-01 to 2026-03-31')
	AND parent_form_item_id = 	(SELECT id FROM openchpl.form_item WHERE form_id = 
		(SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-10-01 to 2026-03-31') 
		AND question_id = (SELECT id FROM openchpl.question WHERE question LIKE 'On June 30, 2025%impacts Real World Testing%'))
	AND question_id = 6
);

--
-- associate the form with the next attestation Period
-- and may as well associate it with all the future attestation periods too even though that will change again
--
UPDATE openchpl.attestation_period
SET form_id = (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-10-01 to 2026-03-31')
WHERE id >= 10;;
-- ./changes/ocd-5064.sql
UPDATE openchpl.certification_criterion_attribute
SET code_set = TRUE
WHERE criterion_id = 167; --b3
;
-- ./changes/ocd-5089.sql
UPDATE openchpl.report_metadata
SET height = '800px'
WHERE title = 'Developer Attestations';

UPDATE openchpl.report_metadata
SET height = '1350px'
WHERE title = 'Developer Statistics';

UPDATE openchpl.report_metadata
SET height = '800px'
WHERE title = 'Direct Review Statistics';

UPDATE openchpl.report_metadata
SET height = '1400px'
WHERE title = 'Product Statistics';
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('28.3.2', '2026-02-17', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
