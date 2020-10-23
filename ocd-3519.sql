DROP TABLE IF EXISTS openchpl.certified_product_mips_measure_criteria;
DROP TABLE IF EXISTS openchpl.certified_product_mips_measure;
DROP TABLE IF EXISTS openchpl.pending_certified_product_mips_measure_criteria;
DROP TABLE IF EXISTS openchpl.pending_certified_product_mips_measure;
DROP TABLE IF EXISTS openchpl.allowed_mips_measure_criteria;
DROP TABLE IF EXISTS openchpl.mips_measure;
DROP TABLE IF EXISTS openchpl.mips_type;
DROP TABLE IF EXISTS openchpl.mips_domain;

CREATE TABLE openchpl.mips_domain (
 id                 bigserial NOT NULL,
 domain             text NOT NULL,
 creation_date      timestamp with time zone NOT NULL DEFAULT NOW(),
 last_modified_date timestamp with time zone NOT NULL DEFAULT NOW(),
 last_modified_user bigint NOT NULL,
 deleted            boolean NOT NULL DEFAULT false,
 CONSTRAINT PK_mips_domain PRIMARY KEY ( id )
);

CREATE TRIGGER mips_domain_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.mips_domain FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER mips_domain_timestamp BEFORE UPDATE on openchpl.mips_domain FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

CREATE TABLE openchpl.mips_type (
 id                 bigserial NOT NULL,
 name               text NOT NULL,
 creation_date      timestamp with time zone NOT NULL DEFAULT NOW(),
 last_modified_date timestamp with time zone NOT NULL DEFAULT NOW(),
 last_modified_user bigint NOT NULL,
 deleted            boolean NOT NULL DEFAULT false,
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
 creation_date               timestamp with time zone NOT NULL DEFAULT NOW(),
 last_modified_date          timestamp with time zone NOT NULL DEFAULT NOW(),
 last_modified_user          bigint NOT NULL,
 deleted                     boolean NOT NULL DEFAULT false,
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
 temp_macra_measure_id      bigint,
 creation_date              timestamp with time zone NOT NULL DEFAULT NOW(),
 last_modified_date         timestamp with time zone NOT NULL DEFAULT NOW(),
 last_modified_user         bigint NOT NULL,
 deleted                    boolean NOT NULL DEFAULT false,
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
 creation_date        timestamp with time zone NOT NULL DEFAULT NOW(),
 last_modified_date   timestamp with time zone NOT NULL DEFAULT NOW(),
 last_modified_user   bigint NOT NULL,
 deleted              boolean NOT NULL DEFAULT false,
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
 creation_date                     timestamp with time zone NOT NULL DEFAULT NOW(),
 last_modified_date                timestamp with time zone NOT NULL DEFAULT NOW(),
 last_modified_user                bigint NOT NULL,
 deleted                           boolean NOT NULL DEFAULT false,
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

CREATE TABLE openchpl.pending_certified_product_mips_measure (
 id                           bigserial NOT NULL,
 pending_certified_product_id bigint NOT NULL,
 mips_measure_id              bigint,
 mips_type_id                 bigint,
 uploaded_value               text, 
 creation_date                timestamp with time zone NOT NULL DEFAULT NOW(),
 last_modified_date           timestamp with time zone NOT NULL DEFAULT NOW(),
 last_modified_user           bigint NOT NULL,
 deleted                      boolean NOT NULL DEFAULT false,
 CONSTRAINT PK_pending_certified_product_mips_measures PRIMARY KEY ( id ),
 CONSTRAINT pending_certified_product_fk FOREIGN KEY (pending_certified_product_id)
      REFERENCES openchpl.pending_certified_product (pending_certified_product_id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
 CONSTRAINT mips_measure_fk FOREIGN KEY (mips_measure_id)
      REFERENCES openchpl.mips_measure (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
 CONSTRAINT mips_type_fk FOREIGN KEY (mips_type_id)
      REFERENCES openchpl.mips_type (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TRIGGER pending_certified_product_mips_measure_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_certified_product_mips_measure FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_certified_product_mips_measure_timestamp BEFORE UPDATE on openchpl.pending_certified_product_mips_measure FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

CREATE TABLE openchpl.pending_certified_product_mips_measure_criteria (
 id                                        bigserial NOT NULL,
 certification_criterion_id                bigint NOT NULL,
 pending_certified_product_mips_measure_id bigint NOT NULL,
 creation_date                             timestamp with time zone NOT NULL DEFAULT NOW(),
 last_modified_date                        timestamp with time zone NOT NULL DEFAULT NOW(),
 last_modified_user                        bigint NOT NULL,
 deleted                                   boolean NOT NULL DEFAULT false,
 CONSTRAINT PK_pending_certified_products_mips_measure_criteria PRIMARY KEY ( id ),
 CONSTRAINT certification_criterion_fk FOREIGN KEY (certification_criterion_id)
      REFERENCES openchpl.certification_criterion (certification_criterion_id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
 CONSTRAINT pending_certified_product_mips_measure_fk FOREIGN KEY (pending_certified_product_mips_measure_id)
      REFERENCES openchpl.pending_certified_product_mips_measure (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TRIGGER pending_certified_product_mips_measure_criteria_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_certified_product_mips_measure_criteria FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_certified_product_mips_measure_criteria_timestamp BEFORE UPDATE on openchpl.pending_certified_product_mips_measure_criteria FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

------------------- INSERT QUESTIONABLE_ACTIVITY_TRIGGERs -------------------
INSERT INTO openchpl.questionable_activity_trigger
(name, level, last_modified_user)
SELECT 'G1/G2 Added', 'Listing', -1
WHERE NOT EXISTS (
    SELECT * 
    FROM openchpl.questionable_activity_trigger
    WHERE name = 'G1/G2 Added'
    AND level = 'Listing');

INSERT INTO openchpl.questionable_activity_trigger
(name, level, last_modified_user)
SELECT 'G1/G2 Removed', 'Listing', -1
WHERE NOT EXISTS (
    SELECT * 
    FROM openchpl.questionable_activity_trigger
    WHERE name = 'G1/G2 Removed'
    AND level = 'Listing');
    
------------------- INSERT MIPS_DOMAINS -------------------
INSERT INTO openchpl.mips_domain
(domain, last_modified_user)
SELECT 'EC', -1 WHERE NOT EXISTS (SELECT * FROM openchpl.mips_domain WHERE domain = 'EH');

INSERT INTO openchpl.mips_domain 
(domain, last_modified_user)
SELECT 'EH/CAH Medicare PI', -1 WHERE NOT EXISTS (SELECT * FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicare PI');

INSERT INTO openchpl.mips_domain
(domain, last_modified_user)
SELECT 'EH/CAH Medicare and Medicaid PI', -1 WHERE NOT EXISTS (SELECT * FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicare and Medicaid PI');

INSERT INTO openchpl.mips_domain
(domain, last_modified_user)
SELECT 'EP Medicaid PI', -1 WHERE NOT EXISTS (SELECT * FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI');

INSERT INTO openchpl.mips_domain
(domain, last_modified_user)
SELECT 'EH/CAH Medicaid PI', -1 WHERE NOT EXISTS (SELECT * FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicaid PI');

INSERT INTO openchpl.mips_domain
(domain, last_modified_user)
SELECT 'EC Group', -1 WHERE NOT EXISTS (SELECT * FROM openchpl.mips_domain WHERE domain = 'EC Group');

INSERT INTO openchpl.mips_domain
(domain, last_modified_user)
SELECT 'EC Individual (TIN/NPI)', -1
WHERE NOT EXISTS (SELECT * FROM openchpl.mips_domain WHERE domain = 'EC Individual (TIN/NPI)');

INSERT INTO openchpl.mips_domain
(domain, last_modified_user)
SELECT 'EH/CAH Stage 3', -1 WHERE NOT EXISTS (SELECT * FROM openchpl.mips_domain WHERE domain = 'EH/CAH Stage 3');

INSERT INTO openchpl.mips_domain
(domain, last_modified_user)
SELECT 'EP Stage 2', -1 WHERE NOT EXISTS (SELECT * FROM openchpl.mips_domain WHERE domain = 'EP Stage 2');

INSERT INTO openchpl.mips_domain
(domain, last_modified_user)
SELECT 'EC ACI', -1 WHERE NOT EXISTS (SELECT * FROM openchpl.mips_domain WHERE domain = 'EC ACI');

INSERT INTO openchpl.mips_domain
(domain, last_modified_user)
SELECT 'EC ACI Transition', -1 WHERE NOT EXISTS (SELECT * FROM openchpl.mips_domain WHERE domain = 'EC ACI Transition');

INSERT INTO openchpl.mips_domain
(domain, last_modified_user)
SELECT 'EH/CAH Stage 2', -1 WHERE NOT EXISTS (SELECT * FROM openchpl.mips_domain WHERE domain = 'EH/CAH Stage 2');

INSERT INTO openchpl.mips_domain
(domain, last_modified_user)
SELECT 'GAP-EH/CAH Stage 2', -1 WHERE NOT EXISTS (SELECT * FROM openchpl.mips_domain WHERE domain = 'GAP-EH/CAH Stage 2');

INSERT INTO openchpl.mips_domain
(domain, last_modified_user)
SELECT 'GAP-EH/CAH Stage 3', -1 WHERE NOT EXISTS (SELECT * FROM openchpl.mips_domain WHERE domain = 'GAP-EH/CAH Stage 3');

INSERT INTO openchpl.mips_domain
(domain, last_modified_user)
SELECT 'GAP-EP Stage 2', -1 WHERE NOT EXISTS (SELECT * FROM openchpl.mips_domain WHERE domain = 'GAP-EP Stage 2');

INSERT INTO openchpl.mips_domain
(domain, last_modified_user)
SELECT 'GAP-EP Stage 3', -1 WHERE NOT EXISTS (SELECT * FROM openchpl.mips_domain WHERE domain = 'GAP-EP Stage 3');

------------------- INSERT MIPS_TYPES -------------------
INSERT INTO openchpl.mips_type
(name, last_modified_user)
SELECT 'G1', -1 WHERE NOT EXISTS (SELECT * FROM openchpl.mips_type WHERE name = 'G1');

INSERT INTO openchpl.mips_type
(name, last_modified_user)
SELECT 'G2', -1 WHERE NOT EXISTS (SELECT * FROM openchpl.mips_type WHERE name = 'G2');

------------------- INSERT MIPS_MEASURES -------------------
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC ACI Transition'), 'RT1', 'Electronic Prescribing: Eligible Clinician', 'Required Test 1: Promoting Interoperability Transition Objective 2 Measure 1 ', false, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Stage 2'), 'RT1', 'Electronic Prescribing: Eligible Hospital/Critical Access Hospital', 'Required Test 1: Stage 2 Objective 4', false, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Stage 2'), 'RT1', 'Electronic Prescribing: Eligible Professional', 'Required Test 1: Stage 2 Objective 4', false, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC'), 'RT1 ', 'Electronic Prescribing: Eligible Clinician', 'Required Test 1: Merit-based Incentive Payment System (MIPS) Promoting Interoperability Performance Category', false, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicare and Medicaid PI'), 'RT1 ', 'Electronic Prescribing: Eligible Hospital/Critical Access Hospital', 'Required Test 1: Medicare and Medicaid Promoting Interoperability Programs', false, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT1 ', 'Electronic Prescribing: Eligible Professional', 'Required Test 1: Medicaid Promoting Interoperability Program', false, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicaid PI'), 'RT10', 'Computerized Provider Order Entry - Medications: Eligible Hospital/Critical Access Hospital', 'Required Test 10: Medicaid Promoting Interoperability Program', false, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Stage 2'), 'RT10', 'Computerized Provider Order Entry - Medications: Eligible Hospital/Critical Access Hospital', 'Required Test 10: Stage 2 Objective 3 Measure 1', false, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT10', 'Computerized Provider Order Entry - Medications: Eligible Professional', 'Required Test 10: Medicaid Promoting Interoperability Program', false, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Stage 2'), 'RT10', 'Computerized Provider Order Entry - Medications: Eligible Professional', 'Required Test 10: Stage 2 Objective 3 Measure 1', false, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'GAP-EH/CAH Stage 2'), 'RT10', '(Gap Certified) Computerized Provider Order Entry - Medications: Eligible Hospital/Critical Access Hospital', 'Required Test 10: Stage 2 Objective 3 Measure 1', false, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'GAP-EH/CAH Stage 3'), 'RT10', '(Gap Certified) Computerized Provider Order Entry - Medications: Eligible Hospital/Critical Access Hospital', 'Required Test 10: Medicaid Promoting Interoperability Program', false, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'GAP-EP Stage 2'), 'RT10', '(Gap Certified) Computerized Provider Order Entry - Medications: Eligible Professional', 'Required Test 10: Stage 2 Objective 3 Measure 1', false, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'GAP-EP Stage 3'), 'RT10', '(Gap Certified) Computerized Provider Order Entry - Medications: Eligible Professional', 'Required Test 10: Medicaid Promoting Interoperability Program', false, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicaid PI'), 'RT11', 'Computerized Provider Order Entry - Laboratory: Eligible Hospital/Critical Access Hospital', 'Required Test 11: Medicaid Promoting Interoperability Program', false, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Stage 2'), 'RT11', 'Computerized Provider Order Entry - Laboratory: Eligible Hospital/Critical Access Hospital', 'Required Test 11: Stage 2 Objective 3 Measure 2', false, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT11', 'Computerized Provider Order Entry - Laboratory: Eligible Professional', 'Required Test 11: Medicaid Promoting Interoperability Program', false, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Stage 2'), 'RT11', 'Computerized Provider Order - Laboratory: Eligible Professional', 'Required Test 11: Stage 2 Objective 3 Measure 2', false, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'GAP-EH/CAH Stage 2'), 'RT11', '(Gap Certified) Computerized Provider Order Entry - Laboratory: Eligible Hospital/Critical Access Hospital', 'Required Test 11: Stage 2 Objective 3 Measure 2', false, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'GAP-EH/CAH Stage 3'), 'RT11', '(Gap Certified) Computerized Provider Order Entry - Laboratory: Eligible Hospital/Critical Access Hospital', 'Required Test 11: Medicaid Promoting Interoperability Program', false, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'GAP-EP Stage 2'), 'RT11', '(Gap Certified) Computerized Provider Order - Laboratory: Eligible Professional', 'Required Test 11: Stage 2 Objective 3 Measure 2', false, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'GAP-EP Stage 3'), 'RT11', '(Gap Certified) Computerized Provider Order - Laboratory: Eligible Professional', 'Required Test 11: Medicaid Promoting Interoperability Program', false, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicaid PI'), 'RT12', 'Computerized Provider Order Entry - Diagnostic Imaging: Eligible Hospital/Critical Access Hospital', 'Required Test 12: Medicaid Promoting Interoperability Program', false, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Stage 2'), 'RT12', 'Computerized Provider Order Entry - Diagnostic Imaging: Eligible Hospital/Critical Access Hospital', 'Required Test 12: Stage 2 Objective 3 Measure 3', false, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT12', 'Computerized Provider Order Entry - Diagnostic Imaging: Eligible Professional', 'Required Test 12: Medicaid Promoting Interoperability Program', false, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Stage 2'), 'RT12', 'Computerized Provider Order Entry - Diagnostic Imaging: Eligible Professional', 'Required Test 12: Stage 2 Objective 3 Measure 3', false, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'GAP-EH/CAH Stage 2'), 'RT12', '(Gap Certified) Computerized Provider Order Entry - Diagnostic Imaging: Eligible Hospital/Critical Access Hospital', 'Required Test 12: Stage 2 Objective 3 Measure 3', false, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'GAP-EH/CAH Stage 3'), 'RT12', '(Gap Certified) Computerized Provider Order Entry - Diagnostic Imaging: Eligible Hospital/Critical Access Hospital', 'Required Test 12: Medicaid Promoting Interoperability Program', false, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'GAP-EP Stage 2'), 'RT12', '(Gap Certified) Computerized Provider Order Entry - Diagnostic Imaging: Eligible Professional', 'Required Test 12: Stage 2 Objective 3 Measure 3', false, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'GAP-EP Stage 3'), 'RT12', '(Gap Certified) Computerized Provider Order Entry - Diagnostic Imaging: Eligible Professional', 'Required Test 12: Medicaid Promoting Interoperability Program', false, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC'), 'RT13 ', 'Query of Prescription Drug Monitoring Program (PDMP): Eligible Clinician', 'Required Test 13: Promoting Interoperability', false, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Stage 3'), 'RT13 ', 'Query of Prescription Drug Monitoring Program (PDMP): Eligible Hospital/Critical Access Hospital', 'Required Test 13: Stage 3', false, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC'), 'RT14 ', 'Verify Opioid Treatment Agreement: Eligible Clinician', 'Required Test 14: Merit-based Incentive Payment System (MIPS) Promoting Interoperability Performance Category', false, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicare PI'), 'RT14 ', 'Verify Opioid Treatment Agreement: Eligible Hospital/Critical Access Hospital', 'Required Test 14: Medicare Promoting Interoperability Program', false, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC'), 'RT15 ', 'Support Electronic Referral Loops by Receiving and Incorporating Health Information: Eligible Clinician', 'Required Test 15: Merit-based Incentive Payment System (MIPS) Promoting Interoperability Performance Category', false, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicare PI'), 'RT15 ', 'Support Electronic Referral Loops by Receiving and Incorporating Health Information: Eligible Hospital/Critical Access Hospital', 'Required Test 15: Medicare Promoting Interoperability Program', false, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC'), 'RT2', 'Provide Patients Electronic Access to Their Health Information (formerly Patient Electronic Access): Eligible Clinician', 'Required Test 2: Merit-based Incentive Payment System (MIPS) Promoting Interoperability Performance Category', true, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC ACI Transition'), 'RT2', 'Patient Electronic Access: Eligible Clinician', 'Required Test 2: Promoting Interoperability Transition Objective 3 Measure 1', true, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC Group'), 'RT2', 'Patient Electronic Access: Eligible Clinician Group', 'Required Test 2: Stage 2 Objective 8 Measure 1 and Stage 3 Objective 5 Measure 1, ACI Transition Objective 3 Measure 1 and ACI Objective 3 Measure 1', true, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicare and Medicaid PI'), 'RT2', 'Provide Patients Electronic Access to Their Health Information (formerly Patient Electronic Access): Eligible Clinician', 'Required Test 2: Medicare and Medicaid Promoting Interoperability Programs', true, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicare and Medicaid PI'), 'RT2', 'Provide Patients Electronic Access to Their Health Information (formerly Patient Electronic Access): Eligible Hospital/Critical Access Hospital', 'Required Test 2: Medicare and Medicaid Promoting Interoperability Programs', true, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Stage 2'), 'RT2', 'Patient Electronic Access: Eligible Hospital/Critical Access Hospital', 'Required Test 2: Stage 2 Objective 8 Measure 1', true, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT2', 'Patient Electronic Access: Eligible Professional', 'Required Test 2: Medicaid Promoting Interoperability Program', true, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT2', 'Provide Patients Electronic Access to Their Health Information (formerly Patient Electronic Access): Eligible Hospital/Critical Access Hospital', 'Required Test 2: Medicaid Promoting Interoperability Program', true, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Stage 2'), 'RT2', 'Patient Electronic Access: Eligible Professional', 'Required Test 2: Stage 2 Objective 8 Measure 1', true, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC ACI'), 'RT3', 'Patient-Specific Education: Eligible Clinician', 'Required Test 3: Promoting Interoperability Objective 3 Measure 2', false, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC ACI Transition'), 'RT3', 'Patient-Specific Education: Eligible Clinician', 'Required Test 3: Promoting Interoperability Transition Objective 4 Measure 2 ', false, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicaid PI'), 'RT3', 'Patient-Specific Education: Eligible Hospital/Critical Access Hospital', 'Required Test 3: Medicaid Promoting Interoperability Program', false, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Stage 2'), 'RT3', 'Patient-Specific Education: Eligible Hospital/Critical Access Hospital', 'Required Test 3: Stage 2 Objective 6', false, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT3', 'Patient-Specific Education: Eligible Professional', 'Required Test 3: Medicaid Promoting Interoperability Program', false, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Stage 2'), 'RT3', 'Patient-Specific Education: Eligible Professional', 'Required Test 3: Stage 2 Objective 6', false, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC'), 'RT4', 'View, Download, or Transmit (VDT): Eligible Clinician', 'Required Test 4: Merit-based Incentive Payment System (MIPS) Promoting Interoperability Performance Category', true, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC ACI'), 'RT4', 'View, Download, or Transmit (VDT): Eligible Clinician', 'Required Test 4: Promoting Interoperability Objective 4 Measure 1', true, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC ACI Transition'), 'RT4', 'View, Download, or Transmit (VDT): Eligible Clinician', 'Required Test 4: Promoting Interoperability Transition Objective 3 Measure 2 ', true, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC Group'), 'RT4', 'View, Download, or Transmit (VDT): Eligible Clinician Group', 'Required Test 4: Stage 2 Objective 8 Measure 2 and Stage 3 Objective 6 Measure 1, ACI Transition Objective 3 Measure 2 and ACI Objective 4 Measure 1', true, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicaid PI'), 'RT4', 'View, Download, or Transmit (VDT): Eligible Hospital/Critical Access Hospital', 'Required Test 4: Medicaid Promoting Interoperability Program', true, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Stage 2'), 'RT4', 'View, Download, or Transmit (VDT): Eligible Hospital/Critical Access Hospital', 'Required Test 4: Stage 2 Objective 8 Measure 2', true, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT4', 'View, Download, or Transmit (VDT): Eligible Hospital/Critical Access Hospital', 'Required Test 4: Medicaid Promoting Interoperability Program', true, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT4', 'View, Download, or Transmit (VDT): Eligible Professional', 'Required Test 4: Medicaid Promoting Interoperability Program', true, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Stage 2'), 'RT4', 'View, Download, or Transmit (VDT): Eligible Professional', 'Required Test 4: Stage 2 Objective 8 Measure 2', true, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC ACI'), 'RT5', 'Secure Electronic Messaging: Eligible Clinician', 'Required Test 5: Promoting Interoperability Objective 4 Measure 2', false, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC ACI Transition'), 'RT5', 'Secure Electronic Messaging: Eligible Clinician', 'Required Test 5: Promoting Interoperability Transition Objective 5 Measure 1 ', false, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicaid PI'), 'RT5', 'Secure Electronic Messaging: Eligible Hospital/Critical Access Hospital', 'Required Test 5: Medicaid Promoting Interoperability Program', false, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Stage 2'), 'RT5', 'Secure Electronic Messaging: Eligible Hospital/Critical Access Hospital', 'Required Test 5: Stage 2 Objective 9', false, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT5', 'Secure Electronic Messaging: Eligible Professional', 'Required Test 5: Medicaid Promoting Interoperability Program', false, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Stage 2'), 'RT5', 'Secure Electronic Messaging: Eligible Professional', 'Required Test 5: Stage 2 Objective 9', false, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC ACI'), 'RT6', 'Patient-Generated Health Data: Eligible Clinician', 'Required Test 6: Promoting Interoperability Objective 4 Measure 3', false, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC Group'), 'RT6', 'Patient-Generated Health Data: Eligible Clinician Group', 'Required Test 6: Stage 3 Objective 6 Measure 3, ACI Objective 4 Measure 3', false, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicaid PI'), 'RT6', 'Patient-Generated Health Data: Eligible Hospital/Critical Access Hospital', 'Required Test 6: Medicaid Promoting Interoperability Program', false, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT6', 'Patient-Generated Health Data: Eligible Professional', 'Required Test 6: Medicaid Promoting Interoperability Program', false, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC'), 'RT7 ', 'Support Electronic Referral Loops by Sending Health Information (formerly Patient Care Record Exchange): Eligible Clinician', 'Required Test 7: Merit-based Incentive Payment System (MIPS) Promoting Interoperability Performance Category', false, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC ACI Transition'), 'RT7 ', 'Patient Care Record Exchange: Eligible Clinician', 'Required Test 7: Promoting Interoperability Transition Objective 6 Measure 1 ', false, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC Group'), 'RT7 ', 'Patient Care Record Exchange: Eligible Clinician Group', 'Required Test 7: Stage 2 Objective 5 and Stage 3 Objective 7 Measure 1, ACI Transition Objective 6 Measure 1 and ACI Objective 5 Measure 1', false, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicare and Medicaid PI'), 'RT7 ', 'Support Electronic Referral Loops by Sending Health Information (formerly Patient Care Record Exchange):  Eligible Hospital/Critical Access Hospital', 'Required Test 7: Medicare and Medicaid Promoting Interoperability Programs', false, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Stage 2'), 'RT7 ', 'Patient Care Record Exchange: Eligible Hospital/Critical Access Hospital', 'Required Test 7: Stage 2 Objective 5', false, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT7 ', 'Patient Care Record Exchange: Eligible Professional', 'Required Test 7: Medicaid Promoting Interoperability Program', false, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Stage 2'), 'RT7 ', 'Patient Care Record Exchange: Eligible Professional', 'Required Test 7: Stage 2 Objective 5', false, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC ACI'), 'RT8 ', 'Request/Accept Patient Care Record: Eligible Clinician', 'Required Test 8: Promoting Interoperability Objective 5 Measure 2', false, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC Individual (TIN/NPI)'), 'RT8 ', 'Request/Accept Patient Care Record: Eligible Clinician Individual (TIN/NPI)', 'Required Test 8: Stage 3 Objective 7 Measure 2, ACI Objective 5 Measure 2', false, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicaid PI'), 'RT8 ', 'Request/Accept Patient Care Record: Eligible Hospital/Critical Access Hospital', 'Required Test 8: Medicaid Promoting Interoperability Program', false, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT8 ', 'Request/Accept Patient Care Record: Eligible Professional', 'Required Test 8: Medicaid Promoting Interoperability Program', false, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC ACI'), 'RT9 ', 'Medication/Clinical Information Reconciliation: Eligible Clinician', 'Required Test 9: Promoting Interoperability Objective 5 Measure 3', false, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC ACI Transition'), 'RT9 ', 'Medication/Clinical Information Reconciliation: Eligible Clinician', 'Required Test 9: Promoting Interoperability Transition Objective 7 Measure 1 ', false, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicaid PI'), 'RT9 ', 'Medication/Clinical Information Reconciliation: Eligible Hospital/Critical Access Hospital', 'Required Test 9: Medicaid Promoting Interoperability Program', false, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Stage 2'), 'RT9 ', 'Medication/Clinical Information Reconciliation: Eligible Hospital/Critical Access Hospital', 'Required Test 9: Stage 2 Objective 7', false, true, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT9 ', 'Medication/Clinical Information Reconciliation: Eligible Professional', 'Required Test 9: Medicaid Promoting Interoperability Program', false, false, -1;
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Stage 2'), 'RT9 ', 'Medication/Clinical Information Reconciliation: Eligible Professional', 'Required Test 9: Stage 2 Objective 7', false, true, -1;

------------------- INSERT ALLOWED_MIPS_MEASURES_CRITERIA -------------------
--Handle all existing measure/criteria mapping, except RT2* and RT4*
INSERT INTO openchpl.allowed_mips_measure_criteria (mips_measure_id, certification_criterion_id, temp_macra_measure_id, last_modified_user) 
SELECT  mm.id, mcm.criteria_id, mcm.id, -1
FROM openchpl.macra_criteria_map mcm
INNER JOIN openchpl.mips_measure mm
  ON mcm.name = mm.required_test
  AND mcm.description  = mm.measure_name
  AND mcm.removed = mm.removed
INNER JOIN openchpl.mips_domain md
  ON mm.mips_domain_id = md.id 
WHERE (mcm.value = mm.required_test_abbr || md."domain" 
OR mcm.value = md."domain")
AND mcm.value NOT IN ('RT2%', 'RT4%')
AND mcm.deleted = false;

--Handle RT2* and RT4* existing measure/criteria mapping 
INSERT INTO openchpl.allowed_mips_measure_criteria (mips_measure_id, certification_criterion_id, temp_macra_measure_id, last_modified_user) 
SELECT  mm.id, mcm.criteria_id, mcm.id, -1
FROM openchpl.macra_criteria_map mcm
INNER JOIN openchpl.mips_measure mm
 ON mcm.name = mm.required_test
 AND mcm.description  = mm.measure_name
 AND mcm.removed = mm.removed
 AND substring(value, 0, 4) = mm.required_test_abbr 
INNER JOIN openchpl.mips_domain md
 ON mm.mips_domain_id = md.id 
WHERE substring(value, 6) = md."domain" 
AND (mcm.value LIKE 'RT2%' OR mcm.value LIKE 'RT4%')
AND mcm.deleted = false;
 
------------------- INSERT CERTIFIED_PRODUCT_MIPS_MEASURES and CERTIFIED_PRODUCT_MIPS_MEASURES_CRITERIA -------------------
DO $$
DECLARE r record;
DECLARE lastid bigint;
BEGIN
    -- G1 Macras, minus RT2* and RT4*
    -- We don't care about certification_criterion_id.  Second INSERT will insert 
    -- a record for each allowed criteria for the new mips measure
    FOR r IN SELECT DISTINCT cr.certified_product_id, all_mips.mips_measure_id
            FROM openchpl.certification_result_g1_macra g1
            INNER JOIN openchpl.certification_result cr
                ON g1.certification_result_id = cr.certification_result_id 
            INNER JOIN openchpl.allowed_mips_measure_criteria all_mips
                ON g1.macra_id = all_mips.temp_macra_measure_id
           	INNER JOIN openchpl.mips_measure mm
                ON all_mips.mips_measure_id = mm.id 
            WHERE mm.required_test_abbr NOT LIKE 'RT4%'
            AND mm.required_test_abbr NOT LIKE 'RT2%'

    LOOP
        -- Return the id that was just created for adding the certified_product_mips_measure_criteria records
        INSERT INTO openchpl.certified_product_mips_measure
        (certified_product_id, mips_measure_id, mips_type_id, last_modified_user)
        VALUES 
        (r.certified_product_id, r.mips_measure_id, 1, -1)
        RETURNING id INTO lastid;
        
        INSERT INTO openchpl.certified_product_mips_measure_criteria
        (certified_product_mips_measure_id, certification_criterion_id, last_modified_user)
        SELECT lastid, certification_criterion_id, -1
        FROM openchpl.allowed_mips_measure_criteria
        WHERE mips_measure_id = r.mips_measure_id;
        
    END LOOP;
    
    -- G1 Macras, ONLY RT2* and RT4*
    -- We need certification_criterion_id.  Second INSERT will insert
    -- a record for each existing macra measure/criteria combo 
    FOR r IN SELECT DISTINCT cr.certified_product_id, all_mips.mips_measure_id, cc.certification_criterion_id
            FROM openchpl.certification_result_g1_macra g1
            INNER JOIN openchpl.certification_result cr
                ON g1.certification_result_id = cr.certification_result_id 
            INNER JOIN openchpl.certification_criterion cc
                ON cr.certification_criterion_id = cc.certification_criterion_id 
            INNER JOIN openchpl.allowed_mips_measure_criteria all_mips
                ON g1.macra_id = all_mips.temp_macra_measure_id
           	INNER JOIN openchpl.mips_measure mm
                ON all_mips.mips_measure_id = mm.id 
            WHERE (mm.required_test_abbr LIKE 'RT4%'
            OR mm.required_test_abbr LIKE 'RT2%')

    LOOP
        -- Return the id that was just created for adding the certified_product_mips_measure_criteria records
        INSERT INTO openchpl.certified_product_mips_measure
        (certified_product_id, mips_measure_id, mips_type_id, last_modified_user)
        VALUES 
        (r.certified_product_id, r.mips_measure_id, 1, -1)
        RETURNING id INTO lastid;
        
        INSERT INTO openchpl.certified_product_mips_measure_criteria
        (certified_product_mips_measure_id, certification_criterion_id, last_modified_user)
        SELECT lastid, certification_criterion_id, -1
        FROM openchpl.allowed_mips_measure_criteria
        WHERE mips_measure_id = r.mips_measure_id
        AND certification_criterion_id = r.certification_criterion_id;
        
    END LOOP;
    
    -- G1 Macras, minus RT2* and RT4*
    -- We don't care about certification_criterion_id.  Second INSERT will insert 
    -- a record for each allowed criteria for the new mips measure
    FOR r IN SELECT DISTINCT cr.certified_product_id, all_mips.mips_measure_id
            FROM openchpl.certification_result_g2_macra g2
            INNER JOIN openchpl.certification_result cr
                ON g2.certification_result_id = cr.certification_result_id 
            INNER JOIN openchpl.allowed_mips_measure_criteria all_mips
                ON g2.macra_id = all_mips.temp_macra_measure_id
           	INNER JOIN openchpl.mips_measure mm
                ON all_mips.mips_measure_id = mm.id 
            WHERE mm.required_test_abbr NOT LIKE 'RT4%'
            AND mm.required_test_abbr NOT LIKE 'RT2%'

    LOOP
        -- Return the id that was just created for adding the certified_product_mips_measure_criteria records
        INSERT INTO openchpl.certified_product_mips_measure
        (certified_product_id, mips_measure_id, mips_type_id, last_modified_user)
        VALUES 
        (r.certified_product_id, r.mips_measure_id, 2, -1)
        RETURNING id INTO lastid;
        
        INSERT INTO openchpl.certified_product_mips_measure_criteria
        (certified_product_mips_measure_id, certification_criterion_id, last_modified_user)
        SELECT lastid, certification_criterion_id, -1
        FROM openchpl.allowed_mips_measure_criteria
        WHERE mips_measure_id = r.mips_measure_id;
        
    END LOOP;
    
    -- G2 Macras, ONLY RT2* and RT4*
    -- We need certification_criterion_id.  Second INSERT will insert
    -- a record for each existing macra measure/criteria combo 
    FOR r IN SELECT DISTINCT cr.certified_product_id, all_mips.mips_measure_id, cc.certification_criterion_id
            FROM openchpl.certification_result_g2_macra g2
            INNER JOIN openchpl.certification_result cr
                ON g2.certification_result_id = cr.certification_result_id 
            INNER JOIN openchpl.certification_criterion cc
                ON cr.certification_criterion_id = cc.certification_criterion_id 
            INNER JOIN openchpl.allowed_mips_measure_criteria all_mips
                ON g2.macra_id = all_mips.temp_macra_measure_id
           	INNER JOIN openchpl.mips_measure mm
                ON all_mips.mips_measure_id = mm.id 
            WHERE (mm.required_test_abbr LIKE 'RT4%'
            OR mm.required_test_abbr LIKE 'RT2%')

    LOOP
        -- Return the id that was just created for adding the certified_product_mips_measure_criteria records
        INSERT INTO openchpl.certified_product_mips_measure
        (certified_product_id, mips_measure_id, mips_type_id, last_modified_user)
        VALUES 
        (r.certified_product_id, r.mips_measure_id, 1, -1)
        RETURNING id INTO lastid;
        
        INSERT INTO openchpl.certified_product_mips_measure_criteria
        (certified_product_mips_measure_id, certification_criterion_id, last_modified_user)
        SELECT lastid, certification_criterion_id, -1
        FROM openchpl.allowed_mips_measure_criteria
        WHERE mips_measure_id = r.mips_measure_id
        AND certification_criterion_id = r.certification_criterion_id;
        
    END LOOP;
END$$;

-- Drop the temporary column that was added to help with mapping macra_criteria_map -> allowed_mips_measure_criteria table
ALTER TABLE openchpl.allowed_mips_measure_criteria DROP COLUMN IF EXISTS temp_macra_measure_id;
