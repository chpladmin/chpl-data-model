-- Deployment file for version 24.3.0
--     as of 2023-11-27
-- ./changes/ocd-4336.sql
--
-- Allow certification edition to be nullable
--
ALTER TABLE openchpl.certification_criterion
ALTER COLUMN certification_edition_id DROP NOT NULL;

-- Insert the 2 new criteria
-- Note that the real Start Date will have to be updated when we know RED of HTI-1

INSERT INTO openchpl.certification_criterion (number, title, start_day, end_day, rule_id, last_modified_user)
SELECT '170.315 (b)(11)', 'Decision Support Interventions', '2024-04-30', NULL, (SELECT id FROM openchpl.rule WHERE name = 'HTI-1'), -1
WHERE NOT EXISTS (SELECT * FROM openchpl.certification_criterion WHERE number = '170.315 (b)(11)');

INSERT INTO openchpl.certification_criterion (number, title, start_day, end_day, rule_id, last_modified_user)
SELECT '170.315 (d)(14)', 'Patient Requested Restrictions', '2024-04-30', NULL, (SELECT id FROM openchpl.rule WHERE name = 'HTI-1'), -1
WHERE NOT EXISTS (SELECT * FROM openchpl.certification_criterion WHERE number = '170.315 (d)(14)');

-- Add allowed conformance method for b11
INSERT INTO openchpl.conformance_method_criteria_map (conformance_method_id, criteria_id, last_modified_user)
SELECT (SELECT id FROM openchpl.conformance_method WHERE name = 'Attestation'),  
	(SELECT certification_criterion_id FROM openchpl.certification_criterion where number = '170.315 (b)(11)'),
	-1
WHERE NOT EXISTS (
	SELECT * FROM openchpl.conformance_method_criteria_map 
	WHERE criteria_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion where number = '170.315 (b)(11)'));
	
-- Add allowed conformance method for d14
INSERT INTO openchpl.conformance_method_criteria_map (conformance_method_id, criteria_id, last_modified_user)
SELECT (SELECT id FROM openchpl.conformance_method WHERE name = 'Attestation'),  
	(SELECT certification_criterion_id FROM openchpl.certification_criterion where number = '170.315 (d)(14)'),
	-1
WHERE NOT EXISTS (
	SELECT * FROM openchpl.conformance_method_criteria_map 
	WHERE criteria_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion where number = '170.315 (d)(14)'));

--
-- Add the new type of criteria attribute
--
ALTER TABLE openchpl.certification_criterion_attribute
ADD COLUMN IF NOT EXISTS risk_management_summary_information bool NOT NULL DEFAULT FALSE;

-- Add allowed attributes to b11
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, service_base_url_list, optional_standard, test_tool, conformance_method, test_procedure, test_data, functionality_tested, privacy_security_framework, additional_software, api_documentation, attestation_answer, documentation_url, export_documentation, gap, g1_success, g2_success, sed, test_standard, use_cases, risk_management_summary_information, last_modified_user)
SELECT (SELECT certification_criterion_id FROM openchpl.certification_criterion where number = '170.315 (b)(11)'), false, false, false, false, true, false, false, true, true, true, false, false, false, false, false, false, false, false, false, false, true, -1
WHERE NOT EXISTS (SELECT * FROM openchpl.certification_criterion_attribute WHERE criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion where number = '170.315 (b)(11)'));

-- Add allowed attributes to d14
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, service_base_url_list, optional_standard, test_tool, conformance_method, test_procedure, test_data, functionality_tested, privacy_security_framework, additional_software, api_documentation, attestation_answer, documentation_url, export_documentation, gap, g1_success, g2_success, sed, test_standard, use_cases, risk_management_summary_information, last_modified_user)
SELECT (SELECT certification_criterion_id FROM openchpl.certification_criterion where number = '170.315 (d)(14)'), false, false, false, false, true, false, false, true, false, true, false, false, false, false, false, false, false, false, false, false, false, -1
WHERE NOT EXISTS (SELECT * FROM openchpl.certification_criterion_attribute WHERE criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion where number = '170.315 (d)(14)'));

-- Add the new criteria attribute to the cert result table 
ALTER TABLE openchpl.certification_result
ADD COLUMN IF NOT EXISTS risk_management_summary_information varchar(1024) DEFAULT NULL;

-- Add to url_type table to support bad URL checking
INSERT INTO openchpl.url_type (name, last_modified_user)
SELECT 'Risk Management Summary Information', -1
WHERE NOT EXISTS (SELECT * FROM openchpl.url_type WHERE name = 'Risk Management Summary Information');

;
-- ./changes/ocd-4389.sql
INSERT INTO openchpl.cqm_version (version, last_modified_user)
SELECT 'v13', -1
WHERE NOT EXISTS (SELECT version FROM openchpl.cqm_version WHERE version = 'v13');

create function add_version_to_cqm(cqm_text text, version_text text, previous_version text)
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


SELECT add_version_to_cqm('CMS2', 'v13', 'v12');
SELECT add_version_to_cqm('CMS22', 'v12', 'v11');
SELECT add_version_to_cqm('CMS50', 'v12', 'v11');
SELECT add_version_to_cqm('CMS56', 'v12', 'v11');
SELECT add_version_to_cqm('CMS68', 'v13', 'v12');
SELECT add_version_to_cqm('CMS69', 'v12', 'v11');
SELECT add_version_to_cqm('CMS74', 'v13', 'v12');
SELECT add_version_to_cqm('CMS75', 'v12', 'v11');
SELECT add_version_to_cqm('CMS90', 'v13', 'v12');
SELECT add_version_to_cqm('CMS117', 'v12', 'v11');
SELECT add_version_to_cqm('CMS122', 'v12', 'v11');
SELECT add_version_to_cqm('CMS124', 'v12', 'v11');
SELECT add_version_to_cqm('CMS125', 'v12', 'v11');
SELECT add_version_to_cqm('CMS127', 'v12', 'v11');
SELECT add_version_to_cqm('CMS128', 'v12', 'v11');
SELECT add_version_to_cqm('CMS129', 'v13', 'v12');
SELECT add_version_to_cqm('CMS130', 'v12', 'v11');
SELECT add_version_to_cqm('CMS131', 'v12', 'v11');
SELECT add_version_to_cqm('CMS133', 'v12', 'v11');
SELECT add_version_to_cqm('CMS134', 'v11', 'v10');
SELECT add_version_to_cqm('CMS135', 'v12', 'v11');
SELECT add_version_to_cqm('CMS136', 'v13', 'v12');
SELECT add_version_to_cqm('CMS137', 'v12', 'v11');
SELECT add_version_to_cqm('CMS138', 'v12', 'v11');
SELECT add_version_to_cqm('CMS139', 'v12', 'v11');
SELECT add_version_to_cqm('CMS142', 'v12', 'v11');
SELECT add_version_to_cqm('CMS143', 'v12', 'v11');
SELECT add_version_to_cqm('CMS144', 'v12', 'v11');
SELECT add_version_to_cqm('CMS145', 'v12', 'v11');
SELECT add_version_to_cqm('CMS146', 'v12', 'v11');
SELECT add_version_to_cqm('CMS147', 'v13', 'v12');
SELECT add_version_to_cqm('CMS149', 'v12', 'v11');
SELECT add_version_to_cqm('CMS153', 'v12', 'v11');
SELECT add_version_to_cqm('CMS154', 'v12', 'v11');
SELECT add_version_to_cqm('CMS155', 'v12', 'v11');
SELECT add_version_to_cqm('CMS156', 'v12', 'v11');
SELECT add_version_to_cqm('CMS157', 'v12', 'v11');
SELECT add_version_to_cqm('CMS159', 'v12', 'v11');
SELECT add_version_to_cqm('CMS161', 'v12', 'v11');
SELECT add_version_to_cqm('CMS165', 'v12', 'v11');
SELECT add_version_to_cqm('CMS177', 'v12', 'v11');
SELECT add_version_to_cqm('CMS249', 'v6', 'v5');
SELECT add_version_to_cqm('CMS347', 'v7', 'v6');
SELECT add_version_to_cqm('CMS349', 'v6', 'v5');
SELECT add_version_to_cqm('CMS645', 'v7', 'v6');
SELECT add_version_to_cqm('CMS646', 'v4', 'v3');
SELECT add_version_to_cqm('CMS771', 'v5', 'v4');
SELECT add_version_to_cqm('CMS71', 'v13', 'v12');
SELECT add_version_to_cqm('CMS72', 'v12', 'v11');
SELECT add_version_to_cqm('CMS104', 'v12', 'v11');
SELECT add_version_to_cqm('CMS108', 'v12', 'v11');
SELECT add_version_to_cqm('CMS190', 'v12', 'v11');
SELECT add_version_to_cqm('CMS506', 'v6', 'v5');
SELECT add_version_to_cqm('CMS529', 'v4', 'v3');
SELECT add_version_to_cqm('CMS844', 'v4', 'v3');
SELECT add_version_to_cqm('CMS951', 'v2', 'v1');
SELECT add_version_to_cqm('CMS334', 'v5', 'v4');
SELECT add_version_to_cqm('CMS816', 'v3', 'v2');
SELECT add_version_to_cqm('CMS871', 'v3', 'v2');
SELECT add_version_to_cqm('CMS1028', 'v2', 'v1');
SELECT add_version_to_cqm('CMS996', 'v4', 'v3');

drop function add_version_to_cqm;


INSERT INTO openchpl.cqm_criterion (cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
  SELECT 'CMS1188', 
	'Sexually Transmitted Infection (STI) Testing for People with HIV', 
	'Percentage of patients 13 years of age and older with a diagnosis of HIV who had tests for syphilis, gonorrhea, and chlamydia performed within the measurement period', 
	'Health Resources & Services Administration ', 
	'N/A', 
	-1, 
	(SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v1'), 
	(select cqm_criterion_type_id from openchpl.cqm_criterion_type where name = 'Ambulatory'), 
	false
  WHERE NOT EXISTS (select * from openchpl.cqm_criterion where cms_ID = 'CMS1188');

INSERT INTO openchpl.cqm_criterion (cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
  SELECT 'CMS819', 
	'Hospital Harm - Opioid-Related Adverse Events', 
	'This measure assesses the number of inpatient hospitalizations for patients age 18 and older who have been administered an opioid medication and are subsequently administered an opioid antagonist within 12 hours, an indication of an opioid-related adverse event', 
	null, 
	'3501e', 
	-1, 
	(SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v2'), 
	(select cqm_criterion_type_id from openchpl.cqm_criterion_type where name = 'Inpatient'), 
	false
  WHERE NOT EXISTS (select * from openchpl.cqm_criterion where cms_ID = 'CMS819');

INSERT INTO openchpl.cqm_criterion (cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
  SELECT 'CMS986', 
	'Global Malnutrition Composite Score', 
	'This measure assesses the percentage of hospitalizations for adults aged 65 years and older at the start of the inpatient encounter during the measurement period with a length of stay equal to or greater than 24 hours who received optimal malnutrition care during the current inpatient hospitalization where care performed was appropriate to the patient''s level of malnutrition risk and severity. Malnutrition care best practices recommend that for each hospitalization, adult inpatients are screened for malnutrition risk, assessed to confirm findings of malnutrition risk or for a hospital dietitian referral order, and if identified with a "moderate" or "severe" malnutrition status in the current performed malnutrition assessment, receive a current "moderate" or "severe" malnutrition diagnosis and have a current nutrition care plan performed.', 
	'Intermiedate Clinical Outcome', 
	'3592e', 
	-1, 
	(SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v2'), 
	(select cqm_criterion_type_id from openchpl.cqm_criterion_type where name = 'Inpatient'), 
	false
  WHERE NOT EXISTS (select * from openchpl.cqm_criterion where cms_ID = 'CMS986');
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('24.3.0', '2023-11-27', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
