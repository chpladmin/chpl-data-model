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
