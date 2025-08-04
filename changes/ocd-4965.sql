INSERT INTO openchpl.rule (name, last_modified_sso_user)
SELECT 'HTI-4', '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.rule WHERE name = 'HTI-4'
);

INSERT INTO openchpl.certification_criterion (number, title, start_date, rule_id, last_modified_sso_user)
SELECT '170.315 (b)(4)', 
		'Real-Time Prescription Benefit',
		'2025-09-15', 
		(SELECT id FROM openchpl.rule WHERE name = 'HTI-4'),
		'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.certification_criterion WHERE number = '170.315 (b)(4)' AND start_date = '2025-09-15'
);

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, service_base_url_list, optional_standard, test_tool,
conformance_method, test_procedure, test_data, functionality_tested, privacy_security_framework, additional_software,
api_documentation, attestation_answer, documentation_url, export_documentation, gap, g1_success, g2_success, sed,
test_standard, use_cases, risk_management_summary_information, standard, code_set, last_modified_sso_user)
SELECT (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(4)' AND start_date = '2025-09-15'),
true, false, false, true, true, false, true, false, false, true, false, false, false, false, 
false, false, false, false, false, false, false, true, true, '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.certification_criterion_attribute 
	WHERE certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(4)' AND start_date = '2025-09-15')
);

INSERT INTO openchpl.certification_criterion (number, title, start_date, rule_id, last_modified_sso_user)
SELECT '170.315 (g)(31)', 
		'Provider Prior Authorization API - Coverage Requirements Discovery',
		'2025-09-15', 
		(SELECT id FROM openchpl.rule WHERE name = 'HTI-4'),
		'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.certification_criterion WHERE number = '170.315 (g)(31)'
);

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, service_base_url_list, optional_standard, test_tool,
conformance_method, test_procedure, test_data, functionality_tested, privacy_security_framework, additional_software,
api_documentation, attestation_answer, documentation_url, export_documentation, gap, g1_success, g2_success, sed,
test_standard, use_cases, risk_management_summary_information, standard, code_set, last_modified_sso_user)
SELECT (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(31)'),
true, false, false, true, true, false, true, false, false, true, true, false, false, false, false, 
false, false, false, false, true, false, true, false, '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.certification_criterion_attribute 
	WHERE certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(31)')
);

INSERT INTO openchpl.certification_criterion (number, title, start_date, rule_id, last_modified_sso_user)
SELECT '170.315 (g)(32)', 
		'Provider Prior Authorization API - Documentation Templates and Rules',
		'2025-09-15', 
		(SELECT id FROM openchpl.rule WHERE name = 'HTI-4'),
		'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.certification_criterion WHERE number = '170.315 (g)(32)'
);

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, service_base_url_list, optional_standard, test_tool,
conformance_method, test_procedure, test_data, functionality_tested, privacy_security_framework, additional_software,
api_documentation, attestation_answer, documentation_url, export_documentation, gap, g1_success, g2_success, sed,
test_standard, use_cases, risk_management_summary_information, standard, code_set, last_modified_sso_user)
SELECT (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(32)'),
true, false, false, true, true, false, true, false, false, true, false, false, false, false,
false, false, false, false, false, false, false, true, false,  '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.certification_criterion_attribute 
	WHERE certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(32)')
);

INSERT INTO openchpl.certification_criterion (number, title, start_date, rule_id, last_modified_sso_user)
SELECT '170.315 (g)(33)', 
		'Provider Prior Authorization API - Prior Authorization Support',
		'2025-09-15', 
		(SELECT id FROM openchpl.rule WHERE name = 'HTI-4'),
		'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.certification_criterion WHERE number = '170.315 (g)(33)'
);

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, service_base_url_list, optional_standard, test_tool,
conformance_method, test_procedure, test_data, functionality_tested, privacy_security_framework, additional_software,
api_documentation, attestation_answer, documentation_url, export_documentation, gap, g1_success, g2_success, sed,
test_standard, use_cases, risk_management_summary_information, standard, code_set, last_modified_sso_user)
SELECT (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(33)'),
true, false, false, true, true, false, true, false, false, true true, false, false, false, false,
false, false, false, false, false, false, true, false, '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.certification_criterion_attribute 
	WHERE certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(33)')
);

INSERT INTO openchpl.certification_criterion (number, title, start_date, rule_id, last_modified_sso_user)
SELECT '170.315 (j)(20)', 
		'Workflow Triggers for Decision Support Interventions–Clients',
		'2025-09-15', 
		(SELECT id FROM openchpl.rule WHERE name = 'HTI-4'),
		'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.certification_criterion WHERE number = '170.315 (j)(20)'
);

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, service_base_url_list, optional_standard, test_tool,
conformance_method, test_procedure, test_data, functionality_tested, privacy_security_framework, additional_software,
api_documentation, attestation_answer, documentation_url, export_documentation, gap, g1_success, g2_success, sed,
test_standard, use_cases, risk_management_summary_information, standard, code_set, last_modified_sso_user)
SELECT (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (j)(20)'),
true, false, false, true, true, false, true, false, false, true, false, false, false, false, false,
false, false, false, false, false, false, true, false, '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.certification_criterion_attribute 
	WHERE certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (j)(20)')
);

INSERT INTO openchpl.certification_criterion (number, title, start_date, rule_id, last_modified_sso_user)
SELECT '170.315 (j)(21)', 
		'Subscriptions–Client',
		'2025-09-15', 
		(SELECT id FROM openchpl.rule WHERE name = 'HTI-4'),
		'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.certification_criterion WHERE number = '170.315 (j)(21)'
);

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, service_base_url_list, optional_standard, test_tool,
conformance_method, test_procedure, test_data, functionality_tested, privacy_security_framework, additional_software,
api_documentation, attestation_answer, documentation_url, export_documentation, gap, g1_success, g2_success, sed,
test_standard, use_cases, risk_management_summary_information, standard, code_set, last_modified_sso_user)
SELECT (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (j)(21)'),
true, false, false, true, true, false, true, false, false, true, false, false, false, false, false,
false, false, false, false, false, false, true, false, '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.certification_criterion_attribute 
	WHERE certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (j)(21)')
);
