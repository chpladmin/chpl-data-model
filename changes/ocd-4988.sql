-- 
-- create the new form
--
INSERT INTO openchpl.form (description, instructions, last_modified_sso_user)
SELECT 'Attestation Period 2025-04-01 to 2025-09-30', 
	'If "Noncompliant" is selected, you may, but are not required to, indicate the status of a Corrective Action Plan (CAP) under the Certification Program.',
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.form WHERE description = 'Attestation Period 2025-04-01 to 2025-09-30'
);

--
-- add the newly worded RWT question
--
INSERT INTO openchpl.question (question, response_cardinality_type_id, section_heading_id, last_modified_sso_user)
SELECT 'On June 30, 2025 ASTP issued the [Real World Testing Condition and Maintenance of Certification Requirements Enforcement Discretion Notice](https://www.healthit.gov/topic/real-world-testing-condition-and-maintenance-certification-requirements-enforcement). Please note that this enforcement discretion does not impact Real World Testing requirements for this Attestation period.\n\nWe attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in [45 CFR 170.405](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.405).',
	1,
	4,
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.question WHERE
	question LIKE 'On June 30, 2025%'
);

-- 
-- add allowed responses to the new RWT question
--
INSERT INTO openchpl.question_allowed_response_map (question_id, allowed_response_id, sort_order, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.question where question LIKE 'On June 30, 2025%'),
	1,
	10, 
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.question_allowed_response_map
	WHERE question_id = (SELECT id FROM openchpl.question where question LIKE 'On June 30, 2025%')
	AND allowed_response_id = 1
);

INSERT INTO openchpl.question_allowed_response_map (question_id, allowed_response_id, sort_order, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.question where question LIKE 'On June 30, 2025%'),
	2,
	20, 
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.question_allowed_response_map
	WHERE question_id = (SELECT id FROM openchpl.question where question LIKE 'On June 30, 2025%')
	AND allowed_response_id = 2
);

INSERT INTO openchpl.question_allowed_response_map (question_id, allowed_response_id, sort_order, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.question where question LIKE 'On June 30, 2025%'),
	3,
	30, 
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.question_allowed_response_map
	WHERE question_id = (SELECT id FROM openchpl.question where question LIKE 'On June 30, 2025%')
	AND allowed_response_id = 3
);

--
-- add form items to the form that reference the existing questions plus the newly worded RWT question
--
INSERT INTO openchpl.form_item (form_id, question_id, parent_form_item_id, parent_response_id, sort_order, required, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-04-01 to 2025-09-30'),
	1,
	NULL,
	NULL,
	1,
	true,
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.form_item
	WHERE form_id = (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-04-01 to 2025-09-30')
	AND question_id = 1
);

INSERT INTO openchpl.form_item (form_id, question_id, parent_form_item_id, parent_response_id, sort_order, required, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-04-01 to 2025-09-30'),
	7,
	NULL,
	NULL,
	2,
	true,
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.form_item
	WHERE form_id = (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-04-01 to 2025-09-30')
	AND question_id = 7
);

INSERT INTO openchpl.form_item (form_id, question_id, parent_form_item_id, parent_response_id, sort_order, required, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-04-01 to 2025-09-30'),
	3,
	NULL,
	NULL,
	3,
	true,
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.form_item
	WHERE form_id = (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-04-01 to 2025-09-30')
	AND question_id = 3
);

INSERT INTO openchpl.form_item (form_id, question_id, parent_form_item_id, parent_response_id, sort_order, required, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-04-01 to 2025-09-30'),
	4,
	NULL,
	NULL,
	4,
	true,
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.form_item
	WHERE form_id = (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-04-01 to 2025-09-30')
	AND question_id = 4
);

INSERT INTO openchpl.form_item (form_id, question_id, parent_form_item_id, parent_response_id, sort_order, required, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-04-01 to 2025-09-30'),
	(SELECT id FROM openchpl.question WHERE question LIKE 'On June 30, 2025%'),
	NULL,
	NULL,
	5,
	true,
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.form_item
	WHERE form_id = (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-04-01 to 2025-09-30')
	AND question_id = (SELECT id FROM openchpl.question WHERE question LIKE 'On June 30, 2025%')
);

INSERT INTO openchpl.form_item (form_id, question_id, parent_form_item_id, parent_response_id, sort_order, required, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-04-01 to 2025-09-30'),
	6,
	(SELECT id FROM openchpl.form_item WHERE form_id = (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-04-01 to 2025-09-30') AND question_id = 1),
	2,
	1,
	false,
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.form_item
	WHERE form_id = (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-04-01 to 2025-09-30')
	AND parent_form_item_id = 	(SELECT id FROM openchpl.form_item WHERE form_id = (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-04-01 to 2025-09-30') AND question_id = 1)
	AND question_id = 6
);

INSERT INTO openchpl.form_item (form_id, question_id, parent_form_item_id, parent_response_id, sort_order, required, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-04-01 to 2025-09-30'),
	6,
	(SELECT id FROM openchpl.form_item WHERE form_id = (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-04-01 to 2025-09-30') AND question_id = 7),
	2,
	1,
	false,
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.form_item
	WHERE form_id = (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-04-01 to 2025-09-30')
	AND parent_form_item_id = 	(SELECT id FROM openchpl.form_item WHERE form_id = (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-04-01 to 2025-09-30') AND question_id = 7)
	AND question_id = 6
);

INSERT INTO openchpl.form_item (form_id, question_id, parent_form_item_id, parent_response_id, sort_order, required, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-04-01 to 2025-09-30'),
	6,
	(SELECT id FROM openchpl.form_item WHERE form_id = (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-04-01 to 2025-09-30') AND question_id = 3),
	2,
	1,
	false,
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.form_item
	WHERE form_id = (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-04-01 to 2025-09-30')
	AND parent_form_item_id = 	(SELECT id FROM openchpl.form_item WHERE form_id = (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-04-01 to 2025-09-30') AND question_id = 3)
	AND question_id = 6
);

INSERT INTO openchpl.form_item (form_id, question_id, parent_form_item_id, parent_response_id, sort_order, required, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-04-01 to 2025-09-30'),
	6,
	(SELECT id FROM openchpl.form_item WHERE form_id = (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-04-01 to 2025-09-30') AND question_id = 4),
	2,
	1,
	false,
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.form_item
	WHERE form_id = (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-04-01 to 2025-09-30')
	AND parent_form_item_id = 	(SELECT id FROM openchpl.form_item WHERE form_id = (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-04-01 to 2025-09-30') AND question_id = 4)
	AND question_id = 6
);

INSERT INTO openchpl.form_item (form_id, question_id, parent_form_item_id, parent_response_id, sort_order, required, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-04-01 to 2025-09-30'),
	6,
	(SELECT id FROM openchpl.form_item WHERE form_id = 
		(SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-04-01 to 2025-09-30') 
		AND question_id = (SELECT id FROM openchpl.question WHERE question LIKE 'On June 30, 2025%')),
	2,
	1,
	false,
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.form_item
	WHERE form_id = (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-04-01 to 2025-09-30')
	AND parent_form_item_id = 	(SELECT id FROM openchpl.form_item WHERE form_id = 
		(SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-04-01 to 2025-09-30') 
		AND question_id = (SELECT id FROM openchpl.question WHERE question LIKE 'On June 30, 2025%'))
	AND question_id = 6
);

--
-- associate the form with the next attestation Period
-- and may as well associate it with all the future attestation periods too even though that will change again
--
UPDATE openchpl.attestation_period
SET form_id = (SELECT id FROM openchpl.form WHERE description = 'Attestation Period 2025-04-01 to 2025-09-30')
WHERE id >= 9;