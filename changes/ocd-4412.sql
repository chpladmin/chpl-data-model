INSERT INTO openchpl.cqm_criterion (cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
  SELECT 'CMS314',
	'HIV Viral Suppression',
	'Percentage of patients, regardless of age, diagnosed with HIV prior to or during the first 90 days of the measurement period, with an eligible encounter in the first 240 days of the measurement period, whose last HIV viral load test result was less than 200 copies/mL ',
	'Intermiedate Clinical Outcome',
	'N/A',
	-1,
	(SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v1'),
	(select cqm_criterion_type_id from openchpl.cqm_criterion_type where name = 'Ambulatory'),
	false
  WHERE NOT EXISTS (select * from openchpl.cqm_criterion where cms_ID = 'CMS314');

