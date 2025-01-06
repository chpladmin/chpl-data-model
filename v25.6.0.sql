-- Deployment file for version 25.6.0
--     as of 2025-01-06
-- ./changes/ocd-4393.sql
INSERT INTO openchpl.cqm_version (version, last_modified_user)
SELECT 'v14', -1
WHERE NOT EXISTS (SELECT version FROM openchpl.cqm_version WHERE version = 'v14');

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

SELECT openchpl.add_version_to_cqm('CMS2', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS22', 'v13', 'v12');
SELECT openchpl.add_version_to_cqm('CMS50', 'v13', 'v12');
SELECT openchpl.add_version_to_cqm('CMS56', 'v13', 'v12');
SELECT openchpl.add_version_to_cqm('CMS68', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS69', 'v13', 'v12');
SELECT openchpl.add_version_to_cqm('CMS74', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS75', 'v13', 'v12');
SELECT openchpl.add_version_to_cqm('CMS90', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS117', 'v13', 'v12');
SELECT openchpl.add_version_to_cqm('CMS122', 'v13', 'v12');
SELECT openchpl.add_version_to_cqm('CMS124', 'v13', 'v12');
SELECT openchpl.add_version_to_cqm('CMS125', 'v13', 'v12');
SELECT openchpl.add_version_to_cqm('CMS128', 'v13', 'v12');
SELECT openchpl.add_version_to_cqm('CMS129', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS130', 'v13', 'v12');
SELECT openchpl.add_version_to_cqm('CMS131', 'v13', 'v12');
SELECT openchpl.add_version_to_cqm('CMS133', 'v13', 'v12');
SELECT openchpl.add_version_to_cqm('CMS135', 'v13', 'v12');
SELECT openchpl.add_version_to_cqm('CMS136', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS137', 'v13', 'v12');
SELECT openchpl.add_version_to_cqm('CMS138', 'v13', 'v12');
SELECT openchpl.add_version_to_cqm('CMS139', 'v13', 'v12');
SELECT openchpl.add_version_to_cqm('CMS142', 'v13', 'v12');
SELECT openchpl.add_version_to_cqm('CMS143', 'v13', 'v12');
SELECT openchpl.add_version_to_cqm('CMS144', 'v13', 'v12');
SELECT openchpl.add_version_to_cqm('CMS145', 'v13', 'v12');
SELECT openchpl.add_version_to_cqm('CMS146', 'v13', 'v12');
SELECT openchpl.add_version_to_cqm('CMS149', 'v13', 'v12');
SELECT openchpl.add_version_to_cqm('CMS153', 'v13', 'v12');
SELECT openchpl.add_version_to_cqm('CMS154', 'v13', 'v12');
SELECT openchpl.add_version_to_cqm('CMS155', 'v13', 'v12');
SELECT openchpl.add_version_to_cqm('CMS156', 'v13', 'v12');
SELECT openchpl.add_version_to_cqm('CMS157', 'v13', 'v12');
SELECT openchpl.add_version_to_cqm('CMS159', 'v13', 'v12');
SELECT openchpl.add_version_to_cqm('CMS165', 'v13', 'v12');
SELECT openchpl.add_version_to_cqm('CMS177', 'v13', 'v12');
SELECT openchpl.add_version_to_cqm('CMS314', 'v2', 'v1');
SELECT openchpl.add_version_to_cqm('CMS347', 'v8', 'v7');
SELECT openchpl.add_version_to_cqm('CMS349', 'v7', 'v6');
SELECT openchpl.add_version_to_cqm('CMS645', 'v8', 'v7');
SELECT openchpl.add_version_to_cqm('CMS646', 'v5', 'v4');
SELECT openchpl.add_version_to_cqm('CMS771', 'v6', 'v5');
SELECT openchpl.add_version_to_cqm('CMS71', 'v14', 'v13');
SELECT openchpl.add_version_to_cqm('CMS72', 'v13', 'v12');
SELECT openchpl.add_version_to_cqm('CMS104', 'v13', 'v12');
SELECT openchpl.add_version_to_cqm('CMS108', 'v13', 'v12');
SELECT openchpl.add_version_to_cqm('CMS190', 'v13', 'v12');
SELECT openchpl.add_version_to_cqm('CMS506', 'v7', 'v6');
SELECT openchpl.add_version_to_cqm('CMS529', 'v5', 'v4');
SELECT openchpl.add_version_to_cqm('CMS844', 'v5', 'v4');
SELECT openchpl.add_version_to_cqm('CMS951', 'v3', 'v2');
SELECT openchpl.add_version_to_cqm('CMS334', 'v6', 'v5');
SELECT openchpl.add_version_to_cqm('CMS816', 'v4', 'v3');
SELECT openchpl.add_version_to_cqm('CMS871', 'v4', 'v3');
SELECT openchpl.add_version_to_cqm('CMS1028', 'v3', 'v2');
SELECT openchpl.add_version_to_cqm('CMS996', 'v5', 'v4');
SELECT openchpl.add_version_to_cqm('CMS1188', 'v2', 'v1');
SELECT openchpl.add_version_to_cqm('CMS819', 'v3', 'v2');
SELECT openchpl.add_version_to_cqm('CMS986', 'v4', 'v2');

drop function openchpl.add_version_to_cqm;

INSERT INTO openchpl.cqm_criterion (cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
  SELECT 'CMS1157', 
	'HIV Annual Retention in Care', 
	'Percentage of patients, regardless of age, with a diagnosis of Human Immunodeficiency Virus (HIV) during the first 240 days of the measurement period or before the measurement period who had at least two eligible encounters or at least one eligible encounter and one HIV viral load test that were at least 90 days apart within the measurement period', 
	'Health Resources & Services Administration', 
	'N/A', 
	-1, 
	(SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v1'), 
	(select cqm_criterion_type_id from openchpl.cqm_criterion_type where name = 'Ambulatory'), 
	false
  WHERE NOT EXISTS (select * from openchpl.cqm_criterion where cms_ID = 'CMS1157');

INSERT INTO openchpl.cqm_criterion (cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
  SELECT 'CMS826', 
	'Hospital Harm - Pressure Injury', 
	'The measure assesses the number of inpatient hospitalizations for patients aged 18 and older who suffer the harm of developing a new stage 2, stage 3, stage 4, deep tissue, or unstageable pressure injury', 
	NULL, 
	'3498e', 
	-1, 
	(SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v2'), 
	(select cqm_criterion_type_id from openchpl.cqm_criterion_type where name = 'Inpatient'), 
	false
  WHERE NOT EXISTS (select * from openchpl.cqm_criterion where cms_ID = 'CMS826');

INSERT INTO openchpl.cqm_criterion (cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
  SELECT 'CMS832', 
	'Hospital Harm - Acute Kidney Injury', 
	'The measure assesses the number of inpatient hospitalizations for patients age 18 and older who have an acute kidney injury (stage 2 or greater) that occurred during the encounter. Acute kidney injury (AKI) stage 2 or greater is defined as a substantial increase in serum creatinine value, or by the initiation of kidney dialysis (continuous renal replacement therapy (CRRT), hemodialysis or peritoneal dialysis).', 
	NULL, 
	'3713e', 
	-1, 
	(SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v2'), 
	(select cqm_criterion_type_id from openchpl.cqm_criterion_type where name = 'Inpatient'), 
	false
  WHERE NOT EXISTS (select * from openchpl.cqm_criterion where cms_ID = 'CMS832');

INSERT INTO openchpl.cqm_criterion (cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
  SELECT 'CMS1074', 
	'Excessive Radiation Dose or Inadequate Image Quality for Diagnostic Computed Tomography (CT) in Adults (Facility IQR)', 
	'This measure provides a standardized method for monitoring the performance of diagnostic CT to discourage unnecessarily high radiation doses, a risk factor for cancer, while preserving image quality. This measure is expressed as a percentage of CT exams that are out-of-range based on having either excessive radiation dose or inadequate image quality relative to evidence-based thresholds based on the clinical indication for the exam. All diagnostic CT exams of specified anatomic sites performed in hospital inpatient care settings are eligible. This eCQM requires the use of additional software to access primary data elements stored within radiology electronic health records and translate them into data elements that can be ingested by this eCQM. Additional details are included in the Guidance field.', 
	'Intermediate Clinical Outcome', 
	'3663e', 
	-1, 
	(SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v2'), 
	(select cqm_criterion_type_id from openchpl.cqm_criterion_type where name = 'Inpatient'), 
	false
  WHERE NOT EXISTS (select * from openchpl.cqm_criterion where cms_ID = 'CMS1074');

INSERT INTO openchpl.cqm_criterion (cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
  SELECT 'CMS1206', 
	'Excessive Radiation Dose or Inadequate Image Quality for Diagnostic Computed Tomography (CT) in Adults (Facility OQR)', 
	'This measure is an episode of care measure that provides a standardized method for monitoring the performance of diagnostic CT to discourage unnecessarily high radiation doses, a risk factor for cancer, while preserving image quality. This measure is expressed as a percentage of CT exams that are out-of-range based on having either excessive radiation dose or inadequate image quality relative to evidence-based thresholds based on the clinical indication for the exam. All diagnostic CT exams of specified anatomic sites performed in hospital non-inpatient care settings (including emergency settings) are eligible. This eCQM requires the use of additional software to access primary data elements stored within radiology electronic health records and translate them into data elements that can be ingested by this eCQM. Additional details are included in the Guidance field.', 
	'Intermediate Clinical Outcome', 
	'3663e', 
	-1, 
	(SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v2'), 
	(select cqm_criterion_type_id from openchpl.cqm_criterion_type where name = 'Ambulatory'), 
	false
  WHERE NOT EXISTS (select * from openchpl.cqm_criterion where cms_ID = 'CMS1206');

INSERT INTO openchpl.cqm_criterion_type (name, description, last_modified_user)
	SELECT 'Inpatient and Ambulatory',
		'Inpatient and Ambulatory',
		-1
	WHERE NOT EXISTS (select * from openchpl.cqm_criterion_type where name = 'Inpatient and Ambulatory');
			
INSERT INTO openchpl.cqm_criterion (cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
  SELECT 'CMS1056', 
	'Excessive Radiation Dose or Inadequate Image Quality for Diagnostic Computed Tomography (CT) in Adults (Clinician Level)', 
	'This measure provides a standardized method for monitoring the performance of diagnostic CT to discourage unnecessarily high radiation doses, a risk factor for cancer, while preserving image quality. It is expressed as a percentage of patients with CT exams that are out-of-range based on having either excessive radiation dose or inadequate image quality relative to evidence-based thresholds based on the clinical indication for the exam. All diagnostic CT exams of specified anatomic sites performed in inpatient, outpatient and ambulatory care settings are eligible. This measure is not telehealth eligible. This eCQM requires the use of additional software to access primary data elements stored within radiology electronic health records and translate them into data elements that can be ingested by this eCQM. Additional details are included in the Guidance field.', 
	'Intermediate Clinical Outcome', 
	'3663e', 
	-1, 
	(SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v2'), 
	(select cqm_criterion_type_id from openchpl.cqm_criterion_type where name = 'Inpatient and Ambulatory'), 
	false
  WHERE NOT EXISTS (select * from openchpl.cqm_criterion where cms_ID = 'CMS1056');
;
-- ./changes/ocd-4516.sql
CREATE TABLE IF NOT EXISTS openchpl.attestation_report (
    id bigserial not null,
	report_date date not null,
    attestation_period_id bigint not null,
	certification_body_id bigint not null,
    developer_count bigint,
	approved_count bigint,
    pending_acb_action_count bigint,
    pending_developer_action_count bigint,
    no_submission_count bigint,
    creation_date timestamp not null default now(),
    last_modified_date timestamp not null default now(),
    last_modified_user bigint,
    last_modified_sso_user uuid,
    deleted bool not null default false,
    CONSTRAINT attestation_report_pk PRIMARY KEY (id),
	CONSTRAINT attestation_period_fk FOREIGN KEY (attestation_period_id)
		REFERENCES openchpl.attestation_period (id)
		MATCH simple ON UPDATE NO ACTION ON DELETE RESTRICT,
	CONSTRAINT certification_body_fk FOREIGN KEY (certification_body_id)
		REFERENCES openchpl.certification_body (certification_body_id)
		MATCH simple ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE OR replace TRIGGER attestation_report_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.attestation_report FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE OR replace TRIGGER attestation_report_timestamp BEFORE UPDATE on openchpl.attestation_report FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS attestation_report_last_modified_user_constraint ON openchpl.attestation_report;
CREATE CONSTRAINT TRIGGER attestation_report_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.attestation_report DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'DEV', 
        'Developer Attestations',
        'DeveloperAttestations', 
        'dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiYzU0YzE5Y2YtMzNlZS00NDgzLTlmZTQtZjA0ZWQ0YzI4OGQ3IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '700px',
        9,
        -1
where not exists (
        select * from openchpl.report_metadata where environment = 'DEV' and report_key = 'DeveloperAttestations'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'QA', 
        'Developer Attestations',
        'DeveloperAttestations', 
        'dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiOGM2YzM3NzgtZjlhMS00OTFiLTkwNjQtOTViOGY0OWYxMDUwIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '700px',
        9,
        -1
where not exists (
        select * from openchpl.report_metadata where environment = 'QA' and report_key = 'DeveloperAttestations'
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'STG', 
        'Developer Attestations',
        'DeveloperAttestations', 
        'dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiMGI0MjM2NWUtNmU5Yi00NzI3LTllYTctNmZhMDQ4NTMwOWUzIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '700px',
        9,
        -1
where not exists (
        select * from openchpl.report_metadata where environment = 'STG' and report_key = 'DeveloperAttestations' 
);

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'PROD', 
        'Developer Attestations',
        'DeveloperAttestations', 
        'dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiYTgzYjczMjktYjY1Yi00OWU3LTg0NDMtNzZlNDQ1NWRjMjcxIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '700px',
        9,
        -1
where not exists (
        select * from openchpl.report_metadata where environment = 'PROD' and report_key = 'DeveloperAttestations' 
);
        
;
-- ./changes/ocd-4753.sql
insert into openchpl.activity_concept (concept, last_modified_user)
select 'INVITATION', 
        -1
where not exists (
        select * from openchpl.activity_concept where concept = 'INVITATION'
);
;
-- ./changes/ocd-4767.sql
update openchpl.url_uptime_monitor_test
set deleted = true,
	last_modified_sso_user = null,
	last_modified_user = -1
where passed = false
and url_uptime_monitor_id in (
	select id
	from openchpl.url_uptime_monitor
	where url = 'https://fhir.meditouchehr.com/api/fhir/r4/endpoint'
);

;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('25.6.0', '2025-01-06', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
