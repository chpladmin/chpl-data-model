--
-- Certification Status Event table and trigger setup
--
DROP VIEW IF EXISTS openchpl.certified_product_details;
DROP TABLE IF EXISTS openchpl.certification_status_event;
CREATE TABLE openchpl.certification_status_event (
	certification_status_event_id  bigserial NOT NULL,
	certified_product_id bigint NOT NULL,
	certification_status_id bigint NOT NULL,
	event_date timestamp NOT NULL DEFAULT NOW(),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT certification_status_event_pk PRIMARY KEY (certification_status_event_id),
	CONSTRAINT certification_status_fk FOREIGN KEY (certification_status_id) REFERENCES openchpl.certification_status (certification_status_id) 
		MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);
GRANT ALL ON TABLE openchpl.certification_status_event TO openchpl;
GRANT ALL ON SEQUENCE openchpl.certification_status_event_certification_status_event_id_seq TO openchpl;

-- TODO: update the cp details view

CREATE TRIGGER certification_status_event_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certification_status_event FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certification_status_event_timestamp BEFORE UPDATE on openchpl.certification_status_event FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

--
-- Certification Event Migration
--

--insert all the original certification status events to get certified date
INSERT INTO openchpl.certification_status_event 
	(certified_product_id, certification_status_id, event_date,
	creation_date, last_modified_date, last_modified_user, deleted)
	SELECT certified_product_id, 1, event_date,
		creation_date, last_modified_date, last_modified_user, deleted
	FROM openchpl.certification_event
	WHERE event_type_id = 1;


-- now look for certified products that aren't Active and insert a certification status event 
-- to track the current certification status. Use cp last modified date for lack of anything more accurate
INSERT INTO openchpl.certification_status_event 
	(certified_product_id, certification_status_id, event_date,
	creation_date, last_modified_date, last_modified_user, deleted)
	SELECT certified_product_id, certification_status_id, last_modified_date,
		creation_date, last_modified_date, last_modified_user, deleted
	FROM openchpl.certified_product
	WHERE certification_status_id != 1;

-- Updating the view is done in a different file since the view has multiple other changes

-- Removing certification_status_id from certified_product will have to be done next time
-- because it has to happen after the view is updated (different file) AND after this file has run and we don't 
-- know the order they will run in

-- Removing certification_event and event_type tables can be done in a future task

