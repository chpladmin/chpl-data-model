INSERT INTO openchpl.cqm_criterion (cms_id, title, description, cqm_domain, nqf_number, last_modified_sso_user, cqm_version_id, cqm_criterion_type_id, retired)
  SELECT 'CMS1173', 
	'Diagnostic Delay of Venous Thromboembolism in Primary Care', 
	'Percentage of episodes for patients 18 years of age and older with documented Venous Thromboembolism (VTE) symptoms in the primary care setting and who had a diagnosis of VTE that occurs > 24 hours and within 30 days following the index primary care visit where symptoms for the VTE were first present.', 
	'Intermediate Outcome', 
	'N/A', 
	'6498c4f8-b0f1-70b5-55de-d84faae73402', 
	(SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v1'), 
	(select cqm_criterion_type_id from openchpl.cqm_criterion_type where name = 'Inpatient'), 
	false
  WHERE NOT EXISTS (select * from openchpl.cqm_criterion where cms_ID = 'CMS1173');

INSERT INTO openchpl.cqm_criterion (cms_id, title, description, cqm_domain, nqf_number, last_modified_sso_user, cqm_version_id, cqm_criterion_type_id, retired)
  SELECT 'CMS1154', 
	'Screening for Abnormal Glucose Metabolism in Patients at Risk of Developing Diabetes', 
	'Percentage of adult patients with risk factors for type 2 diabetes who are due for glycemic screening for whom the screening process was completed during the measurement period.',
	'Process', 
	'N/A', 
	'6498c4f8-b0f1-70b5-55de-d84faae73402',
	(SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v1'), 
	(select cqm_criterion_type_id from openchpl.cqm_criterion_type where name = 'Inpatient'), 
	false
  WHERE NOT EXISTS (select * from openchpl.cqm_criterion where cms_ID = 'CMS1154');
  