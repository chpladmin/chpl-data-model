DROP TABLE IF EXISTS openchpl.certified_product_mips_measure_criteria;
DROP TABLE IF EXISTS openchpl.certified_product_mips_measure;
DROP TABLE IF EXISTS openchpl.allowed_mips_measure_criteria;
DROP TABLE IF EXISTS openchpl.mips_measure;
DROP TABLE IF EXISTS openchpl.mips_type;
DROP TABLE IF EXISTS openchpl.mips_domain;

CREATE TABLE openchpl.mips_domain (
 id                 bigserial NOT NULL,
 domain             text NOT NULL,
 creation_date      timestamp with time zone NOT NULL,
 last_modified_date timestamp with time zone NOT NULL,
 last_modified_user bigint NOT NULL,
 deleted            boolean NOT NULL,
 CONSTRAINT PK_mips_domain PRIMARY KEY ( id )
);

CREATE TRIGGER mips_domain_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.mips_domain FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER mips_domain_timestamp BEFORE UPDATE on openchpl.mips_domain FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

CREATE TABLE openchpl.mips_type (
 id                 bigserial NOT NULL,
 name               text NOT NULL,
 creation_date      timestamp with time zone NOT NULL,
 last_modified_date timestamp with time zone NOT NULL,
 last_modified_user bigint NOT NULL,
 deleted            boolean NOT NULL,
 CONSTRAINT PK_mips_type PRIMARY KEY ( id )
);

CREATE TRIGGER mips_type_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.mips_type FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER mips_type_timestamp BEFORE UPDATE on openchpl.mips_type FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

CREATE TABLE openchpl.mips_measure (
 id                          bigserial NOT NULL,
 mips_domain_id              bigint NOT NULL,
 required_test_abbr          text NOT NULL,
 required_test               text NOT NULL,
 measure_name                text NOT NULL,
 criteria_selection_required boolean NOT NULL,
 removed                     boolean NOT NULL,
 creation_date               timestamp with time zone NOT NULL,
 last_modified_date          timestamp with time zone NOT NULL,
 last_modified_user          bigint NOT NULL,
 deleted                     boolean NOT NULL,
 CONSTRAINT PK_mips_name_value_map PRIMARY KEY ( id ),
 CONSTRAINT mips_domain_fk FOREIGN KEY (mips_domain_id)
      REFERENCES openchpl.mips_domain (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TRIGGER mips_measure_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.mips_measure FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER mips_measure_timestamp BEFORE UPDATE on openchpl.mips_measure FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

CREATE TABLE openchpl.allowed_mips_measure_criteria (
 id                         bigserial NOT NULL,
 certification_criterion_id bigint NOT NULL,
 mips_measure_id            bigint NOT NULL,
 creation_date              timestamp with time zone NOT NULL,
 last_modified_date         timestamp with time zone NOT NULL,
 last_modified_user         bigint NOT NULL,
 deleted                    boolean NOT NULL,
 CONSTRAINT PK_mips_name_criteria_map PRIMARY KEY ( id ),
 CONSTRAINT certification_criterion_fk FOREIGN KEY (certification_criterion_id)
      REFERENCES openchpl.certification_criterion (certification_criterion_id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
 CONSTRAINT mips_measure_fk FOREIGN KEY (mips_measure_id)
      REFERENCES openchpl.mips_measure (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
 );

CREATE TRIGGER allowed_mips_measure_criteria_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.allowed_mips_measure_criteria FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER allowed_mips_measure_criteria_timestamp BEFORE UPDATE on openchpl.allowed_mips_measure_criteria FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

CREATE TABLE openchpl.certified_product_mips_measure (
 id                   bigserial NOT NULL,
 certified_product_id bigint NOT NULL,
 mips_measure_id      bigint NOT NULL,
 mips_type_id         bigint NOT NULL,
 creation_date        timestamp with time zone NOT NULL,
 last_modified_date   timestamp with time zone NOT NULL,
 last_modified_user   bigint NOT NULL,
 deleted              boolean NOT NULL,
 CONSTRAINT PK_certified_product_mips_measures PRIMARY KEY ( id ),
 CONSTRAINT certified_product_fk FOREIGN KEY (certified_product_id)
      REFERENCES openchpl.certified_product (certified_product_id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
 CONSTRAINT mips_measure_fk FOREIGN KEY (mips_measure_id)
      REFERENCES openchpl.mips_measure (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
 CONSTRAINT mips_type_fk FOREIGN KEY (mips_type_id)
      REFERENCES openchpl.mips_type (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TRIGGER certified_product_mips_measure_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certified_product_mips_measure FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certified_product_mips_measure_timestamp BEFORE UPDATE on openchpl.certified_product_mips_measure FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

CREATE TABLE openchpl.certified_product_mips_measure_criteria (
 id                                bigserial NOT NULL,
 certification_criterion_id        bigint NOT NULL,
 certified_product_mips_measure_id bigint NOT NULL,
 creation_date                     timestamp with time zone NOT NULL,
 last_modified_date                timestamp with time zone NOT NULL,
 last_modified_user                bigint NOT NULL,
 deleted                           boolean NOT NULL,
 CONSTRAINT PK_certified_products_mips_measure_criteria PRIMARY KEY ( id ),
 CONSTRAINT certification_criterion_fk FOREIGN KEY (certification_criterion_id)
      REFERENCES openchpl.certification_criterion (certification_criterion_id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
 CONSTRAINT certified_product_mips_measure_fk FOREIGN KEY (certified_product_mips_measure_id)
      REFERENCES openchpl.certified_product_mips_measure (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TRIGGER certified_product_mips_measure_criteria_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certified_product_mips_measure_criteria FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certified_product_mips_measure_criteria_timestamp BEFORE UPDATE on openchpl.certified_product_mips_measure_criteria FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
