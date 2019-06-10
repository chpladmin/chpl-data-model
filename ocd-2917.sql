DROP TABLE IF EXISTS openchpl.quarterly_report;

CREATE TABLE openchpl.quarterly_report (
	id bigserial NOT NULL,
	certification_body_id bigint NOT NULL,
	year integer NOT NULL,
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
	CONSTRAINT certification_body_fk FOREIGN KEY (certification_body_id)
      REFERENCES openchpl.certification_body (certification_body_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE RESTRICT,
	CONSTRAINT quarter_fk FOREIGN KEY (quarter_id)
      REFERENCES openchpl.quarter (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE RESTRICT
);
CREATE TRIGGER quarterly_report_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.quarterly_report FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER quarterly_report_timestamp BEFORE UPDATE on openchpl.quarterly_report FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();