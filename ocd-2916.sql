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
	CONSTRAINT quarter_pk PRIMARY KEY (id)
);
CREATE TRIGGER quarter_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.quarter FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER quarter_timestamp BEFORE UPDATE on openchpl.quarter FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
INSERT INTO openchpl.quarter (name, quarter_begin_month, quarter_begin_day, quarter_end_month, quarter_end_day, last_modified_user)
VALUES ('Q1', 1, 1, 3, 31, -1), ('Q2', 4, 1, 6, 30, -1), ('Q3', 7, 1, 9, 30, -1), ('Q4', 10, 1, 12, 31, -1);

CREATE TABLE openchpl.quarterly_report (
	id bigserial NOT NULL,
	annual_report_id bigint NOT NULL,
	quarter_id bigint NOT NULL,
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
CREATE TRIGGER quarterly_report_timestamp BEFORE UPDATE on openchpl.quarterly_report FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();