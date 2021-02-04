DROP TABLE IF EXISTS openchpl.certification_criterion_attribute;

CREATE TABLE openchpl.certification_criterion_attribute (
  id                 bigserial NOT NULL,
  criterion_id       bigint NOT NULL,
  svap               bool NOT NULL DEFAULT false,
  creation_date      timestamp NOT NULL DEFAULT NOW(),
  last_modified_date timestamp NOT NULL DEFAULT NOW(),
  last_modified_user bigint NOT NULL,
  deleted            bool NOT NULL DEFAULT false,
  CONSTRAINT certification_criterion_attribute_pk PRIMARY KEY (id),
  CONSTRAINT certification_criterion_id_fk FOREIGN KEY (criterion_id)
        REFERENCES openchpl.certification_criterion (certification_criterion_id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE TRIGGER certification_criterion_attribute_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certification_criterion_attribute FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certification_criterion_attribute_timestamp BEFORE UPDATE on openchpl.certification_criterion_attribute FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (19, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (20, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (21, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (25, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (26, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (43, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (44, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (45, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (46, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (48, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (49, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (58, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (182, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (165, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (166, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (167, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (168, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (169, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (170, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (171, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (172, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (178, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (179, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (56, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (57, true, -1);
