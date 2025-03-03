-- Deployment file for version 26.0.0
--     as of 2025-03-03
-- ./changes/ocd-4517.sql
CREATE TABLE IF NOT EXISTS openchpl.real_world_testing_plan_summary_report (
    id bigserial not null,
    real_world_testing_year bigint not null,
    certification_body_id bigint not null,
    checked_date date not null,
    checked_count bigint,
    requires_check_count bigint,
    creation_date timestamp not null default now(),
    last_modified_date timestamp not null default now(),
    last_modified_user bigint,
    last_modified_sso_user uuid,
    deleted bool not null default false,
    CONSTRAINT real_world_testing_plan_summary_report_pk PRIMARY KEY (id),
    CONSTRAINT certification_body_fk FOREIGN KEY (certification_body_id)
		REFERENCES openchpl.certification_body (certification_body_id)
		MATCH simple ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE OR replace TRIGGER real_world_testing_plan_summary_report_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.real_world_testing_plan_summary_report FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE OR replace TRIGGER real_world_testing_plan_summary_report_timestamp BEFORE UPDATE on openchpl.real_world_testing_plan_summary_report FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS real_world_testing_plan_summary_report_last_modified_user_constraint ON openchpl.real_world_testing_plan_summary_report;
CREATE CONSTRAINT TRIGGER real_world_testing_plan_summary_report_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.real_world_testing_plan_summary_report DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();

CREATE TABLE IF NOT EXISTS openchpl.real_world_testing_results_summary_report (
    id bigserial not null,
    real_world_testing_year bigint not null,
    certification_body_id bigint not null,
    checked_date date not null,
    checked_count bigint,
    requires_check_count bigint,
    creation_date timestamp not null default now(),
    last_modified_date timestamp not null default now(),
    last_modified_user bigint,
    last_modified_sso_user uuid,
    deleted bool not null default false,
    CONSTRAINT real_world_testing_results_summary_report_pk PRIMARY KEY (id),
    CONSTRAINT certification_body_fk FOREIGN KEY (certification_body_id)
                REFERENCES openchpl.certification_body (certification_body_id)
                MATCH simple ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE OR replace TRIGGER real_world_testing_results_summary_report_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.real_world_testing_results_summary_report FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE OR replace TRIGGER real_world_testing_results_summary_report_timestamp BEFORE UPDATE on openchpl.real_world_testing_results_summary_report FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS real_world_testing_results_summary_report_last_modified_user_constraint ON openchpl.real_world_testing_results_summary_report;
CREATE CONSTRAINT TRIGGER real_world_testing_results_summary_report_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.real_world_testing_results_summary_report DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'DEV', 'Real World Testing Summary', 'RealWorldTestingSummary', 'dashboard',
    'https://app.powerbi.com/view?r=eyJrIjoiNjYwYWQxYWMtYTkxMy00NGZkLWEwMWQtNTFhZmRkOGRlNDVlIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
	'835px', 9, -1
where not exists (
    select * 
	from openchpl.report_metadata
	where environment = 'DEV'
	and report_key = 'RealWorldTestingSummary');

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'QA', 'Real World Testing Summary', 'RealWorldTestingSummary', 'dashboard',
    'https://app.powerbi.com/view?r=eyJrIjoiYzRlZTc1YTYtY2QzYy00NmE0LTg3NmEtZTk0YjBhZWVjY2I1IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
	'835px', 9, -1
where not exists (
    select * 
	from openchpl.report_metadata
	where environment = 'QA'
	and report_key = 'RealWorldTestingSummary');

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'STG', 'Real World Testing Summary', 'RealWorldTestingSummary', 'dashboard',
    'https://app.powerbi.com/view?r=eyJrIjoiZGQxZTc3MDctM2Y3NC00MjhmLWEzZGItMDdhYjkzYTQ4M2NiIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
	'835px', 9, -1
where not exists (
    select * 
	from openchpl.report_metadata
	where environment = 'STG'
	and report_key = 'RealWorldTestingSummary');

insert into openchpl.report_metadata (environment, title, report_key, report_group, url, height, display_order, last_modified_user)
select 'PROD', 'Real World Testing Summary', 'RealWorldTestingSummary', 'dashboard',
    'https://app.powerbi.com/view?r=eyJrIjoiMmUxZWUwNmQtMTExNi00OGVmLTk1YjItNzY1Y2YzNWM5ZjQ0IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
	'835px', 9, -1
where not exists (
    select * 
	from openchpl.report_metadata
	where environment = 'PROD'
	and report_key = 'RealWorldTestingSummary');

ALTER TABLE openchpl.real_world_testing_plan_summary_report
ADD CONSTRAINT temp_unique_rwt_plan_summary_report
UNIQUE(real_world_testing_year, certification_body_id, checked_date);

INSERT INTO openchpl.real_world_testing_plan_summary_report (real_world_testing_year,certification_body_id,checked_date,checked_count,requires_check_count,last_modified_user) VALUES
	 (2025,3,'2024-09-01',0,450,-1),
	 (2025,4,'2024-09-01',0,148,-1),
	 (2025,8,'2024-09-01',0,12,-1),
	 (2025,3,'2024-09-02',0,450,-1),
	 (2025,4,'2024-09-02',0,148,-1),
	 (2025,8,'2024-09-02',0,12,-1),
	 (2025,3,'2024-09-03',0,450,-1),
	 (2025,4,'2024-09-03',0,148,-1),
	 (2025,8,'2024-09-03',0,12,-1),
	 (2025,3,'2024-09-04',0,450,-1) ON CONFLICT (real_world_testing_year, certification_body_id, checked_date) DO NOTHING;
INSERT INTO openchpl.real_world_testing_plan_summary_report (real_world_testing_year,certification_body_id,checked_date,checked_count,requires_check_count,last_modified_user) VALUES
	 (2025,4,'2024-09-04',0,148,-1),
	 (2025,8,'2024-09-04',0,12,-1),
	 (2025,3,'2024-09-05',0,450,-1),
	 (2025,4,'2024-09-05',1,148,-1),
	 (2025,8,'2024-09-05',0,12,-1),
	 (2025,3,'2024-09-06',0,450,-1),
	 (2025,4,'2024-09-06',3,148,-1),
	 (2025,8,'2024-09-06',0,12,-1),
	 (2025,3,'2024-09-07',0,450,-1),
	 (2025,4,'2024-09-07',3,148,-1) ON CONFLICT (real_world_testing_year, certification_body_id, checked_date) DO NOTHING;
INSERT INTO openchpl.real_world_testing_plan_summary_report (real_world_testing_year,certification_body_id,checked_date,checked_count,requires_check_count,last_modified_user) VALUES
	 (2025,8,'2024-09-07',0,12,-1),
	 (2025,3,'2024-09-08',0,450,-1),
	 (2025,4,'2024-09-08',3,148,-1),
	 (2025,8,'2024-09-08',0,12,-1),
	 (2025,3,'2024-09-09',0,450,-1),
	 (2025,4,'2024-09-09',3,148,-1),
	 (2025,8,'2024-09-09',0,12,-1),
	 (2025,3,'2024-09-10',0,450,-1),
	 (2025,4,'2024-09-10',3,148,-1),
	 (2025,8,'2024-09-10',0,12,-1) ON CONFLICT (real_world_testing_year, certification_body_id, checked_date) DO NOTHING;
INSERT INTO openchpl.real_world_testing_plan_summary_report (real_world_testing_year,certification_body_id,checked_date,checked_count,requires_check_count,last_modified_user) VALUES
	 (2025,3,'2024-09-11',0,450,-1),
	 (2025,4,'2024-09-11',3,148,-1),
	 (2025,8,'2024-09-11',0,12,-1),
	 (2025,3,'2024-09-12',4,450,-1),
	 (2025,4,'2024-09-12',4,148,-1),
	 (2025,8,'2024-09-12',0,12,-1),
	 (2025,3,'2024-09-13',4,450,-1),
	 (2025,4,'2024-09-13',5,148,-1),
	 (2025,8,'2024-09-13',0,12,-1),
	 (2025,3,'2024-09-14',4,450,-1) ON CONFLICT (real_world_testing_year, certification_body_id, checked_date) DO NOTHING;
INSERT INTO openchpl.real_world_testing_plan_summary_report (real_world_testing_year,certification_body_id,checked_date,checked_count,requires_check_count,last_modified_user) VALUES
	 (2025,4,'2024-09-14',5,148,-1),
	 (2025,8,'2024-09-14',0,12,-1),
	 (2025,3,'2024-09-15',4,450,-1),
	 (2025,4,'2024-09-15',5,148,-1),
	 (2025,8,'2024-09-15',0,12,-1),
	 (2025,3,'2024-09-16',4,450,-1),
	 (2025,4,'2024-09-16',5,148,-1),
	 (2025,8,'2024-09-16',0,12,-1),
	 (2025,3,'2024-09-17',5,450,-1),
	 (2025,4,'2024-09-17',6,148,-1) ON CONFLICT (real_world_testing_year, certification_body_id, checked_date) DO NOTHING;
INSERT INTO openchpl.real_world_testing_plan_summary_report (real_world_testing_year,certification_body_id,checked_date,checked_count,requires_check_count,last_modified_user) VALUES
	 (2025,8,'2024-09-17',0,12,-1),
	 (2025,3,'2024-09-18',6,450,-1),
	 (2025,4,'2024-09-18',8,148,-1),
	 (2025,8,'2024-09-18',0,12,-1),
	 (2025,3,'2024-09-19',7,450,-1),
	 (2025,4,'2024-09-19',8,148,-1),
	 (2025,8,'2024-09-19',0,12,-1),
	 (2025,3,'2024-09-20',7,451,-1),
	 (2025,4,'2024-09-20',8,148,-1),
	 (2025,8,'2024-09-20',0,12,-1) ON CONFLICT (real_world_testing_year, certification_body_id, checked_date) DO NOTHING;
INSERT INTO openchpl.real_world_testing_plan_summary_report (real_world_testing_year,certification_body_id,checked_date,checked_count,requires_check_count,last_modified_user) VALUES
	 (2025,3,'2024-09-21',7,451,-1),
	 (2025,4,'2024-09-21',8,148,-1),
	 (2025,8,'2024-09-21',0,12,-1),
	 (2025,3,'2024-09-22',7,451,-1),
	 (2025,4,'2024-09-22',8,148,-1),
	 (2025,8,'2024-09-22',0,12,-1),
	 (2025,3,'2024-09-23',9,451,-1),
	 (2025,4,'2024-09-23',9,148,-1),
	 (2025,8,'2024-09-23',0,12,-1),
	 (2025,3,'2024-09-24',10,452,-1) ON CONFLICT (real_world_testing_year, certification_body_id, checked_date) DO NOTHING;
INSERT INTO openchpl.real_world_testing_plan_summary_report (real_world_testing_year,certification_body_id,checked_date,checked_count,requires_check_count,last_modified_user) VALUES
	 (2025,4,'2024-09-24',11,148,-1),
	 (2025,8,'2024-09-24',0,12,-1),
	 (2025,3,'2024-09-25',12,453,-1),
	 (2025,4,'2024-09-25',12,148,-1),
	 (2025,8,'2024-09-25',0,12,-1),
	 (2025,3,'2024-09-26',14,453,-1),
	 (2025,4,'2024-09-26',13,148,-1),
	 (2025,8,'2024-09-26',0,12,-1),
	 (2025,3,'2024-09-27',20,453,-1),
	 (2025,4,'2024-09-27',14,148,-1) ON CONFLICT (real_world_testing_year, certification_body_id, checked_date) DO NOTHING;
INSERT INTO openchpl.real_world_testing_plan_summary_report (real_world_testing_year,certification_body_id,checked_date,checked_count,requires_check_count,last_modified_user) VALUES
	 (2025,8,'2024-09-27',0,12,-1),
	 (2025,3,'2024-09-28',20,453,-1),
	 (2025,4,'2024-09-28',14,148,-1),
	 (2025,8,'2024-09-28',0,12,-1),
	 (2025,3,'2024-09-29',20,453,-1),
	 (2025,4,'2024-09-29',14,148,-1),
	 (2025,8,'2024-09-29',0,12,-1),
	 (2025,3,'2024-09-30',22,454,-1),
	 (2025,4,'2024-09-30',14,148,-1),
	 (2025,8,'2024-09-30',0,12,-1) ON CONFLICT (real_world_testing_year, certification_body_id, checked_date) DO NOTHING;
INSERT INTO openchpl.real_world_testing_plan_summary_report (real_world_testing_year,certification_body_id,checked_date,checked_count,requires_check_count,last_modified_user) VALUES
	 (2025,3,'2024-10-01',22,454,-1),
	 (2025,4,'2024-10-01',14,148,-1),
	 (2025,8,'2024-10-01',0,12,-1),
	 (2025,3,'2024-10-02',23,454,-1),
	 (2025,4,'2024-10-02',17,148,-1),
	 (2025,8,'2024-10-02',0,12,-1),
	 (2025,3,'2024-10-03',23,454,-1),
	 (2025,4,'2024-10-03',20,148,-1),
	 (2025,8,'2024-10-03',0,12,-1),
	 (2025,3,'2024-10-04',25,454,-1) ON CONFLICT (real_world_testing_year, certification_body_id, checked_date) DO NOTHING;
INSERT INTO openchpl.real_world_testing_plan_summary_report (real_world_testing_year,certification_body_id,checked_date,checked_count,requires_check_count,last_modified_user) VALUES
	 (2025,4,'2024-10-04',23,148,-1),
	 (2025,8,'2024-10-04',0,12,-1),
	 (2025,3,'2024-10-05',25,454,-1),
	 (2025,4,'2024-10-05',23,148,-1),
	 (2025,8,'2024-10-05',0,12,-1),
	 (2025,3,'2024-10-06',25,454,-1),
	 (2025,4,'2024-10-06',23,148,-1),
	 (2025,8,'2024-10-06',0,12,-1),
	 (2025,3,'2024-10-07',26,454,-1),
	 (2025,4,'2024-10-07',25,148,-1) ON CONFLICT (real_world_testing_year, certification_body_id, checked_date) DO NOTHING;
INSERT INTO openchpl.real_world_testing_plan_summary_report (real_world_testing_year,certification_body_id,checked_date,checked_count,requires_check_count,last_modified_user) VALUES
	 (2025,8,'2024-10-07',0,12,-1),
	 (2025,3,'2024-10-08',28,454,-1),
	 (2025,4,'2024-10-08',28,148,-1),
	 (2025,8,'2024-10-08',0,12,-1),
	 (2025,3,'2024-10-09',36,457,-1),
	 (2025,4,'2024-10-09',31,148,-1),
	 (2025,8,'2024-10-09',1,12,-1),
	 (2025,3,'2024-10-10',38,457,-1),
	 (2025,4,'2024-10-10',37,148,-1),
	 (2025,8,'2024-10-10',1,12,-1) ON CONFLICT (real_world_testing_year, certification_body_id, checked_date) DO NOTHING;
INSERT INTO openchpl.real_world_testing_plan_summary_report (real_world_testing_year,certification_body_id,checked_date,checked_count,requires_check_count,last_modified_user) VALUES
	 (2025,3,'2024-10-11',39,457,-1),
	 (2025,4,'2024-10-11',41,148,-1),
	 (2025,8,'2024-10-11',1,12,-1),
	 (2025,3,'2024-10-12',39,457,-1),
	 (2025,4,'2024-10-12',41,148,-1),
	 (2025,8,'2024-10-12',1,12,-1),
	 (2025,3,'2024-10-13',39,457,-1),
	 (2025,4,'2024-10-13',41,148,-1),
	 (2025,8,'2024-10-13',1,12,-1),
	 (2025,3,'2024-10-14',39,457,-1) ON CONFLICT (real_world_testing_year, certification_body_id, checked_date) DO NOTHING;
INSERT INTO openchpl.real_world_testing_plan_summary_report (real_world_testing_year,certification_body_id,checked_date,checked_count,requires_check_count,last_modified_user) VALUES
	 (2025,4,'2024-10-14',41,148,-1),
	 (2025,8,'2024-10-14',4,12,-1),
	 (2025,3,'2024-10-15',39,457,-1),
	 (2025,4,'2024-10-15',43,148,-1),
	 (2025,8,'2024-10-15',4,12,-1),
	 (2025,3,'2024-10-16',39,457,-1),
	 (2025,4,'2024-10-16',43,148,-1),
	 (2025,8,'2024-10-16',4,12,-1),
	 (2025,3,'2024-10-17',41,457,-1),
	 (2025,4,'2024-10-17',43,148,-1) ON CONFLICT (real_world_testing_year, certification_body_id, checked_date) DO NOTHING;
INSERT INTO openchpl.real_world_testing_plan_summary_report (real_world_testing_year,certification_body_id,checked_date,checked_count,requires_check_count,last_modified_user) VALUES
	 (2025,8,'2024-10-17',4,12,-1),
	 (2025,3,'2024-10-18',41,457,-1),
	 (2025,4,'2024-10-18',44,148,-1),
	 (2025,8,'2024-10-18',4,12,-1),
	 (2025,3,'2024-10-19',41,457,-1),
	 (2025,4,'2024-10-19',44,148,-1),
	 (2025,8,'2024-10-19',4,12,-1),
	 (2025,3,'2024-10-20',41,457,-1),
	 (2025,4,'2024-10-20',44,148,-1),
	 (2025,8,'2024-10-20',4,12,-1) ON CONFLICT (real_world_testing_year, certification_body_id, checked_date) DO NOTHING;
INSERT INTO openchpl.real_world_testing_plan_summary_report (real_world_testing_year,certification_body_id,checked_date,checked_count,requires_check_count,last_modified_user) VALUES
	 (2025,3,'2024-10-21',54,457,-1),
	 (2025,4,'2024-10-21',44,148,-1),
	 (2025,8,'2024-10-21',4,12,-1),
	 (2025,3,'2024-10-22',71,457,-1),
	 (2025,4,'2024-10-22',44,148,-1),
	 (2025,8,'2024-10-22',5,12,-1),
	 (2025,3,'2024-10-23',72,457,-1),
	 (2025,4,'2024-10-23',45,148,-1),
	 (2025,8,'2024-10-23',5,12,-1),
	 (2025,3,'2024-10-24',73,458,-1) ON CONFLICT (real_world_testing_year, certification_body_id, checked_date) DO NOTHING;
INSERT INTO openchpl.real_world_testing_plan_summary_report (real_world_testing_year,certification_body_id,checked_date,checked_count,requires_check_count,last_modified_user) VALUES
	 (2025,4,'2024-10-24',49,148,-1),
	 (2025,8,'2024-10-24',5,12,-1),
	 (2025,3,'2024-10-25',75,458,-1),
	 (2025,4,'2024-10-25',52,148,-1),
	 (2025,8,'2024-10-25',5,12,-1),
	 (2025,3,'2024-10-26',75,458,-1),
	 (2025,4,'2024-10-26',52,148,-1),
	 (2025,8,'2024-10-26',5,12,-1),
	 (2025,3,'2024-10-27',75,458,-1),
	 (2025,4,'2024-10-27',52,148,-1) ON CONFLICT (real_world_testing_year, certification_body_id, checked_date) DO NOTHING;
INSERT INTO openchpl.real_world_testing_plan_summary_report (real_world_testing_year,certification_body_id,checked_date,checked_count,requires_check_count,last_modified_user) VALUES
	 (2025,8,'2024-10-27',5,12,-1),
	 (2025,3,'2024-10-28',81,463,-1),
	 (2025,4,'2024-10-28',56,148,-1),
	 (2025,8,'2024-10-28',5,12,-1),
	 (2025,3,'2024-10-29',114,463,-1),
	 (2025,4,'2024-10-29',57,148,-1),
	 (2025,8,'2024-10-29',6,12,-1),
	 (2025,3,'2024-10-30',133,463,-1),
	 (2025,4,'2024-10-30',63,148,-1),
	 (2025,8,'2024-10-30',6,12,-1) ON CONFLICT (real_world_testing_year, certification_body_id, checked_date) DO NOTHING;
INSERT INTO openchpl.real_world_testing_plan_summary_report (real_world_testing_year,certification_body_id,checked_date,checked_count,requires_check_count,last_modified_user) VALUES
	 (2025,3,'2024-10-31',165,463,-1),
	 (2025,4,'2024-10-31',72,148,-1),
	 (2025,8,'2024-10-31',6,12,-1),
	 (2025,3,'2024-11-01',174,464,-1),
	 (2025,4,'2024-11-01',75,148,-1),
	 (2025,8,'2024-11-01',6,12,-1),
	 (2025,3,'2024-11-02',174,464,-1),
	 (2025,4,'2024-11-02',75,148,-1),
	 (2025,8,'2024-11-02',6,12,-1),
	 (2025,3,'2024-11-03',174,464,-1) ON CONFLICT (real_world_testing_year, certification_body_id, checked_date) DO NOTHING;
INSERT INTO openchpl.real_world_testing_plan_summary_report (real_world_testing_year,certification_body_id,checked_date,checked_count,requires_check_count,last_modified_user) VALUES
	 (2025,4,'2024-11-03',75,148,-1),
	 (2025,8,'2024-11-03',6,12,-1),
	 (2025,3,'2024-11-04',180,464,-1),
	 (2025,4,'2024-11-04',79,148,-1),
	 (2025,8,'2024-11-04',7,12,-1),
	 (2025,3,'2024-11-05',182,464,-1),
	 (2025,4,'2024-11-05',86,148,-1),
	 (2025,8,'2024-11-05',7,12,-1),
	 (2025,3,'2024-11-06',189,464,-1),
	 (2025,4,'2024-11-06',88,148,-1) ON CONFLICT (real_world_testing_year, certification_body_id, checked_date) DO NOTHING;
INSERT INTO openchpl.real_world_testing_plan_summary_report (real_world_testing_year,certification_body_id,checked_date,checked_count,requires_check_count,last_modified_user) VALUES
	 (2025,8,'2024-11-06',7,12,-1),
	 (2025,3,'2024-11-07',191,464,-1),
	 (2025,4,'2024-11-07',92,148,-1),
	 (2025,8,'2024-11-07',7,12,-1),
	 (2025,3,'2024-11-08',199,464,-1),
	 (2025,4,'2024-11-08',96,148,-1),
	 (2025,8,'2024-11-08',7,12,-1),
	 (2025,3,'2024-11-09',199,464,-1),
	 (2025,4,'2024-11-09',96,148,-1),
	 (2025,8,'2024-11-09',7,12,-1) ON CONFLICT (real_world_testing_year, certification_body_id, checked_date) DO NOTHING;
INSERT INTO openchpl.real_world_testing_plan_summary_report (real_world_testing_year,certification_body_id,checked_date,checked_count,requires_check_count,last_modified_user) VALUES
	 (2025,3,'2024-11-10',199,464,-1),
	 (2025,4,'2024-11-10',96,148,-1),
	 (2025,8,'2024-11-10',7,12,-1),
	 (2025,3,'2024-11-11',210,464,-1),
	 (2025,4,'2024-11-11',99,148,-1),
	 (2025,8,'2024-11-11',7,12,-1),
	 (2025,3,'2024-11-12',236,465,-1),
	 (2025,4,'2024-11-12',101,148,-1),
	 (2025,8,'2024-11-12',8,12,-1),
	 (2025,3,'2024-11-13',253,465,-1) ON CONFLICT (real_world_testing_year, certification_body_id, checked_date) DO NOTHING;
INSERT INTO openchpl.real_world_testing_plan_summary_report (real_world_testing_year,certification_body_id,checked_date,checked_count,requires_check_count,last_modified_user) VALUES
	 (2025,4,'2024-11-13',102,148,-1),
	 (2025,8,'2024-11-13',9,12,-1),
	 (2025,3,'2024-11-14',264,465,-1),
	 (2025,4,'2024-11-14',105,148,-1),
	 (2025,8,'2024-11-14',10,12,-1),
	 (2025,3,'2024-11-15',267,465,-1),
	 (2025,4,'2024-11-15',106,149,-1),
	 (2025,8,'2024-11-15',12,12,-1),
	 (2025,3,'2024-11-16',267,465,-1),
	 (2025,4,'2024-11-16',106,149,-1) ON CONFLICT (real_world_testing_year, certification_body_id, checked_date) DO NOTHING;
INSERT INTO openchpl.real_world_testing_plan_summary_report (real_world_testing_year,certification_body_id,checked_date,checked_count,requires_check_count,last_modified_user) VALUES
	 (2025,8,'2024-11-16',12,12,-1),
	 (2025,3,'2024-11-17',267,465,-1),
	 (2025,4,'2024-11-17',106,149,-1),
	 (2025,8,'2024-11-17',12,12,-1),
	 (2025,3,'2024-11-18',276,465,-1),
	 (2025,4,'2024-11-18',110,149,-1),
	 (2025,8,'2024-11-18',12,12,-1),
	 (2025,3,'2024-11-19',279,465,-1),
	 (2025,4,'2024-11-19',111,149,-1),
	 (2025,8,'2024-11-19',12,12,-1) ON CONFLICT (real_world_testing_year, certification_body_id, checked_date) DO NOTHING;
INSERT INTO openchpl.real_world_testing_plan_summary_report (real_world_testing_year,certification_body_id,checked_date,checked_count,requires_check_count,last_modified_user) VALUES
	 (2025,3,'2024-11-20',298,465,-1),
	 (2025,4,'2024-11-20',111,149,-1),
	 (2025,8,'2024-11-20',12,12,-1),
	 (2025,3,'2024-11-21',309,465,-1),
	 (2025,4,'2024-11-21',111,149,-1),
	 (2025,8,'2024-11-21',12,12,-1),
	 (2025,3,'2024-11-22',316,465,-1),
	 (2025,4,'2024-11-22',113,149,-1),
	 (2025,8,'2024-11-22',12,12,-1),
	 (2025,3,'2024-11-23',316,465,-1) ON CONFLICT (real_world_testing_year, certification_body_id, checked_date) DO NOTHING;
INSERT INTO openchpl.real_world_testing_plan_summary_report (real_world_testing_year,certification_body_id,checked_date,checked_count,requires_check_count,last_modified_user) VALUES
	 (2025,4,'2024-11-23',113,149,-1),
	 (2025,8,'2024-11-23',12,12,-1),
	 (2025,3,'2024-11-24',316,465,-1),
	 (2025,4,'2024-11-24',113,149,-1),
	 (2025,8,'2024-11-24',12,12,-1),
	 (2025,3,'2024-11-25',335,465,-1),
	 (2025,4,'2024-11-25',114,149,-1),
	 (2025,8,'2024-11-25',12,12,-1),
	 (2025,3,'2024-11-26',365,466,-1),
	 (2025,4,'2024-11-26',114,149,-1) ON CONFLICT (real_world_testing_year, certification_body_id, checked_date) DO NOTHING;
INSERT INTO openchpl.real_world_testing_plan_summary_report (real_world_testing_year,certification_body_id,checked_date,checked_count,requires_check_count,last_modified_user) VALUES
	 (2025,8,'2024-11-26',12,12,-1),
	 (2025,3,'2024-11-27',377,466,-1),
	 (2025,4,'2024-11-27',114,149,-1),
	 (2025,8,'2024-11-27',12,12,-1),
	 (2025,3,'2024-11-28',377,466,-1),
	 (2025,4,'2024-11-28',114,149,-1),
	 (2025,8,'2024-11-28',12,12,-1),
	 (2025,3,'2024-11-29',378,467,-1),
	 (2025,4,'2024-11-29',114,149,-1),
	 (2025,8,'2024-11-29',12,12,-1) ON CONFLICT (real_world_testing_year, certification_body_id, checked_date) DO NOTHING;
INSERT INTO openchpl.real_world_testing_plan_summary_report (real_world_testing_year,certification_body_id,checked_date,checked_count,requires_check_count,last_modified_user) VALUES
	 (2025,3,'2024-11-30',378,467,-1),
	 (2025,4,'2024-11-30',114,149,-1),
	 (2025,8,'2024-11-30',12,12,-1),
	 (2025,3,'2024-12-01',378,468,-1),
	 (2025,4,'2024-12-01',114,149,-1),
	 (2025,8,'2024-12-01',12,12,-1),
	 (2025,3,'2024-12-02',406,468,-1),
	 (2025,4,'2024-12-02',115,149,-1),
	 (2025,8,'2024-12-02',12,12,-1),
	 (2025,3,'2024-12-03',425,468,-1) ON CONFLICT (real_world_testing_year, certification_body_id, checked_date) DO NOTHING;
INSERT INTO openchpl.real_world_testing_plan_summary_report (real_world_testing_year,certification_body_id,checked_date,checked_count,requires_check_count,last_modified_user) VALUES
	 (2025,4,'2024-12-03',116,149,-1),
	 (2025,8,'2024-12-03',13,12,-1),
	 (2025,3,'2024-12-04',431,469,-1),
	 (2025,4,'2024-12-04',117,149,-1),
	 (2025,8,'2024-12-04',13,12,-1),
	 (2025,3,'2024-12-05',442,469,-1),
	 (2025,4,'2024-12-05',122,149,-1),
	 (2025,8,'2024-12-05',13,12,-1),
	 (2025,3,'2024-12-06',447,470,-1),
	 (2025,4,'2024-12-06',124,149,-1) ON CONFLICT (real_world_testing_year, certification_body_id, checked_date) DO NOTHING;
INSERT INTO openchpl.real_world_testing_plan_summary_report (real_world_testing_year,certification_body_id,checked_date,checked_count,requires_check_count,last_modified_user) VALUES
	 (2025,8,'2024-12-06',13,12,-1),
	 (2025,3,'2024-12-07',447,470,-1),
	 (2025,4,'2024-12-07',124,149,-1),
	 (2025,8,'2024-12-07',13,12,-1),
	 (2025,3,'2024-12-08',447,470,-1),
	 (2025,4,'2024-12-08',124,149,-1),
	 (2025,8,'2024-12-08',13,12,-1),
	 (2025,3,'2024-12-09',451,470,-1),
	 (2025,4,'2024-12-09',128,149,-1),
	 (2025,8,'2024-12-09',13,12,-1) ON CONFLICT (real_world_testing_year, certification_body_id, checked_date) DO NOTHING;
INSERT INTO openchpl.real_world_testing_plan_summary_report (real_world_testing_year,certification_body_id,checked_date,checked_count,requires_check_count,last_modified_user) VALUES
	 (2025,3,'2024-12-10',454,473,-1),
	 (2025,4,'2024-12-10',139,149,-1),
	 (2025,8,'2024-12-10',13,12,-1),
	 (2025,3,'2024-12-11',461,475,-1),
	 (2025,4,'2024-12-11',141,149,-1),
	 (2025,8,'2024-12-11',13,12,-1),
	 (2025,3,'2024-12-12',467,476,-1),
	 (2025,4,'2024-12-12',141,149,-1),
	 (2025,8,'2024-12-12',13,12,-1),
	 (2025,3,'2024-12-13',476,476,-1) ON CONFLICT (real_world_testing_year, certification_body_id, checked_date) DO NOTHING;
INSERT INTO openchpl.real_world_testing_plan_summary_report (real_world_testing_year,certification_body_id,checked_date,checked_count,requires_check_count,last_modified_user) VALUES
	 (2025,4,'2024-12-13',145,149,-1),
	 (2025,8,'2024-12-13',13,12,-1),
	 (2025,3,'2024-12-14',477,476,-1),
	 (2025,4,'2024-12-14',145,149,-1),
	 (2025,8,'2024-12-14',13,12,-1),
	 (2025,3,'2024-12-15',479,476,-1),
	 (2025,4,'2024-12-15',145,149,-1),
	 (2025,8,'2024-12-15',13,12,-1) ON CONFLICT (real_world_testing_year, certification_body_id, checked_date) DO NOTHING;

ALTER TABLE openchpl.real_world_testing_plan_summary_report
DROP CONSTRAINT temp_unique_rwt_plan_summary_report;

;
-- ./changes/ocd-4788.sql
-------------
-- DROP 'title' from contact objects
-------------

-- some views depended upon 'title' and some other views depended upon those views, so... just drop all the views for now to make things easier
DROP VIEW IF EXISTS openchpl.questionable_activity_combined;
DROP VIEW IF EXISTS openchpl.inactive_developers_and_products;
DROP VIEW IF EXISTS openchpl.certified_product_search;
DROP VIEW IF EXISTS openchpl.certified_product_details;
DROP VIEW IF EXISTS openchpl.cqm_result_details;
DROP VIEW IF EXISTS openchpl.certification_result_details;
DROP VIEW IF EXISTS openchpl.product_active_owner_history_map;
DROP VIEW IF EXISTS openchpl.certified_product_summary;
DROP VIEW IF EXISTS openchpl.ehr_certification_ids_and_products;
DROP VIEW IF EXISTS openchpl.surveillance_basic;
DROP VIEW IF EXISTS openchpl.developer_search;
DROP VIEW IF EXISTS openchpl.developer_certification_body_map;
DROP VIEW IF EXISTS openchpl.requirement_type;
DROP VIEW IF EXISTS openchpl.nonconformity_type;
DROP VIEW IF EXISTS openchpl.rwt_plans_by_developer;
DROP VIEW IF EXISTS openchpl.rwt_results_by_developer;
DROP VIEW IF EXISTS openchpl.subscription_search_result;
DROP VIEW IF EXISTS openchpl.subscription_observation_notification;
DROP VIEW IF EXISTS openchpl.most_recent_past_attestation_period;
DROP VIEW IF EXISTS openchpl.listing_search;

ALTER TABLE openchpl.contact DROP COLUMN IF EXISTS title;
ALTER TABLE openchpl.change_request_developer_demographics DROP COLUMN IF EXISTS title;


-------------
-- DROP 'friendly_name' from contact objects
-------------
ALTER TABLE openchpl.contact DROP COLUMN IF EXISTS friendly_name;

-------------
-- DROP *_statistics tables that are no longer used
-------------
DROP TABLE IF EXISTS openchpl.listing_count_statistics;
DROP TABLE IF EXISTS openchpl.incumbent_developers_statistics;
DROP TABLE IF EXISTS openchpl.criterion_product_statistics;
DROP TABLE IF EXISTS openchpl.participant_age_statistics;
DROP TABLE IF EXISTS openchpl.participant_education_statistics;
DROP TABLE IF EXISTS openchpl.participant_experience_statistics;
DROP TABLE IF EXISTS openchpl.participant_gender_statistics;
DROP TABLE IF EXISTS openchpl.sed_participants_statistics_count;






;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('26.0.0', '2025-03-03', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
