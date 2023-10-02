--
-- Allow certification edition to be nullable
--
ALTER TABLE openchpl.certification_criterion
ALTER COLUMN certification_edition_id DROP NOT NULL;

-- Insert the 2 new criteria
-- Note that the real Start Date will have to be updated when we know RED of HTI-1

INSERT INTO openchpl.certification_criterion (number, title, start_day, end_day, last_modified_user)
SELECT '170.315 (b)(11)', 'Decision Support Interventions', '2024-04-30', NULL, -1
WHERE NOT EXISTS (SELECT * FROM openchpl.certification_criterion WHERE number = '170.315 (b)(11)');

INSERT INTO openchpl.certification_criterion (number, title, start_day, end_day, last_modified_user)
SELECT '170.315 (d)(14)', 'Patient Requested Restrictions', '2024-04-30', NULL, -1
WHERE NOT EXISTS (SELECT * FROM openchpl.certification_criterion WHERE number = '170.315 (d)(14)');

--
-- Add the new type of criteria attribute
--
ALTER TABLE openchpl.certification_criterion_attribute
ADD COLUMN IF NOT EXISTS risk_management_summary_information bool NOT NULL DEFAULT FALSE;

-- Add allowed attributes to b11
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, service_base_url_list, optional_standard, test_tool, conformance_method, test_procedure, test_data, functionality_tested, privacy_security_framework, additional_software, api_documentation, attestation_answer, documentation_url, export_documentation, gap, g1_success, g2_success, sed, test_standard, use_cases, risk_management_summary_information, last_modified_user)
SELECT (SELECT certification_criterion_id FROM openchpl.certification_criterion where number = '170.315 (b)(11)'), false, false, false, false, true, false, false, true, true, false, false, false, false, false, false, false, false, false, false, false, true, -1
WHERE NOT EXISTS (SELECT * FROM openchpl.certification_criterion_attribute WHERE criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion where number = '170.315 (b)(11)'));

-- Add allowed attributes to d14
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, service_base_url_list, optional_standard, test_tool, conformance_method, test_procedure, test_data, functionality_tested, privacy_security_framework, additional_software, api_documentation, attestation_answer, documentation_url, export_documentation, gap, g1_success, g2_success, sed, test_standard, use_cases, risk_management_summary_information, last_modified_user)
SELECT (SELECT certification_criterion_id FROM openchpl.certification_criterion where number = '170.315 (d)(14)'), false, false, false, false, true, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, -1
WHERE NOT EXISTS (SELECT * FROM openchpl.certification_criterion_attribute WHERE criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion where number = '170.315 (d)(14)'));
