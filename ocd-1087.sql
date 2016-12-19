--
-- Certification Status Event table and trigger setup
--
DROP TABLE IF EXISTS openchpl.certification_status_event;
CREATE TABLE openchpl.certification_status_event (
	certification_status_event_id  bigserial NOT NULL,
	certified_product_id bigint NOT NULL,
	to_status_id bigint NOT NULL,
	from_status_id bigint, -- could be null if it's a product that was migrated from the old CHPL or was just uploaded
	event_date timestamp NOT NULL DEFAULT NOW(),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT certification_status_event_pk PRIMARY KEY (certification_status_event_id),
	CONSTRAINT to_status_fk FOREIGN KEY (to_status_id) REFERENCES openchpl.certification_status (certification_status_id) 
		MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT from_status_fk FOREIGN KEY (from_status_id) REFERENCES openchpl.certification_status (certification_status_id) 
		MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE	
);

GRANT ALL ON TABLE openchpl.certification_status_event TO openchpl;

CREATE TRIGGER certification_status_event_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certification_status_event FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certification_status_event_timestamp BEFORE UPDATE on openchpl.certification_status_event FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

--
-- Certification Event Migration
--

--TODO this would only move the 'Active' Certification Events which is the same as the certification date.. is that ok? 
-- The date that a product is confirmed (from pending) is not getting migrated... should it? Should we leave that around in the other table? do we care?

--insert all the original certification status events to get certified date
INSERT INTO openchpl.certification_status_event 
	(certification_status_event_id, certified_product_id, to_status_id, from_status_id, event_date,
	creation_date, last_modified_date, last_modified_user, deleted)
	SELECT certification_event_id, certified_product_id, 1, NULL, event_date,
		creation_date, last_modified_date, last_modified_user, deleted
	FROM openchpl.certification_event
	WHERE event_type_id = 1;

	-- update sequence
SELECT pg_catalog.setval(pg_get_serial_sequence('openchpl.certification_status_event', 'certification_status_event_id'), 
(SELECT MAX(certification_status_event_id) FROM openchpl.certification_status_event)+1);

-- now look for certified products that aren't Active or Pending and insert a certification status event 
-- to track for current certification status. Use cp last modified date for lack of anything more accurate
INSERT INTO openchpl.certification_status_event 
	(certified_product_id, to_status_id, from_status_id, event_date,
	creation_date, last_modified_date, last_modified_user, deleted)
	SELECT certified_product_id, certification_status_id, 1, last_modified_date,
		creation_date, last_modified_date, last_modified_user, deleted
	FROM openchpl.certified_product
	WHERE certification_status_id != 1;
