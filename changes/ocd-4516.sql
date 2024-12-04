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
        '',
        '700px',
        9,
        -1
where not exists (
        select * from openchpl.report_metadata where environment = 'PROD' and report_key = 'DeveloperAttestations' 
);
        