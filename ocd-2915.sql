DROP TABLE IF EXISTS openchpl.complaint_surveillance_map;

CREATE TABLE openchpl.complaint_surveillance_map (
    complaint_surveillance_map_id bigserial not null,
    complaint_id bigint not null,
    surveillance_id bigint not null,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
    CONSTRAINT complaint_surveillance_map_pk PRIMARY KEY (complaint_surveillance_map_id),
    CONSTRAINT complaint_fk FOREIGN KEY (complaint_id)
		REFERENCES openchpl.complaint (complaint_id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
    CONSTRAINT surveillance_fk FOREIGN KEY (surveillance_id)
		REFERENCES openchpl.surveillance (surveillance_id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE TRIGGER complaint_surveillance_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.complaint_surveillance_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER complaint_surveillance_map_timestamp BEFORE UPDATE on openchpl.complaint_surveillance_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
