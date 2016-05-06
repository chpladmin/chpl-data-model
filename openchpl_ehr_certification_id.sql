-- Table: openchpl.ehr_certification_id

-- DROP TABLE openchpl.ehr_certification_id;

CREATE TABLE openchpl.ehr_certification_id
(
  ehr_certification_id_id bigserial,
  key text NOT NULL, -- The unique product collection key
  year text NOT NULL, -- The attestation year
  certification_id text NOT NULL, -- The unqiue CMS EHR Certification ID
  practice_type_id bigint, -- The practice type if applicable (e.g. 2011)
  creation_date timestamp without time zone NOT NULL DEFAULT now(),
  last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
  last_modified_user bigint,
  CONSTRAINT ehr_certification_id_pk PRIMARY KEY (ehr_certification_id_id),
  CONSTRAINT practice_type_id_fk FOREIGN KEY (practice_type_id)
      REFERENCES openchpl.practice_type (practice_type_id) MATCH FULL
      ON UPDATE NO ACTION ON DELETE RESTRICT,
  CONSTRAINT unique_certification_id UNIQUE (certification_id),
  CONSTRAINT unique_year_key UNIQUE (year, key)
)
WITH (
  OIDS=FALSE
);
--ALTER TABLE openchpl.ehr_certification_id OWNER TO openchpl;
GRANT ALL ON TABLE openchpl.ehr_certification_id TO openchpl;
COMMENT ON TABLE openchpl.ehr_certification_id
  IS 'CMS EHR Certification IDs';
COMMENT ON COLUMN openchpl.ehr_certification_id.key IS 'The unique product collection key';
COMMENT ON COLUMN openchpl.ehr_certification_id.year IS 'The attestation year';
COMMENT ON COLUMN openchpl.ehr_certification_id.certification_id IS 'The unqiue CMS EHR Certification ID';
COMMENT ON COLUMN openchpl.ehr_certification_id.practice_type_id IS 'The practice type if applicable (e.g. 2011)';
ALTER TABLE openchpl.ehr_certification_id ALTER COLUMN year SET STORAGE PLAIN;


-- Index: openchpl.fki_practice_type_id_fk

-- DROP INDEX openchpl.fki_practice_type_id_fk;

CREATE INDEX fki_practice_type_id_fk
  ON openchpl.ehr_certification_id
  USING btree
  (practice_type_id);


-- Trigger: ehr_certification_id_audit on openchpl.ehr_certification_id

-- DROP TRIGGER ehr_certification_id_audit ON openchpl.ehr_certification_id;

CREATE TRIGGER ehr_certification_id_audit
  AFTER INSERT OR UPDATE OR DELETE
  ON openchpl.ehr_certification_id
  FOR EACH ROW
  EXECUTE PROCEDURE audit.if_modified_func();

-- Trigger: ehr_certification_id_timestamp on openchpl.ehr_certification_id

-- DROP TRIGGER ehr_certification_id_timestamp ON openchpl.ehr_certification_id;

CREATE TRIGGER ehr_certification_id_timestamp
  BEFORE UPDATE
  ON openchpl.ehr_certification_id
  FOR EACH ROW
  EXECUTE PROCEDURE openchpl.update_last_modified_date_column();


  -- Table: openchpl.ehr_certification_id_product_map

-- DROP TABLE openchpl.ehr_certification_id_product_map;

CREATE TABLE openchpl.ehr_certification_id_product_map
(
  ehr_certification_id_product_map_id bigserial,
  ehr_certification_id_id bigint NOT NULL,
  certified_product_id bigint NOT NULL,
  creation_date timestamp without time zone NOT NULL DEFAULT now(),
  last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
  last_modified_user bigint,
  CONSTRAINT ehr_certification_id_product_map_pk PRIMARY KEY (ehr_certification_id_product_map_id),
  CONSTRAINT ehr_certification_id_product_map_certified_product_id_fkey FOREIGN KEY (certified_product_id)
      REFERENCES openchpl.certified_product (certified_product_id) MATCH FULL
      ON UPDATE NO ACTION ON DELETE RESTRICT,
  CONSTRAINT ehr_certification_id_product_map_ehr_certification_id_id_fkey FOREIGN KEY (ehr_certification_id_id)
      REFERENCES openchpl.ehr_certification_id (ehr_certification_id_id) MATCH FULL
      ON UPDATE NO ACTION ON DELETE RESTRICT
)
WITH (
  OIDS=FALSE
);
-- ALTER TABLE openchpl.ehr_certification_id_product_map OWNER TO openchpl;
GRANT ALL ON TABLE openchpl.ehr_certification_id_product_map TO openchpl;

-- Index: openchpl.fki_certified_product_id_fk

-- DROP INDEX openchpl.fki_certified_product_id_fk;

CREATE INDEX fki_certified_product_id_fk
  ON openchpl.ehr_certification_id_product_map
  USING btree
  (certified_product_id);

-- Index: openchpl.fki_ehr_certification_id_fk

-- DROP INDEX openchpl.fki_ehr_certification_id_fk;

CREATE INDEX fki_ehr_certification_id_fk
  ON openchpl.ehr_certification_id_product_map
  USING btree
  (ehr_certification_id_id);


-- Trigger: ehr_certification_id_product_map_audit on openchpl.ehr_certification_id_product_map

-- DROP TRIGGER ehr_certification_id_product_map_audit ON openchpl.ehr_certification_id_product_map;

CREATE TRIGGER ehr_certification_id_product_map_audit
  AFTER INSERT OR UPDATE OR DELETE
  ON openchpl.ehr_certification_id_product_map
  FOR EACH ROW
  EXECUTE PROCEDURE audit.if_modified_func();

-- Trigger: ehr_certification_id_product_map_timestamp on openchpl.ehr_certification_id_product_map

-- DROP TRIGGER ehr_certification_id_product_map_timestamp ON openchpl.ehr_certification_id_product_map;

CREATE TRIGGER ehr_certification_id_product_map_timestamp
  BEFORE UPDATE
  ON openchpl.ehr_certification_id_product_map
  FOR EACH ROW
  EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
