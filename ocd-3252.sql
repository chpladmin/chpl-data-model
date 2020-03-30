DROP TABLE IF EXISTS openchpl.cures_update_event CASCADE;
CREATE TABLE openchpl.cures_update_event (
        id bigserial NOT NULL,
       	cures_update boolean NOT NULL DEFAULT false,
	certified_product_id bigint NOT NULL,
	event_date timestamp NOT NULL DEFAULT NOW(),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT cures_update_event_pk PRIMARY KEY (id),
	CONSTRAINT certified_product_fk FOREIGN KEY (certified_product_id) REFERENCES openchpl.certified_product (certified_product_id)
		MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);
