DROP TABLE openchpl.product_owner_history_map;

CREATE TABLE IF NOT EXISTS openchpl.product_owner_history_map (
	id bigserial NOT NULL,
	product_id bigint NOT NULL,
	vendor_id bigint NOT NULL,
	transfer_date timestamp NOT NULL DEFAULT NOW(),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT product_owner_history_map_pk PRIMARY KEY (id),
	CONSTRAINT product_fk FOREIGN KEY (product_id) 
		REFERENCES openchpl.product (product_id) 
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT vendor_fk FOREIGN KEY (vendor_id) 
		REFERENCES openchpl.vendor (vendor_id) 
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE			
);

CREATE TRIGGER product_owner_history_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.product_owner_history_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER product_owner_history_map_timestamp BEFORE UPDATE on openchpl.product_owner_history_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();