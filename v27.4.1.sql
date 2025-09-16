-- Deployment file for version 27.4.1
--     as of 2025-09-15
-- ./changes/ocd-4896.sql
INSERT INTO openchpl.cqm_version (version, last_modified_user)
SELECT 'v15', -1
WHERE NOT EXISTS (SELECT version FROM openchpl.cqm_version WHERE version = 'v15');

drop function if exists openchpl.add_version_to_cqm;

create function openchpl.add_version_to_cqm(cqm_text text, version_text text, previous_version text)
returns void
as $$
BEGIN
  INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
  SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = version_text), cc.cqm_criterion_type_id, cc.retired
  FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = previous_version
  WHERE cc.cms_id = cqm_text
  AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = version_text WHERE cc.cms_id = cqm_text);
  END;
$$ language plpgsql;

SELECT openchpl.add_version_to_cqm('CMS2', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS22', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS50', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS56', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS68', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS69', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS74', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS75', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS90', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS117', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS122', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS124', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS125', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS128', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS129', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS130', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS131', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS133', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS135', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS136', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS137', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS138', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS139', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS142', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS143', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS144', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS145', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS146', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS149', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS153', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS154', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS155', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS156', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS157', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS159', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS165', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS177', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS314', 'v3', 'v2');
SELECT openchpl.add_version_to_cqm('CMS347', 'v9', 'v8');
SELECT openchpl.add_version_to_cqm('CMS349', 'v8', 'v7');
SELECT openchpl.add_version_to_cqm('CMS645', 'v9', 'v8');
SELECT openchpl.add_version_to_cqm('CMS646', 'v6', 'v5');
SELECT openchpl.add_version_to_cqm('CMS771', 'v7', 'v6');
SELECT openchpl.add_version_to_cqm('CMS71', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS72', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS104', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS108', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS190', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS506', 'v8', 'v7');
SELECT openchpl.add_version_to_cqm('CMS529', 'v6', 'v5');
SELECT openchpl.add_version_to_cqm('CMS844', 'v6', 'v5');
SELECT openchpl.add_version_to_cqm('CMS951', 'v4', 'v3');
SELECT openchpl.add_version_to_cqm('CMS334', 'v7', 'v6');
SELECT openchpl.add_version_to_cqm('CMS816', 'v5', 'v4');
SELECT openchpl.add_version_to_cqm('CMS871', 'v5', 'v4');
SELECT openchpl.add_version_to_cqm('CMS1028', 'v4', 'v3');
SELECT openchpl.add_version_to_cqm('CMS996', 'v6', 'v5');
SELECT openchpl.add_version_to_cqm('CMS1188', 'v3', 'v2');
SELECT openchpl.add_version_to_cqm('CMS819', 'v4', 'v3');
SELECT openchpl.add_version_to_cqm('CMS986', 'v5', 'v4');
SELECT openchpl.add_version_to_cqm('CMS1056', 'v3', 'v2');
SELECT openchpl.add_version_to_cqm('CMS1157', 'v2', 'v1');
SELECT openchpl.add_version_to_cqm('CMS826', 'v3', 'v2');
SELECT openchpl.add_version_to_cqm('CMS832', 'v3', 'v2');
SELECT openchpl.add_version_to_cqm('CMS1074', 'v3', 'v2');
SELECT openchpl.add_version_to_cqm('CMS1206', 'v3', 'v2');

drop function openchpl.add_version_to_cqm;

INSERT INTO openchpl.cqm_criterion (cms_id, title, description, cqm_domain, nqf_number, last_modified_sso_user, cqm_version_id, cqm_criterion_type_id, retired)
  SELECT 'CMS1017', 
	'Hospital Harm - Falls with Injury', 
	'This ratio measure assesses the number of inpatient hospitalizations where at least one fall with a major or moderate injury occurs among the total qualifying inpatient hospital days for patients age 18 years and older', 
	'Outcome', 
	'4120e', 
	'6498c4f8-b0f1-70b5-55de-d84faae73402', 
	(SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v2'), 
	(select cqm_criterion_type_id from openchpl.cqm_criterion_type where name = 'Inpatient'), 
	false
  WHERE NOT EXISTS (select * from openchpl.cqm_criterion where cms_ID = 'CMS1017');

INSERT INTO openchpl.cqm_criterion (cms_id, title, description, cqm_domain, nqf_number, last_modified_sso_user, cqm_version_id, cqm_criterion_type_id, retired)
  SELECT 'CMS1218', 
	'Hospital Harm - Postoperative Respiratory Failure', 
	'This measure assesses the number of elective inpatient hospitalizations for patients aged 18 years and older without an obstetrical condition who have a procedure resulting in postoperative respiratory failure (PRF)',
	'Outcome', 
	'4130e', 
	'6498c4f8-b0f1-70b5-55de-d84faae73402',
	(SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v2'), 
	(select cqm_criterion_type_id from openchpl.cqm_criterion_type where name = 'Inpatient'), 
	false
  WHERE NOT EXISTS (select * from openchpl.cqm_criterion where cms_ID = 'CMS1218');
;
-- ./changes/ocd-4965.sql
--
-- create a new rule to associate with all the new criteria
--
INSERT INTO openchpl.rule (name, last_modified_sso_user)
SELECT 'HTI-4', '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.rule WHERE name = 'HTI-4'
);

--
-- add the new criteria and their attributes
--
INSERT INTO openchpl.certification_criterion (number, title, start_day, rule_id, certification_companion_guide_link, last_modified_sso_user)
SELECT '170.315 (b)(4)', 
		'Real-Time Prescription Benefit (RTPB)',
		'2025-10-01', 
		(SELECT id FROM openchpl.rule WHERE name = 'HTI-4'),
		'https://www.healthit.gov/test-method/real-time-prescription-benefit#ccg',
		'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.certification_criterion WHERE number = '170.315 (b)(4)' AND title = 'Real-Time Prescription Benefit (RTPB)'
);

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, service_base_url_list, optional_standard, test_tool,
conformance_method, test_procedure, test_data, functionality_tested, privacy_security_framework, additional_software,
api_documentation, attestation_answer, documentation_url, export_documentation, gap, g1_success, g2_success, sed,
test_standard, use_cases, risk_management_summary_information, standard, code_set, last_modified_sso_user)
SELECT (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(4)' AND title = 'Real-Time Prescription Benefit (RTPB)'),
true, false, false, true, true, false, true, false, false, true, false, false, false, false, 
false, false, false, false, false, false, false, true, false, '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.certification_criterion_attribute 
	WHERE criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(4)' AND title = 'Real-Time Prescription Benefit (RTPB)')
);

INSERT INTO openchpl.certification_criterion (number, title, start_day, rule_id, certification_companion_guide_link, last_modified_sso_user)
SELECT '170.315 (g)(31)', 
		'Provider Prior Authorization API - Coverage Requirements Discovery',
		'2025-10-01', 
		(SELECT id FROM openchpl.rule WHERE name = 'HTI-4'),
		'https://www.healthit.gov/test-method/provider-prior-authorization-api-coverage-requirements-discovery#ccg',
		'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.certification_criterion WHERE number = '170.315 (g)(31)'
);

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, service_base_url_list, optional_standard, test_tool,
conformance_method, test_procedure, test_data, functionality_tested, privacy_security_framework, additional_software,
api_documentation, attestation_answer, documentation_url, export_documentation, gap, g1_success, g2_success, sed,
test_standard, use_cases, risk_management_summary_information, standard, code_set, last_modified_sso_user)
SELECT (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(31)'),
true, false, false, true, true, false, false, false, false, true, true, false, false, false, false, 
false, false, false, false, false, false, true, false, '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.certification_criterion_attribute 
	WHERE criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(31)')
);

INSERT INTO openchpl.certification_criterion (number, title, start_day, rule_id, certification_companion_guide_link, last_modified_sso_user)
SELECT '170.315 (g)(32)', 
		'Provider Prior Authorization API - Documentation Templates and Rules',
		'2025-10-01', 
		(SELECT id FROM openchpl.rule WHERE name = 'HTI-4'),
		'https://www.healthit.gov/test-method/provider-prior-authorization-api-documentation-templates-and-rules#ccg',
		'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.certification_criterion WHERE number = '170.315 (g)(32)'
);

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, service_base_url_list, optional_standard, test_tool,
conformance_method, test_procedure, test_data, functionality_tested, privacy_security_framework, additional_software,
api_documentation, attestation_answer, documentation_url, export_documentation, gap, g1_success, g2_success, sed,
test_standard, use_cases, risk_management_summary_information, standard, code_set, last_modified_sso_user)
SELECT (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(32)'),
true, false, false, true, true, false, false, false, false, true, true, false, false, false,
false, false, false, false, false, false, false, true, false,  '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.certification_criterion_attribute 
	WHERE criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(32)')
);

INSERT INTO openchpl.certification_criterion (number, title, start_day, rule_id, certification_companion_guide_link, last_modified_sso_user)
SELECT '170.315 (g)(33)', 
		'Provider Prior Authorization API - Prior Authorization Support',
		'2025-10-01', 
		(SELECT id FROM openchpl.rule WHERE name = 'HTI-4'),
		'https://www.healthit.gov/test-method/provider-prior-authorization-api-prior-authorization-support#ccg',
		'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.certification_criterion WHERE number = '170.315 (g)(33)'
);

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, service_base_url_list, optional_standard, test_tool,
conformance_method, test_procedure, test_data, functionality_tested, privacy_security_framework, additional_software,
api_documentation, attestation_answer, documentation_url, export_documentation, gap, g1_success, g2_success, sed,
test_standard, use_cases, risk_management_summary_information, standard, code_set, last_modified_sso_user)
SELECT (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(33)'),
true, false, false, true, true, false, false, false, false, true, true, false, false, false, false,
false, false, false, false, false, false, true, false, '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.certification_criterion_attribute 
	WHERE criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(33)')
);

INSERT INTO openchpl.certification_criterion (number, title, start_day, rule_id, certification_companion_guide_link, last_modified_sso_user)
SELECT '170.315 (j)(20)', 
		'Workflow Triggers for Decision Support Interventions–Clients',
		'2025-10-01', 
		(SELECT id FROM openchpl.rule WHERE name = 'HTI-4'),
		'https://www.healthit.gov/test-method/workflow-triggers-decision-support-interventions-clients#ccg',
		'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.certification_criterion WHERE number = '170.315 (j)(20)'
);

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, service_base_url_list, optional_standard, test_tool,
conformance_method, test_procedure, test_data, functionality_tested, privacy_security_framework, additional_software,
api_documentation, attestation_answer, documentation_url, export_documentation, gap, g1_success, g2_success, sed,
test_standard, use_cases, risk_management_summary_information, standard, code_set, last_modified_sso_user)
SELECT (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (j)(20)'),
true, false, false, true, true, false, false, false, false, true, false, false, false, false, false,
false, false, false, false, false, false, true, false, '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.certification_criterion_attribute 
	WHERE criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (j)(20)')
);

INSERT INTO openchpl.certification_criterion (number, title, start_day, rule_id, certification_companion_guide_link, last_modified_sso_user)
SELECT '170.315 (j)(21)', 
		'Subscriptions–Client',
		'2025-10-01', 
		(SELECT id FROM openchpl.rule WHERE name = 'HTI-4'),
		'https://www.healthit.gov/test-method/subscriptions-client#ccg',
		'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.certification_criterion WHERE number = '170.315 (j)(21)'
);

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, service_base_url_list, optional_standard, test_tool,
conformance_method, test_procedure, test_data, functionality_tested, privacy_security_framework, additional_software,
api_documentation, attestation_answer, documentation_url, export_documentation, gap, g1_success, g2_success, sed,
test_standard, use_cases, risk_management_summary_information, standard, code_set, last_modified_sso_user)
SELECT (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (j)(21)'),
true, false, false, true, true, false, false, false, false, true, false, false, false, false, false,
false, false, false, false, false, false, true, false, '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.certification_criterion_attribute 
	WHERE criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (j)(21)')
);

--
-- add test data associations with the new criteria
--
INSERT INTO openchpl.test_data_criteria_map (criteria_id, test_data_id, last_modified_sso_user)
SELECT (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(4)' AND title = 'Real-Time Prescription Benefit (RTPB)'),
	(SELECT id FROM openchpl.test_data WHERE name = 'ONC Test Method'),
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.test_data_criteria_map
	WHERE criteria_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(4)' AND title = 'Real-Time Prescription Benefit (RTPB)')
	AND test_data_id = (SELECT id FROM openchpl.test_data WHERE name = 'ONC Test Method')
);
;
-- ./changes/ocd-4978.sql
--
-- Remove Conformance method "Attestation" association with f3 criterion.
-- It used to be allowed if GAP was "true" for f3.
--
UPDATE openchpl.conformance_method_criteria_map
SET deleted = true
WHERE criteria_id = 45 -- f3
AND conformance_method_id = 1; -- Attestation

--
-- Add new Conformance Method
--
INSERT INTO openchpl.conformance_method (name, last_modified_sso_user)
SELECT 'Gap certification via 2025 Attestation', '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation'
);

--
-- Associate the Gap Conformane Method with criteria
--

-- b1
INSERT INTO openchpl.conformance_method_criteria_map (conformance_method_id, criteria_id, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation'),
	165, 
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.conformance_method_criteria_map WHERE criteria_id = 165
	AND conformance_method_id = (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation')
);

-- b2
INSERT INTO openchpl.conformance_method_criteria_map (conformance_method_id, criteria_id, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation'),
	166, 
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.conformance_method_criteria_map WHERE criteria_id = 166
	AND conformance_method_id = (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation')
);

-- b9
INSERT INTO openchpl.conformance_method_criteria_map (conformance_method_id, criteria_id, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation'),
	170, 
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.conformance_method_criteria_map WHERE criteria_id = 170
	AND conformance_method_id = (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation')
);

-- e1
INSERT INTO openchpl.conformance_method_criteria_map (conformance_method_id, criteria_id, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation'),
	178, 
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.conformance_method_criteria_map WHERE criteria_id = 178
	AND conformance_method_id = (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation')
);

-- f1
INSERT INTO openchpl.conformance_method_criteria_map (conformance_method_id, criteria_id, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation'),
	43, 
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.conformance_method_criteria_map WHERE criteria_id = 43
	AND conformance_method_id = (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation')
);

--f3
INSERT INTO openchpl.conformance_method_criteria_map (conformance_method_id, criteria_id, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation'),
	45, 
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.conformance_method_criteria_map WHERE criteria_id = 45
	AND conformance_method_id = (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation')
);

--f4
INSERT INTO openchpl.conformance_method_criteria_map (conformance_method_id, criteria_id, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation'),
	46, 
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.conformance_method_criteria_map WHERE criteria_id = 46
	AND conformance_method_id = (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation')
);

--g6
INSERT INTO openchpl.conformance_method_criteria_map (conformance_method_id, criteria_id, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation'),
	180, 
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.conformance_method_criteria_map WHERE criteria_id = 180
	AND conformance_method_id = (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation')
);

--g9
INSERT INTO openchpl.conformance_method_criteria_map (conformance_method_id, criteria_id, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation'),
	181, 
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.conformance_method_criteria_map WHERE criteria_id = 181
	AND conformance_method_id = (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation')
);

--g10
INSERT INTO openchpl.conformance_method_criteria_map (conformance_method_id, criteria_id, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation'),
	182, 
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.conformance_method_criteria_map WHERE criteria_id = 182
	AND conformance_method_id = (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation')
);
;
-- ./changes/ocd-4988.sql
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
-- Note the 'E' at the beginning of the question, this is needed to properly escape the newline character in the question
--
INSERT INTO openchpl.question (question, response_cardinality_type_id, section_heading_id, last_modified_sso_user)
SELECT E'On June 30, 2025 ASTP issued the [Real World Testing Condition and Maintenance of Certification Requirements Enforcement Discretion Notice](https://www.healthit.gov/topic/real-world-testing-condition-and-maintenance-certification-requirements-enforcement). Please note that this enforcement discretion does not impact Real World Testing requirements for this Attestation period.\n\nWe attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in [45 CFR 170.405](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.405).',
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
WHERE id >= 9;;
-- ./changes/ocd-5007.sql
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
	AND certification_criterion_id = 182);

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
WHERE criterion_id = 182;
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('27.4.1', '2025-09-15', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
