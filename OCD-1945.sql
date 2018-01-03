CREATE TYPE openchpl.fuzzy_type as enum('UCD Processes', 'QMS Standards', 'Accessibility Standards');

CREATE TABLE openchpl.pending_certified_product_system_update(
	pending_certified_product_system_update_id bigserial not null,
	change_made text,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT pending_certified_product_fk FOREIGN KEY (pending_certified_product_id)
      REFERENCES openchpl.pending_certified_product (pending_certified_product_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE openchpl.fuzzy_choices(
	fuzzy_choices_id bigserial not null,
	fuzzy_type fuzzy_type not null,
	choices json not null,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false
);

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
