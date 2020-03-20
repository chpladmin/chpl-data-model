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

\i dev/openchpl_views.sql

insert into openchpl.cures_update_event (cures_update, certified_product_id, event_date, last_modified_user)
select false, cp.certified_product_id, cp.certification_date, -1 from openchpl.certified_product_search cp
where cp.year = '2015';
