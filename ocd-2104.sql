--
-- OCD-2104: new vs. incumbent statistics
--
DROP TABLE IF EXISTS openchpl.new_vs_incumbent_statistics;
CREATE TABLE openchpl.new_vs_incumbent_statistics (
        id bigserial NOT NULL,
        new_2011_to_2014 bigint NOT NULL,
        new_2011_to_2015 bigint NOT NULL,
        new_2014_to_2015 bigint NOT NULL,
        incumbent_2011_to_2014 bigint NOT NULL,
        incumbent_2011_to_2015 bigint NOT NULL,
        incumbent_2014_to_2015 bigint NOT NULL,
        creation_date timestamp without time zone NOT NULL DEFAULT now(),
        last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
        last_modified_user bigint NOT NULL,
        deleted boolean NOT NULL DEFAULT false,
        CONSTRAINT new_vs_incumbent_statistics_pk PRIMARY KEY (id)
        );
CREATE TRIGGER new_vs_incumbent_statistics_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.new_vs_incumbent_statistics FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER new_vs_incumbent_statistics_timestamp BEFORE UPDATE on openchpl.new_vs_incumbent_statistics FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
--re-run grants
\i dev/openchpl_grant-all.sql
