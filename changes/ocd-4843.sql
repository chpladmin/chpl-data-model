CREATE TABLE IF NOT EXISTS
  openchpl.criterion_product_statistics (
    id bigserial NOT NULL,
    product_count bigint NOT NULL,
    certification_criterion_id bigint NULL,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NULL,
    deleted boolean NOT NULL DEFAULT false,
    last_modified_sso_user uuid NULL,
	CONSTRAINT criterion_product_statistics_pk PRIMARY KEY (id),
    CONSTRAINT certification_criterion_fk FOREIGN KEY (certification_criterion_id)
		REFERENCES openchpl.certification_criterion (certification_criterion_id)
		MATCH simple ON UPDATE NO ACTION ON DELETE RESTRICT
  );

CREATE OR replace TRIGGER criterion_product_statistics_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.criterion_product_statistics FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE OR replace TRIGGER criterion_product_statistics_timestamp BEFORE UPDATE on openchpl.criterion_product_statistics FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS criterion_product_statistics_last_modified_user_constraint ON openchpl.criterion_product_statistics;
CREATE CONSTRAINT TRIGGER criterion_product_statistics_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.criterion_product_statistics DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();


