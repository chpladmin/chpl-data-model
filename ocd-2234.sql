DROP TABLE IF EXISTS openchpl.criterion_product_statistics;

CREATE TABLE openchpl.criterion_product_statistics (
        id bigserial NOT NULL,
        product_count bigint NOT NULL,
        certification_criterion_id bigint NOT NULL REFERENCES openchpl.certification_criterion (certification_criterion_id),
        creation_date timestamp without time zone NOT NULL DEFAULT now(),
        last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
        last_modified_user bigint NOT NULL,
        deleted boolean NOT NULL DEFAULT false,
        CONSTRAINT criterion_product_statistics_pk PRIMARY KEY (id)
        );
CREATE TRIGGER criterion_product_statistics_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.criterion_product_statistics FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER criterion_product_statistics_timestamp BEFORE UPDATE on openchpl.criterion_product_statistics FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

--re-run grants
\i dev/openchpl_grant-all.sql
