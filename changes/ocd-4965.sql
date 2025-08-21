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
false, false, false, false, true, false, true, false, '6498c4f8-b0f1-70b5-55de-d84faae73402'
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
-- add code sets associated with the new criteria
--
INSERT INTO openchpl.code_set_criteria_map (certification_criterion_id, code_set_id, last_modified_sso_user)
SELECT (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(4)' AND title = 'Real-Time Prescription Benefit (RTPB)'),
	(SELECT id FROM openchpl.code_set WHERE required_day = '2025-12-31'),
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.code_set_criteria_map
	WHERE certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(4)' AND title = 'Real-Time Prescription Benefit (RTPB)')
	AND code_set_id = (SELECT id FROM openchpl.code_set WHERE required_day = '2025-12-31')
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
