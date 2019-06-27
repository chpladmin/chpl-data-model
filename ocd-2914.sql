DROP TABLE IF EXISTS openchpl.complaint_criterion_map;

CREATE TABLE openchpl.complaint_criterion_map (
    complaint_criterion_map_id bigserial not null,
    complaint_id bigint not null,
    certification_criterion_id bigint not null,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
    CONSTRAINT complaint_criterion_map_pk PRIMARY KEY (complaint_criterion_map_id),
    CONSTRAINT complaint_fk FOREIGN KEY (complaint_id)
		REFERENCES openchpl.complaint (complaint_id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
    CONSTRAINT criterion_fk FOREIGN KEY (certification_criterion_id)
		REFERENCES openchpl.certification_criterion (certification_criterion_id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE TRIGGER complaint_criterion_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.complaint_criterion_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER complaint_criterion_map_timestamp BEFORE UPDATE on openchpl.complaint_criterion_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
