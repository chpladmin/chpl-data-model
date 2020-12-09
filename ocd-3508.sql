DROP TABLE IF EXISTS openchpl.certification_result_svap;
DROP TABLE IF EXISTS openchpl.svap_criteria_map;
DROP TABLE IF EXISTS openchpl.svap;

CREATE TABLE openchpl.svap (
    id bigserial NOT NULL,
    regulatory_text_citation varchar(30) NOT NULL,
    approved_standard_version text NOT NULL,
    replaced bool NOT NULL DEFAULT false,
    creation_date timestamp NOT NULL DEFAULT NOW(),
    last_modified_date timestamp NOT NULL DEFAULT NOW(),
    last_modified_user bigint NOT NULL,
    deleted bool NOT NULL DEFAULT false,
    CONSTRAINT svap_pk PRIMARY KEY (id)
);

CREATE TRIGGER svap_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.svap FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER svap_timestamp BEFORE UPDATE on openchpl.svap FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

CREATE TABLE openchpl.svap_criteria_map (
    id bigserial NOT NULL,
    svap_id bigint NOT NULL,
    criteria_id bigint NOT NULL,
    creation_date timestamp NOT NULL DEFAULT NOW(),
    last_modified_date timestamp NOT NULL DEFAULT NOW(),
    last_modified_user bigint NOT NULL,
    deleted bool NOT NULL DEFAULT false,
    CONSTRAINT svap_criteria_map_pk PRIMARY KEY (id),
    CONSTRAINT svap_fk FOREIGN KEY (svap_id)
        REFERENCES openchpl.svap (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
    CONSTRAINT svap_criteria_map_fk FOREIGN KEY (criteria_id)
        REFERENCES openchpl.certification_criterion (certification_criterion_id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE TRIGGER svap_criteria_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.svap_criteria_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER svap_criteria_map_timestamp BEFORE UPDATE on openchpl.svap_criteria_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

CREATE TABLE openchpl.certification_result_svap (
    id bigserial NOT NULL,
    certification_result_id bigint NOT NULL,
    svap_id bigint NOT NULL,
    creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
    CONSTRAINT certification_result_svap_pk PRIMARY KEY (id),
    CONSTRAINT certification_result_fk FOREIGN KEY (certification_result_id)
	    REFERENCES openchpl.certification_result (certification_result_id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
    CONSTRAINT svap_fk FOREIGN KEY (svap_id)
	    REFERENCES openchpl.svap (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE TRIGGER certification_result_svap_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certification_result_svap FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certification_result_svap_timestamp BEFORE UPDATE on openchpl.certification_result_svap FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
