CREATE TABLE IF NOT EXISTS openchpl.criterion_not_up_to_date_reason (
	id bigserial NOT NULL,
	name text NOT NULL,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NULL,
    deleted boolean NOT NULL DEFAULT false,
    last_modified_sso_user uuid NULL,
	CONSTRAINT criterion_not_up_to_date_reason_pk PRIMARY KEY (id)
);

CREATE OR replace TRIGGER criterion_not_up_to_date_reason_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.criterion_not_up_to_date_reason FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE OR replace TRIGGER criterion_not_up_to_date_reason_timestamp BEFORE UPDATE on openchpl.criterion_not_up_to_date_reason FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS criterion_not_up_to_date_reason_last_modified_user_constraint ON openchpl.criterion_not_up_to_date_reason;
CREATE CONSTRAINT TRIGGER criterion_not_up_to_date_reason_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.criterion_not_up_to_date_reason DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();

INSERT INTO openchpl.criterion_not_up_to_date_reason (name, last_modified_sso_user)
SELECT 'Standard Attested', '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (SELECT * FROM openchpl.criterion_not_up_to_date_reason WHERE name = 'Standard Attested');

INSERT INTO openchpl.criterion_not_up_to_date_reason (name, last_modified_sso_user)
SELECT 'Required Standard Not Attested', '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (SELECT * FROM openchpl.criterion_not_up_to_date_reason WHERE name = 'Required Standard Not Attested');

INSERT INTO openchpl.criterion_not_up_to_date_reason (name, last_modified_sso_user)
SELECT 'Functionality Tested Attested', '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (SELECT * FROM openchpl.criterion_not_up_to_date_reason WHERE name = 'Functionality Tested Attested');

INSERT INTO openchpl.criterion_not_up_to_date_reason (name, last_modified_sso_user)
SELECT 'Required Functionality Tested Not Attested', '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (SELECT * FROM openchpl.criterion_not_up_to_date_reason WHERE name = 'Required Functionality Tested Not Attested');

INSERT INTO openchpl.criterion_not_up_to_date_reason (name, last_modified_sso_user)
SELECT 'Code Set Attested', '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (SELECT * FROM openchpl.criterion_not_up_to_date_reason WHERE name = 'Code Set Attested');

INSERT INTO openchpl.criterion_not_up_to_date_reason (name, last_modified_sso_user)
SELECT 'Required Code Set Not Attested', '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (SELECT * FROM openchpl.criterion_not_up_to_date_reason WHERE name = 'Required Code Set Not Attested');

-- we think the existing data is invalid so we can actually just get rid of it all... 
DROP TABLE IF EXISTS openchpl.updated_listing_status_report;
DROP TABLE IF EXISTS openchpl.updated_criteria_status_report;

-- create new table to hold the daily data collected about criteria needing updates
CREATE TABLE IF NOT EXISTS openchpl.updated_criterion_status_report (
	id bigserial NOT NULL,
	report_day date NOT NULL,
	certified_product_id bigint NOT NULL,
	certification_result_id bigint NOT NULL,
	chpl_product_number text NOT NULL,
	developer_name text NOT NULL,
	developer_id bigint NOT NULL,
	product_name text NOT NULL,
	version_name text NOT NULL,
	certification_body_name text NOT NULL,
	certification_body_id bigint NOT NULL,
	certification_status_name text NOT NULL,
	certification_status_id bigint NOT NULL,
	criterion_not_up_to_date_reason_id bigint NOT NULL,
	standard_id bigint,
	functionality_tested_id bigint,
	code_set_id bigint,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NULL,
    deleted boolean NOT NULL DEFAULT false,
    last_modified_sso_user uuid NULL,
	CONSTRAINT updated_criterion_status_report_pk PRIMARY KEY (id),
	CONSTRAINT certified_product_fk FOREIGN KEY (certified_product_id)
      REFERENCES openchpl.certified_product (certified_product_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT certification_result_fk FOREIGN KEY (certification_result_id)
      REFERENCES openchpl.certification_result (certification_result_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT developer_fk FOREIGN KEY (developer_id)
      REFERENCES openchpl.vendor (vendor_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT certification_body_fk FOREIGN KEY (certification_body_id)
      REFERENCES openchpl.certification_body (certification_body_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT certification_status_fk FOREIGN KEY (certification_status_id)
      REFERENCES openchpl.certification_status (certification_status_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT criterion_not_up_to_date_reason_fk FOREIGN KEY (criterion_not_up_to_date_reason_id)
      REFERENCES openchpl.criterion_not_up_to_date_reason (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT standard_fk FOREIGN KEY (standard_id)
      REFERENCES openchpl.standard (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT functionality_tested_fk FOREIGN KEY (functionality_tested_id)
      REFERENCES openchpl.functionality_tested (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT code_set_fk FOREIGN KEY (code_set_id)
      REFERENCES openchpl.code_set (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE OR replace TRIGGER updated_criterion_status_report_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.updated_criterion_status_report FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE OR replace TRIGGER updated_criterion_status_report_timestamp BEFORE UPDATE on openchpl.updated_criterion_status_report FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS updated_criterion_status_report_last_modified_user_constraint ON openchpl.updated_criterion_status_report;
CREATE CONSTRAINT TRIGGER updated_criterion_status_report_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.updated_criterion_status_report DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();
