INSERT INTO openchpl.cqm_version (version, last_modified_user)
SELECT 'v16', -1
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

SELECT openchpl.add_version_to_cqm('CMS2', 'v16', 'v15');
SELECT openchpl.add_version_to_cqm('CMS22', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS50', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS56', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS68', 'v16', 'v15');
SELECT openchpl.add_version_to_cqm('CMS69', 'v15', 'v16');
SELECT openchpl.add_version_to_cqm('CMS74', 'v16', 'v15');
SELECT openchpl.add_version_to_cqm('CMS75', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS90', 'v16', 'v15');
SELECT openchpl.add_version_to_cqm('CMS117', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS122', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS124', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS125', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS128', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS129', 'v16', 'v15');
SELECT openchpl.add_version_to_cqm('CMS130', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS131', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS133', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS135', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS136', 'v16', 'v15');
SELECT openchpl.add_version_to_cqm('CMS137', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS138', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS139', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS142', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS143', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS144', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS146', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS149', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS153', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS154', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS155', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS156', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS157', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS159', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS165', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS177', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS314', 'v4', 'v3');
SELECT openchpl.add_version_to_cqm('CMS347', 'v10', 'v9');
SELECT openchpl.add_version_to_cqm('CMS349', 'v9', 'v8');
SELECT openchpl.add_version_to_cqm('CMS645', 'v10', 'v9');
SELECT openchpl.add_version_to_cqm('CMS646', 'v7', 'v6');
SELECT openchpl.add_version_to_cqm('CMS771', 'v8', 'v7');
SELECT openchpl.add_version_to_cqm('CMS71', 'v16', 'v15');
SELECT openchpl.add_version_to_cqm('CMS72', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS104', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS108', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS190', 'v15', 'v14');
SELECT openchpl.add_version_to_cqm('CMS506', 'v9', 'v8');
SELECT openchpl.add_version_to_cqm('CMS529', 'v7', 'v6');
SELECT openchpl.add_version_to_cqm('CMS844', 'v7', 'v6');
SELECT openchpl.add_version_to_cqm('CMS951', 'v5', 'v4');
SELECT openchpl.add_version_to_cqm('CMS334', 'v8', 'v7');
SELECT openchpl.add_version_to_cqm('CMS816', 'v6', 'v5');
SELECT openchpl.add_version_to_cqm('CMS871', 'v6', 'v5');
SELECT openchpl.add_version_to_cqm('CMS1028', 'v5', 'v4');
SELECT openchpl.add_version_to_cqm('CMS996', 'v7', 'v6');
SELECT openchpl.add_version_to_cqm('CMS1188', 'v4', 'v3');
SELECT openchpl.add_version_to_cqm('CMS819', 'v5', 'v4');
SELECT openchpl.add_version_to_cqm('CMS986', 'v6', 'v5');
SELECT openchpl.add_version_to_cqm('CMS1056', 'v4', 'v3');
SELECT openchpl.add_version_to_cqm('CMS1157', 'v3', 'v2');
SELECT openchpl.add_version_to_cqm('CMS826', 'v4', 'v3');
SELECT openchpl.add_version_to_cqm('CMS832', 'v4', 'v3');
SELECT openchpl.add_version_to_cqm('CMS1074', 'v4', 'v3');
SELECT openchpl.add_version_to_cqm('CMS1206', 'v4', 'v3');
SELECT openchpl.add_version_to_cqm('CMS1017', 'v3', 'v2');
SELECT openchpl.add_version_to_cqm('CMS1218', 'v3', 'v2');
SELECT openchpl.add_version_to_cqm('CMS1154', 'v2', 'v1');

drop function openchpl.add_version_to_cqm;

-- title has "\&"; is that right?
INSERT INTO openchpl.cqm_criterion (cms_id, title, description, cqm_domain, last_modified_sso_user, cqm_version_id, cqm_criterion_type_id, retired)
  SELECT 'CMS1244FHIR',
	'Emergency Care Access \& Timeliness (HOQR)FHIR',
	'This measure assesses the variation in access and timeliness of emergency care to support hospital quality improvement for patients requiring emergency care in an emergency department (ED). This measure is designed to align with incentives to promote improved care both in EDs and the broader health system to help identify where patients do not receive timely access to emergency care. Emergency care access and timeliness gaps are inclusive of several concepts pertaining to boarding and crowding in an ED, including significantly longer ED wait times, higher left without being seen rates, longer boarding times, and longer total length of stay in the ED.',
	'Outcome',
	'6498c4f8-b0f1-70b5-55de-d84faae73402',
	(SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v1'),
	(select cqm_criterion_type_id from openchpl.cqm_criterion_type where name = 'Ambulatory'),
	false
  WHERE NOT EXISTS (select * from openchpl.cqm_criterion where cms_ID = 'CMS1244FHIR');

-- no description in document; is that right?
INSERT INTO openchpl.cqm_criterion (cms_id, title, description, cqm_domain, last_modified_sso_user, cqm_version_id, cqm_criterion_type_id, retired)
  SELECT 'CMS1244',
	'Emergency Care Access & Timeliness (HOQR)',
	'',
	'Outcome',
	'6498c4f8-b0f1-70b5-55de-d84faae73402',
	(SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v2'),
	(select cqm_criterion_type_id from openchpl.cqm_criterion_type where name = 'Ambulatory'),
	false
  WHERE NOT EXISTS (select * from openchpl.cqm_criterion where cms_ID = 'CMS1244');

-- title has "\&"; is that right?
-- does "FHIR" have one "I" or two?
INSERT INTO openchpl.cqm_criterion (cms_id, title, description, cqm_domain, last_modified_sso_user, cqm_version_id, cqm_criterion_type_id, retired)
  SELECT 'CMS1264FHIIR',
	'Emergency Care Access \& Timeliness (REHQR)FHIR',
	'This measure assesses the variation in access and timeliness of emergency care to support rural emergency hospital (REH) quality improvement for patients requiring emergency care in an emergency department (ED). This measure is designed to align with incentives to promote improved care both in EDs and the broader health system to help identify where patients do not receive timely access to emergency care. Emergency care access and timeliness gaps are inclusive of several concepts pertaining to boarding and crowding in an ED, including significantly longer ED wait times, higher left without being seen rates, longer boarding times, and longer total length of stay in the ED.',
	'Immediate Outcome',
	'6498c4f8-b0f1-70b5-55de-d84faae73402',
	(SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v1'),
	(select cqm_criterion_type_id from openchpl.cqm_criterion_type where name = 'Ambulatory'),
	false
  WHERE NOT EXISTS (select * from openchpl.cqm_criterion where cms_ID = 'CMS1264FHIIR');

-- title has "\&"; is that right?
INSERT INTO openchpl.cqm_criterion (cms_id, title, description, cqm_domain, last_modified_sso_user, cqm_version_id, cqm_criterion_type_id, retired)
  SELECT 'CMS1264',
	'Emergency Care Access \& Timeliness (REHQR)FHIR',
	'This measure assesses the variation in access and timeliness of emergency care to support rural emergency hospital (REH) quality improvement for patients requiring emergency care in an emergency department (ED). This measure is designed to align with incentives to promote improved care both in EDs and the broader health system to help identify where patients do not receive timely access to emergency care. Emergency care access and timeliness gaps are inclusive of several concepts pertaining to boarding and crowding in an ED, including significantly longer ED wait times, higher left without being seen rates, longer boarding times, and longer total length of stay in the ED.',
	'Immediate Outcome',
	'6498c4f8-b0f1-70b5-55de-d84faae73402',
	(SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v1'),
	(select cqm_criterion_type_id from openchpl.cqm_criterion_type where name = 'Ambulatory'),
	false
  WHERE NOT EXISTS (select * from openchpl.cqm_criterion where cms_ID = 'CMS1264');

-- no criterion type (ambulatory vs. inpatient)
--INSERT INTO openchpl.cqm_criterion (cms_id, title, description, cqm_domain, last_modified_sso_user, cqm_version_id, retired)
--  SELECT 'CMS1154',
--	'Screening for Abnormal Glucose Metabolism in Patients at Risk of Developing Diabetes',
--	'Percentage of adult patients with risk factors for type 2 diabetes who are due for glycemic screening for whom the screening process was completed during the measurement period.',
--	'Process',
--	'6498c4f8-b0f1-70b5-55de-d84faae73402',
--	(SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v2'),
--	false
--  WHERE NOT EXISTS (select * from openchpl.cqm_criterion where cms_ID = 'CMS1154' AND cqm_version_id = (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v2'));

-- no criterion type (ambulatory vs. inpatient)
-- already exists?
--INSERT INTO openchpl.cqm_criterion (cms_id, title, description, cqm_domain, last_modified_sso_user, cqm_version_id, retired)
--  SELECT 'CMS1154',
--	'Screening for Abnormal Glucose Metabolism in Patients at Risk of Developing Diabetes',
--	'Percentage of adult patients with risk factors for type 2 diabetes who are due for glycemic screening for whom the screening process was completed during the measurement period.',
--	'Process',
--	'6498c4f8-b0f1-70b5-55de-d84faae73402',
--	(SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v1'),
--	false
--  WHERE NOT EXISTS (select * from openchpl.cqm_criterion where cms_ID = 'CMS1154' AND cqm_version_id = (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v1'));

-- no criterion type (ambulatory vs. inpatient)
-- title looks odd with "FHIR" appended to the end
INSERT INTO openchpl.cqm_criterion (cms_id, title, description, cqm_domain, last_modified_sso_user, cqm_version_id, retired)
  SELECT 'CMS1154FHIR',
	'Screening for Abnormal Glucose Metabolism in Patients at Risk of Developing DiabetesFHIR',
	'Percentage of adult patients with risk factors for type 2 diabetes who are due for glycemic screening for whom the screening process was completed during the measurement period.',
	'Process',
	'6498c4f8-b0f1-70b5-55de-d84faae73402',
	(SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v1'),
	false
  WHERE NOT EXISTS (select * from openchpl.cqm_criterion where cms_ID = 'CMS1154FHIR');
