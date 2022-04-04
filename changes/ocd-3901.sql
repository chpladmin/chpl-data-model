DROP TABLE IF EXISTS openchpl.certified_product_chpl_product_number_history CASCADE;

CREATE TABLE openchpl.certified_product_chpl_product_number_history (
	id bigserial NOT NULL,
	certified_product_id bigint NOT NULL,
	chpl_product_number text NOT NULL,
	end_date timestamp NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT certified_product_chpl_product_number_history_pk PRIMARY KEY (id),
	CONSTRAINT certified_product_fk FOREIGN KEY (certified_product_id)
      REFERENCES openchpl.certified_product (certified_product_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TRIGGER certified_product_chpl_product_number_history_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certified_product_chpl_product_number_history FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certified_product_chpl_product_number_history_timestamp BEFORE UPDATE on openchpl.certified_product_chpl_product_number_history FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();