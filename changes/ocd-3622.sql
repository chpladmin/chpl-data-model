drop table if exists openchpl.pending_certification_result_optional_standard;

CREATE TABLE openchpl.pending_certification_result_optional_standard (
	pending_certification_result_optional_standard_id bigserial NOT NULL,
	pending_certification_result_id bigint not null,
	optional_standard_id bigint,
	citation text,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL,
	CONSTRAINT pending_certification_result_optional_standard_pk PRIMARY KEY (pending_certification_result_optional_standard_id),
	CONSTRAINT pending_certification_result_fk FOREIGN KEY (pending_certification_result_id)
      REFERENCES openchpl.pending_certification_result (pending_certification_result_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT optional_standard_fk FOREIGN KEY (optional_standard_id)
      REFERENCES openchpl.optional_standard (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);
CREATE TRIGGER pending_certification_result_optional_standard_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_certification_result_optional_standard FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_certification_result_optional_standard_timestamp BEFORE UPDATE on openchpl.pending_certification_result_optional_standard FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
