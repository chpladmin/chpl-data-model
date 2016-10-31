DROP VIEW IF EXISTS openchpl.product_active_owner_history_map;
DROP TABLE IF EXISTS openchpl.product_owner_history_map;

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
GRANT ALL ON TABLE openchpl.product_owner_history_map TO openchpl;
GRANT ALL ON SEQUENCE openchpl.product_owner_history_map_id_seq TO openchpl;

CREATE TRIGGER product_owner_history_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.product_owner_history_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER product_owner_history_map_timestamp BEFORE UPDATE on openchpl.product_owner_history_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();


--I would greatly prefer to select from product left outer join product_owner_history_map on id=id and deleted = false 
--but Hibernate does not support an additional clause (beyond id=id) in the "on" part of a join.
--This view is intended to get around that restriction.
CREATE OR REPLACE VIEW openchpl.product_active_owner_history_map AS
SELECT  id,
	product_id,
	vendor_id,
	transfer_date,
	creation_date,
	last_modified_date,
	last_modified_user,
	deleted
FROM openchpl.product_owner_history_map
WHERE deleted = false;

GRANT ALL ON TABLE openchpl.product_active_owner_history_map TO openchpl;
