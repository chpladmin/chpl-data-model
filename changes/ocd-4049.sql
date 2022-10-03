INSERT INTO openchpl.cqm_version (version, last_modified_user)
SELECT 'v12', -1
WHERE NOT EXISTS (SELECT version FROM openchpl.cqm_version WHERE version = 'v12');

create procedure add_version_to_cqm(cqm_text text, version_text text, previous_version text)
language SQL
as $$
  INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
  SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = version_text), cc.cqm_criterion_type_id, cc.retired
  FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = previous_version
  WHERE cc.cms_id = cqm_text
  AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = version_text WHERE cc.cms_id = cqm_text);
$$;

CALL add_version_to_cqm('CMS2', 'v12', 'v11');
CALL add_version_to_cqm('CMS2', 'v12', 'v11');
CALL add_version_to_cqm('CMS22', 'v11', 'v10');
CALL add_version_to_cqm('CMS50', 'v11', 'v10');
CALL add_version_to_cqm('CMS56', 'v11', 'v10');
CALL add_version_to_cqm('CMS66', 'v11', 'v10');
CALL add_version_to_cqm('CMS68', 'v12', 'v11');
CALL add_version_to_cqm('CMS69', 'v11', 'v10');
CALL add_version_to_cqm('CMS74', 'v12', 'v11');
CALL add_version_to_cqm('CMS75', 'v11', 'v10');
CALL add_version_to_cqm('CMS90', 'v12', 'v11');
CALL add_version_to_cqm('CMS117', 'v11', 'v10');
CALL add_version_to_cqm('CMS122', 'v11', 'v10');
CALL add_version_to_cqm('CMS124', 'v11', 'v10');
CALL add_version_to_cqm('CMS125', 'v11', 'v10');
CALL add_version_to_cqm('CMS127', 'v11', 'v10');
CALL add_version_to_cqm('CMS128', 'v11', 'v10');
CALL add_version_to_cqm('CMS129', 'v12', 'v11');
CALL add_version_to_cqm('CMS130', 'v11', 'v10');
CALL add_version_to_cqm('CMS131', 'v11', 'v10');
CALL add_version_to_cqm('CMS133', 'v11', 'v10');
CALL add_version_to_cqm('CMS134', 'v11', 'v10');
CALL add_version_to_cqm('CMS135', 'v11', 'v10');
CALL add_version_to_cqm('CMS136', 'v12', 'v11');
CALL add_version_to_cqm('CMS137', 'v11', 'v10');
CALL add_version_to_cqm('CMS138', 'v11', 'v10');
CALL add_version_to_cqm('CMS139', 'v11', 'v10');
CALL add_version_to_cqm('CMS142', 'v11', 'v10');
CALL add_version_to_cqm('CMS143', 'v11', 'v10');
CALL add_version_to_cqm('CMS144', 'v11', 'v10');
CALL add_version_to_cqm('CMS145', 'v11', 'v10');
CALL add_version_to_cqm('CMS146', 'v11', 'v10');
CALL add_version_to_cqm('CMS147', 'v12', 'v11');
CALL add_version_to_cqm('CMS149', 'v11', 'v10');
CALL add_version_to_cqm('CMS153', 'v11', 'v10');
CALL add_version_to_cqm('CMS154', 'v11', 'v10');
CALL add_version_to_cqm('CMS155', 'v11', 'v10');
CALL add_version_to_cqm('CMS156', 'v11', 'v10');
CALL add_version_to_cqm('CMS157', 'v11', 'v10');
CALL add_version_to_cqm('CMS159', 'v11', 'v10');
CALL add_version_to_cqm('CMS161', 'v11', 'v10');
CALL add_version_to_cqm('CMS165', 'v11', 'v10');
CALL add_version_to_cqm('CMS177', 'v11', 'v10');
CALL add_version_to_cqm('CMS249', 'v5', 'v4');
CALL add_version_to_cqm('CMS347', 'v6', 'v5');
CALL add_version_to_cqm('CMS349', 'v5', 'v4');
CALL add_version_to_cqm('CMS645', 'v6', 'v5');
CALL add_version_to_cqm('CMS646', 'v3', 'v2');
CALL add_version_to_cqm('CMS771', 'v4', 'v3');
CALL add_version_to_cqm('CMS9', 'v11', 'v10');
CALL add_version_to_cqm('CMS71', 'v12', 'v11');
CALL add_version_to_cqm('CMS72', 'v11', 'v10');
CALL add_version_to_cqm('CMS104', 'v11', 'v10');
CALL add_version_to_cqm('CMS105', 'v11', 'v10');
CALL add_version_to_cqm('CMS108', 'v11', 'v10');
CALL add_version_to_cqm('CMS111', 'v11', 'v10');
CALL add_version_to_cqm('CMS190', 'v11', 'v10');
CALL add_version_to_cqm('CMS506', 'v5', 'v4');
CALL add_version_to_cqm('CMS529', 'v3', 'v2');
CALL add_version_to_cqm('CMS844', 'v3', 'v2');

drop procedure add_version_to_cqm;

INSERT INTO openchpl.cqm_criterion (cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
  SELECT 'CMS951', 'Kidney Health Evaluation', 'Percentage of patients aged 18-75 years with a diagnosis of diabetes who received a kidney health evaluation defined by an Estimated Glomerular Filtration Rate (eGFR) AND Urine Albumin-Creatinine Ratio (uACR) within the measurement period', 'Promote effective prevention and treatment of chronic disease', 'N/A', -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v1'), (select cqm_criterion_type_id from openchpl.cqm_criterion_type where name = 'Inpatient'), false
  WHERE NOT EXISTS (select * from openchpl.cqm_criterion where cms_ID = 'CMS951');

INSERT INTO openchpl.cqm_criterion (cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
  SELECT 'CMS1028', 'Severe Obstetric Complications', 'Patients with severe obstetric complications which occur during the inpatient delivery hospitalization.', 'Safety', 'N/A', -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v1'), (select cqm_criterion_type_id from openchpl.cqm_criterion_type where name = 'Inpatient'), false
  WHERE NOT EXISTS (select * from openchpl.cqm_criterion where cms_ID = 'CMS1028');

INSERT INTO openchpl.cqm_criterion (cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
  SELECT 'CMS334', 'Cesarean Birth', 'Nulliparous women with a term, singleton baby in a vertex position delivered by cesarean birth', 'Safety', 'N/A', -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v4'), (select cqm_criterion_type_id from openchpl.cqm_criterion_type where name = 'Inpatient'), false
  WHERE NOT EXISTS (select * from openchpl.cqm_criterion where cms_ID = 'CMS334');

INSERT INTO openchpl.cqm_criterion (cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
  SELECT 'CMS816', 'Hospital Harm - Severe Hypoglycemia', 'Inpatient hospitalizations for patients 18 years of age or older at admission, who were administered at least one hypoglycemic medication during the encounter, who suffer the harm of a severe hypoglycemic event during the encounter', 'Preventable Healthcare Harm', '3503e', -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v2'), (select cqm_criterion_type_id from openchpl.cqm_criterion_type where name = 'Inpatient'), false
  WHERE NOT EXISTS (select * from openchpl.cqm_criterion where cms_ID = 'CMS816');

INSERT INTO openchpl.cqm_criterion (cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
  SELECT 'CMS871', 'Hospital Harm - Severe Hyperglycemia', 'This measure assesses the number of inpatient hospital days with a hyperglycemic event (harm) per the total qualifying inpatient hospital days for that encounter for patients 18 years of age or older at admission', 'Preventable Healthcare Harm', '3533e', -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v2'), (select cqm_criterion_type_id from openchpl.cqm_criterion_type where name = 'Inpatient'), false
  WHERE NOT EXISTS (select * from openchpl.cqm_criterion where cms_ID = 'CMS871');

INSERT INTO openchpl.cqm_criterion (cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
  SELECT 'CMS996', 'Appropriate Treatment for ST-Segment Elevation Myocardial Infarction (STEMI) Patients in the Emergency Department (ED)', 'Percentage of emergency department (ED) encounters for patients 18 years and older with a diagnosis of ST-segment elevation myocardial infarction (STEMI) that received appropriate treatment, defined as fibrinolytic therapy within 30 minutes of ED arrival, percutaneous coronary intervention (PCI) within 90 minutes of ED arrival, or transfer within 45 minutes of ED arrival', 'Promote effective prevention and treatment of chronic disease', '3613e', -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v3'), (select cqm_criterion_type_id from openchpl.cqm_criterion_type where name = 'Ambulatory'), false
  WHERE NOT EXISTS (select * from openchpl.cqm_criterion where cms_ID = 'CMS996');
