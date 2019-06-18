-- Deployment file for version 17.6.0
--     as of 2019-06-17
-- ocd-2912.sql
DROP TABLE IF EXISTS openchpl.complaint;
DROP TABLE IF EXISTS openchpl.complaint_type;
DROP TABLE IF EXISTS openchpl.complaint_status_type;

CREATE TABLE openchpl.complaint_type (
	complaint_type_id bigserial not null,
	name text not null,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT complaint_type_pk PRIMARY KEY (complaint_type_id)
);

CREATE TRIGGER complaint_type_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.complaint_type FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER complaint_type_timestamp BEFORE UPDATE on openchpl.complaint_type FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

CREATE TABLE openchpl.complaint_status_type (
	complaint_status_type_id bigserial not null,
	name text not null,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT complaint_status_type_pk PRIMARY KEY (complaint_status_type_id)
);

CREATE TRIGGER complaint_status_type_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.complaint_status_type FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER complaint_status_type_timestamp BEFORE UPDATE on openchpl.complaint_status_type FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

CREATE TABLE openchpl.complaint (
	complaint_id bigserial not null,
    certification_body_id bigint not null,
    complaint_type_id bigint not null,
    complaint_status_type_id bigint not null,
    onc_complaint_id text,
    acb_complaint_id text,
    received_date date not null,
    summary text not null,
    actions text,
    complainant_contacted boolean not null DEFAULT false,
    developer_contacted boolean not null DEFAULT false,
    onc_atl_contacted boolean not null DEFAULT false,
    flag_for_onc_review boolean not null DEFAULT false,
    closed_date date,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT complaint_pk PRIMARY KEY (complaint_id),
    CONSTRAINT certification_body_fk FOREIGN KEY (certification_body_id)
		REFERENCES openchpl.certification_body (certification_body_id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
    CONSTRAINT complaint_type_fk FOREIGN KEY (complaint_type_id)
		REFERENCES openchpl.complaint_type (complaint_type_id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
    CONSTRAINT complaint_status_type_fk FOREIGN KEY (complaint_status_type_id)
		REFERENCES openchpl.complaint_status_type (complaint_status_type_id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE TRIGGER complaint_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.complaint FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER complaint_timestamp BEFORE UPDATE on openchpl.complaint FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

INSERT INTO openchpl.complaint_type (name, last_modified_user)
SELECT 'Developer', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.complaint_type
	 WHERE name = 'Developer');
     
INSERT INTO openchpl.complaint_type (name, last_modified_user)
SELECT 'Provider', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.complaint_type
	 WHERE name = 'Provider');
     
INSERT INTO openchpl.complaint_status_type (name, last_modified_user)
SELECT 'Open', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.complaint_status_type
	 WHERE name = 'Open');
     
INSERT INTO openchpl.complaint_status_type (name, last_modified_user)
SELECT 'Closed', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.complaint_status_type
	 WHERE name = 'Closed');
;
-- ocd-2916.sql
DROP TABLE IF EXISTS openchpl.quarterly_report;
DROP TABLE IF EXISTS openchpl.quarter;
DROP TABLE IF EXISTS openchpl.annual_report;

CREATE TABLE openchpl.annual_report (
	id bigserial NOT NULL,
	certification_body_id bigint NOT NULL,
	year integer NOT NULL,
	obstacle_summary text,
	findings_summary text,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT annual_report_pk PRIMARY KEY (id),
	CONSTRAINT certification_body_fk FOREIGN KEY (certification_body_id)
      REFERENCES openchpl.certification_body (certification_body_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE RESTRICT
);
CREATE TRIGGER annual_report_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.annual_report FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER annual_report_timestamp BEFORE UPDATE on openchpl.annual_report FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

--lookup table for quarter
CREATE TABLE openchpl.quarter (
	id bigserial NOT NULL,
	name varchar(2) NOT NULL,
	quarter_begin_month integer NOT NULL,
	quarter_begin_day integer NOT NULL,
	quarter_end_month integer NOT NULL,
	quarter_end_day integer NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT quarter_pk PRIMARY KEY (id),
	CONSTRAINT quarter_name_unique UNIQUE (name)
);
CREATE TRIGGER quarter_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.quarter FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER quarter_timestamp BEFORE UPDATE on openchpl.quarter FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
INSERT INTO openchpl.quarter (name, quarter_begin_month, quarter_begin_day, quarter_end_month, quarter_end_day, last_modified_user)
VALUES ('Q1', 1, 1, 3, 31, -1), ('Q2', 4, 1, 6, 30, -1), ('Q3', 7, 1, 9, 30, -1), ('Q4', 10, 1, 12, 31, -1);

CREATE TABLE openchpl.quarterly_report (
	id bigserial NOT NULL,
	annual_report_id bigint NOT NULL,
	quarter_id bigint NOT NULL,
	activities_and_outcomes_summary text,
	reactive_summary text,
	prioritized_element_summary text,
	transparency_disclosure_summary text,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT quarterly_report_pk PRIMARY KEY (id),
	CONSTRAINT annual_report_fk FOREIGN KEY (annual_report_id)
      REFERENCES openchpl.annual_report (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE RESTRICT,
	CONSTRAINT quarter_fk FOREIGN KEY (quarter_id)
      REFERENCES openchpl.quarter (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE RESTRICT
);
CREATE TRIGGER quarterly_report_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.quarterly_report FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER quarterly_report_timestamp BEFORE UPDATE on openchpl.quarterly_report FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();;
-- ocd-2789.sql
INSERT INTO openchpl.filter_type (name, last_modified_user)
SELECT 'User Report', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.filter_type
	 WHERE name = 'User Report');

INSERT INTO openchpl.filter_type (name, last_modified_user)
SELECT 'User Action Report', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.filter_type
	 WHERE name = 'User Action Report');
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('17.6.0', '2019-06-17', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
