CREATE TYPE openchpl.fuzzy_type as enum('UCD Processes', 'QMS Standards', 'Accessibility Standards');

CREATE TABLE openchpl.pending_certified_product_system_update(
	pending_certified_product_system_update_id bigserial NOT NULL,
	pending_certified_product_id bigint NOT NULL,
	change_made text,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT pending_certified_product_system_update_pk PRIMARY KEY (pending_certified_product_system_update_id),
	CONSTRAINT pending_certified_product_fk FOREIGN KEY (pending_certified_product_id)
      REFERENCES openchpl.pending_certified_product (pending_certified_product_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE openchpl.fuzzy_choices(
	fuzzy_choices_id bigserial not null,
	fuzzy_type openchpl.fuzzy_type not null,
	choices json not null,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT fuzzy_choices_pk PRIMARY KEY (fuzzy_choices_id)
);

INSERT INTO openchpl.fuzzy_choices(fuzzy_type, choices, last_modified_user)
VALUES('UCD Processes', '["Multiple Standards","ISO 9241-210:2010 4.2","ISO/IEC 25062:2006","Homegrown","NISTIR 7742","(NISTIR 7741) NIST Guide to the Processes Approach for Improving the Usability of Electronic Health Records","IEC 62366","Internal Process Used","IEC 62366-1","ISO 13407","ISO 16982","ISO/IEC 62367"]', -1);

INSERT INTO openchpl.fuzzy_choices(fuzzy_type, choices, last_modified_user)
VALUES('QMS Standards', '["ISO 13485:2003","ISO 13485:2012","21 CFR Part 820","ISO 9001","ISO 13485","IEC 62304","IEEE 730","Homegrown","Food and Drug Administrations Code of Federal Regulations Title 21 Part 820 Quality System Regulation","ISMS/ISO/IEC 27001","ISO 9001:2008","Self-Develop","None","Other Federal or SDO QMS Standard"]', -1);

INSERT INTO openchpl.fuzzy_choices(fuzzy_type, choices, last_modified_user)
VALUES('Accessibility Standards', '["WCAG 2.0 Level AA","W3C Web Design and Applications","W3C Web of Devices","Section 508 of the Rehabilitation Act","ISO/IEC 40500:2012","None","170.204(a)(1)","170.204(a)(2)","NIST 7741"]', -1);

ALTER TABLE IF EXISTS openchpl.pending_certified_product_qms_standard 
ADD COLUMN fuzzy_match_qms_standard_name varchar(255);

ALTER TABLE IF EXISTS openchpl.pending_certified_product_accessibility_standard
ADD COLUMN fuzzy_match_accessibility_standard_name varchar(500);

ALTER TABLE IF EXISTS openchpl.pending_certification_result_ucd_process 
ADD COLUMN fuzzy_match_ucd_process_name varchar(200);

CREATE TRIGGER pending_certified_product_system_update_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_certified_product_system_update FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_certified_product_system_update_timestamp BEFORE UPDATE on openchpl.pending_certified_product_system_update FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER fuzzy_choices_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.fuzzy_choices FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER fuzzy_choices_timestamp BEFORE UPDATE on openchpl.fuzzy_choices FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
