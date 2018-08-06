-- OCD-2273 - Migrate ICS Error report
DROP TABLE IF EXISTS openchpl.inheritance_errors_report;
CREATE TABLE openchpl.inheritance_errors_report
(
    id bigserial NOT NULL,
    chpl_product_number varchar(250) NOT NULL,
    developer varchar(300) NOT NULL,
    product varchar(300) NOT NULL,
    version varchar(250) NOT NULL,
    acb varchar(250) NOT NULL,
    url varchar(250) NOT NULL,
    reason text NOT NULL,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
    CONSTRAINT id_pk PRIMARY KEY (id)
);
CREATE TRIGGER inheritance_errors_report_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.inheritance_errors_report FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER inheritance_errors_report_timestamp BEFORE UPDATE on openchpl.inheritance_errors_report FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

--re-run grants
\i dev/openchpl_grant-all.sql
