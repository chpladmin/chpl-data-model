DROP TABLE IF EXISTS openchpl.certified_product_mips_measure_criteria;
DROP TABLE IF EXISTS openchpl.certified_product_mips_measure;
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
INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicaid PI'), 'RT10', 'Computerized Provider Order Entry - Medications: Eligible Hospital/Critical Access Hospital', 'Required Test 10: Medicaid Promoting Interoperability Program', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Stage 2'), 'RT10', 'Computerized Provider Order Entry - Medications: Eligible Hospital/Critical Access Hospital', 'Required Test 10: Stage 2 Objective 3 Measure 1', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT10', 'Computerized Provider Order Entry - Medications: Eligible Professional', 'Required Test 10: Medicaid Promoting Interoperability Program', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Stage 2'), 'RT10', 'Computerized Provider Order Entry - Medications: Eligible Professional', 'Required Test 10: Stage 2 Objective 3 Measure 1', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'GAP-EH/CAH Stage 2'), 'RT10', '(Gap Certified) Computerized Provider Order Entry - Medications: Eligible Hospital/Critical Access Hospital', 'Required Test 10: Stage 2 Objective 3 Measure 1', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'GAP-EH/CAH Stage 3'), 'RT10', '(Gap Certified) Computerized Provider Order Entry - Medications: Eligible Hospital/Critical Access Hospital', 'Required Test 10: Medicaid Promoting Interoperability Program', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'GAP-EP Stage 2'), 'RT10', '(Gap Certified) Computerized Provider Order Entry - Medications: Eligible Professional', 'Required Test 10: Stage 2 Objective 3 Measure 1', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'GAP-EP Stage 3'), 'RT10', '(Gap Certified) Computerized Provider Order Entry - Medications: Eligible Professional', 'Required Test 10: Medicaid Promoting Interoperability Program', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicaid PI'), 'RT11', 'Computerized Provider Order Entry - Laboratory: Eligible Hospital/Critical Access Hospital', 'Required Test 11: Medicaid Promoting Interoperability Program', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Stage 2'), 'RT11', 'Computerized Provider Order Entry - Laboratory: Eligible Hospital/Critical Access Hospital', 'Required Test 11: Stage 2 Objective 3 Measure 2', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT11', 'Computerized Provider Order Entry - Laboratory: Eligible Professional', 'Required Test 11: Medicaid Promoting Interoperability Program', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Stage 2'), 'RT11', 'Computerized Provider Order - Laboratory: Eligible Professional', 'Required Test 11: Stage 2 Objective 3 Measure 2', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'GAP-EH/CAH Stage 2'), 'RT11', '(Gap Certified) Computerized Provider Order Entry - Laboratory: Eligible Hospital/Critical Access Hospital', 'Required Test 11: Stage 2 Objective 3 Measure 2', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'GAP-EH/CAH Stage 3'), 'RT11', '(Gap Certified) Computerized Provider Order Entry - Laboratory: Eligible Hospital/Critical Access Hospital', 'Required Test 11: Medicaid Promoting Interoperability Program', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'GAP-EP Stage 2'), 'RT11', '(Gap Certified) Computerized Provider Order - Laboratory: Eligible Professional', 'Required Test 11: Stage 2 Objective 3 Measure 2', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'GAP-EP Stage 3'), 'RT11', '(Gap Certified) Computerized Provider Order - Laboratory: Eligible Professional', 'Required Test 11: Medicaid Promoting Interoperability Program', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicaid PI'), 'RT12', 'Computerized Provider Order Entry - Diagnostic Imaging: Eligible Hospital/Critical Access Hospital', 'Required Test 12: Medicaid Promoting Interoperability Program', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Stage 2'), 'RT12', 'Computerized Provider Order Entry - Diagnostic Imaging: Eligible Hospital/Critical Access Hospital', 'Required Test 12: Stage 2 Objective 3 Measure 3', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT12', 'Computerized Provider Order Entry - Diagnostic Imaging: Eligible Professional', 'Required Test 12: Medicaid Promoting Interoperability Program', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Stage 2'), 'RT12', 'Computerized Provider Order Entry - Diagnostic Imaging: Eligible Professional', 'Required Test 12: Stage 2 Objective 3 Measure 3', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'GAP-EH/CAH Stage 2'), 'RT12', '(Gap Certified) Computerized Provider Order Entry - Diagnostic Imaging: Eligible Hospital/Critical Access Hospital', 'Required Test 12: Stage 2 Objective 3 Measure 3', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'GAP-EH/CAH Stage 3'), 'RT12', '(Gap Certified) Computerized Provider Order Entry - Diagnostic Imaging: Eligible Hospital/Critical Access Hospital', 'Required Test 12: Medicaid Promoting Interoperability Program', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'GAP-EP Stage 2'), 'RT12', '(Gap Certified) Computerized Provider Order Entry - Diagnostic Imaging: Eligible Professional', 'Required Test 12: Stage 2 Objective 3 Measure 3', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'GAP-EP Stage 3'), 'RT12', '(Gap Certified) Computerized Provider Order Entry - Diagnostic Imaging: Eligible Professional', 'Required Test 12: Medicaid Promoting Interoperability Program', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC ACI Transition'), 'RT1', 'Electronic Prescribing: Eligible Clinician', 'Required Test 1: Promoting Interoperability Transition Objective 2 Measure 1 ', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Stage 2'), 'RT1', 'Electronic Prescribing: Eligible Hospital/Critical Access Hospital', 'Required Test 1: Stage 2 Objective 4', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Stage 2'), 'RT1', 'Electronic Prescribing: Eligible Professional', 'Required Test 1: Stage 2 Objective 4', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC'), 'RT1 ', 'Electronic Prescribing: Eligible Clinician', 'Required Test 1: Merit-based Incentive Payment System (MIPS) Promoting Interoperability Performance Category', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicare and Medicaid PI'), 'RT1 ', 'Electronic Prescribing: Eligible Hospital/Critical Access Hospital', 'Required Test 1: Medicare and Medicaid Promoting Interoperability Programs', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT1 ', 'Electronic Prescribing: Eligible Professional', 'Required Test 1: Medicaid Promoting Interoperability Program', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC'), 'RT13 ', 'Query of Prescription Drug Monitoring Program (PDMP): Eligible Clinician', 'Required Test 13: Promoting Interoperability', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Stage 3'), 'RT13 ', 'Query of Prescription Drug Monitoring Program (PDMP): Eligible Hospital/Critical Access Hospital', 'Required Test 13: Stage 3', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC'), 'RT14 ', 'Verify Opioid Treatment Agreement: Eligible Clinician', 'Required Test 14: Merit-based Incentive Payment System (MIPS) Promoting Interoperability Performance Category', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicare PI'), 'RT14 ', 'Verify Opioid Treatment Agreement: Eligible Hospital/Critical Access Hospital', 'Required Test 14: Medicare Promoting Interoperability Program', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC ACI'), 'RT3', 'Patient-Specific Education: Eligible Clinician', 'Required Test 3: Promoting Interoperability Objective 3 Measure 2', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC ACI Transition'), 'RT3', 'Patient-Specific Education: Eligible Clinician', 'Required Test 3: Promoting Interoperability Transition Objective 4 Measure 2 ', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicaid PI'), 'RT3', 'Patient-Specific Education: Eligible Hospital/Critical Access Hospital', 'Required Test 3: Medicaid Promoting Interoperability Program', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Stage 2'), 'RT3', 'Patient-Specific Education: Eligible Hospital/Critical Access Hospital', 'Required Test 3: Stage 2 Objective 6', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT3', 'Patient-Specific Education: Eligible Professional', 'Required Test 3: Medicaid Promoting Interoperability Program', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Stage 2'), 'RT3', 'Patient-Specific Education: Eligible Professional', 'Required Test 3: Stage 2 Objective 6', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC'), 'RT15 ', 'Support Electronic Referral Loops by Receiving and Incorporating Health Information: Eligible Clinician', 'Required Test 15: Merit-based Incentive Payment System (MIPS) Promoting Interoperability Performance Category', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicare PI'), 'RT15 ', 'Support Electronic Referral Loops by Receiving and Incorporating Health Information: Eligible Hospital/Critical Access Hospital', 'Required Test 15: Medicare Promoting Interoperability Program', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC'), 'RT7 ', 'Support Electronic Referral Loops by Sending Health Information (formerly Patient Care Record Exchange): Eligible Clinician', 'Required Test 7: Merit-based Incentive Payment System (MIPS) Promoting Interoperability Performance Category', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC ACI Transition'), 'RT7 ', 'Patient Care Record Exchange: Eligible Clinician', 'Required Test 7: Promoting Interoperability Transition Objective 6 Measure 1 ', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC Group'), 'RT7 ', 'Patient Care Record Exchange: Eligible Clinician Group', 'Required Test 7: Stage 2 Objective 5 and Stage 3 Objective 7 Measure 1, ACI Transition Objective 6 Measure 1 and ACI Objective 5 Measure 1', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicare and Medicaid PI'), 'RT7 ', 'Support Electronic Referral Loops by Sending Health Information (formerly Patient Care Record Exchange):  Eligible Hospital/Critical Access Hospital', 'Required Test 7: Medicare and Medicaid Promoting Interoperability Programs', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Stage 2'), 'RT7 ', 'Patient Care Record Exchange: Eligible Hospital/Critical Access Hospital', 'Required Test 7: Stage 2 Objective 5', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT7 ', 'Patient Care Record Exchange: Eligible Professional', 'Required Test 7: Medicaid Promoting Interoperability Program', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Stage 2'), 'RT7 ', 'Patient Care Record Exchange: Eligible Professional', 'Required Test 7: Stage 2 Objective 5', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC ACI'), 'RT8 ', 'Request/Accept Patient Care Record: Eligible Clinician', 'Required Test 8: Promoting Interoperability Objective 5 Measure 2', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC Individual (TIN/NPI)'), 'RT8 ', 'Request/Accept Patient Care Record: Eligible Clinician Individual (TIN/NPI)', 'Required Test 8: Stage 3 Objective 7 Measure 2, ACI Objective 5 Measure 2', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicaid PI'), 'RT8 ', 'Request/Accept Patient Care Record: Eligible Hospital/Critical Access Hospital', 'Required Test 8: Medicaid Promoting Interoperability Program', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT8 ', 'Request/Accept Patient Care Record: Eligible Professional', 'Required Test 8: Medicaid Promoting Interoperability Program', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC ACI'), 'RT9 ', 'Medication/Clinical Information Reconciliation: Eligible Clinician', 'Required Test 9: Promoting Interoperability Objective 5 Measure 3', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC ACI Transition'), 'RT9 ', 'Medication/Clinical Information Reconciliation: Eligible Clinician', 'Required Test 9: Promoting Interoperability Transition Objective 7 Measure 1 ', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Stage 2'), 'RT9 ', 'Medication/Clinical Information Reconciliation: Eligible Hospital/Critical Access Hospital', 'Required Test 9: Stage 2 Objective 7', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Stage 2'), 'RT9 ', 'Medication/Clinical Information Reconciliation: Eligible Professional', 'Required Test 9: Stage 2 Objective 7', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicaid PI'), 'RT9 ', 'Medication/Clinical Information Reconciliation: Eligible Hospital/Critical Access Hospital', 'Required Test 9: Medicaid Promoting Interoperability Program', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT9 ', 'Medication/Clinical Information Reconciliation: Eligible Professional', 'Required Test 9: Medicaid Promoting Interoperability Program', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC'), 'RT2a ', 'Provide Patients Electronic Access to Their Health Information (formerly Patient Electronic Access): Eligible Clinician', 'Required Test 2: Merit-based Incentive Payment System (MIPS) Promoting Interoperability Performance Category', true, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC ACI Transition'), 'RT2a ', 'Patient Electronic Access: Eligible Clinician', 'Required Test 2: Promoting Interoperability Transition Objective 3 Measure 1 ', true, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC Group'), 'RT2a ', 'Patient Electronic Access: Eligible Clinician Group', 'Required Test 2: Stage 2 Objective 8 Measure 1 and Stage 3 Objective 5 Measure 1, ACI Transition Objective 3 Measure 1 and ACI Objective 3 Measure 1', true, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicare and Medicaid PI'), 'RT2a ', 'Provide Patients Electronic Access to Their Health Information (formerly Patient Electronic Access): Eligible Hospital/Critical Access Hospital', 'Required Test 2: Medicare and Medicaid Promoting Interoperability Programs', true, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Stage 2'), 'RT2a ', 'Patient Electronic Access: Eligible Hospital/Critical Access Hospital', 'Required Test 2: Stage 2 Objective 8 Measure 1', true, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT2a ', 'Patient Electronic Access: Eligible Professional', 'Required Test 2: Medicaid Promoting Interoperability Program', true, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Stage 2'), 'RT2a ', 'Patient Electronic Access: Eligible Professional', 'Required Test 2: Stage 2 Objective 8 Measure 1', true, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC'), 'RT2b ', 'Provide Patients Electronic Access to Their Health Information (formerly Patient Electronic Access): Eligible Clinician', 'Required Test 2: Merit-based Incentive Payment System (MIPS) Promoting Interoperability Performance Category', true, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC ACI Transition'), 'RT2b ', 'Patient Electronic Access: Eligible Clinician', 'Required Test 2: Promoting Interoperability Transition Objective 3 Measure 1 ', true, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC Group'), 'RT2b ', 'Patient Electronic Access: Eligible Clinician Group', 'Required Test 2: Stage 2 Objective 8 Measure 1 and Stage 3 Objective 5 Measure 1, ACI Transition Objective 3 Measure 1 and ACI Objective 3 Measure 1', true, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicare and Medicaid PI'), 'RT2b ', 'Provide Patients Electronic Access to Their Health Information (formerly Patient Electronic Access): Eligible Hospital/Critical Access Hospital', 'Required Test 2: Medicare and Medicaid Promoting Interoperability Programs', true, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Stage 2'), 'RT2b ', 'Patient Electronic Access: Eligible Hospital/Critical Access Hospital', 'Required Test 2: Stage 2 Objective 8 Measure 1', true, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT2b ', 'Patient Electronic Access: Eligible Professional', 'Required Test 2: Medicaid Promoting Interoperability Program', true, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Stage 2'), 'RT2b ', 'Patient Electronic Access: Eligible Professional', 'Required Test 2: Stage 2 Objective 8 Measure 1', true, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC'), 'RT4a ', 'View, Download, or Transmit (VDT): Eligible Clinician', 'Required Test 4: Merit-based Incentive Payment System (MIPS) Promoting Interoperability Performance Category', true, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC ACI Transition'), 'RT4a ', 'View, Download, or Transmit (VDT): Eligible Clinician', 'Required Test 4: Promoting Interoperability Transition Objective 3 Measure 2 ', true, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC Group'), 'RT4a ', 'View, Download, or Transmit (VDT): Eligible Clinician Group', 'Required Test 4: Stage 2 Objective 8 Measure 2 and Stage 3 Objective 6 Measure 1, ACI Transition Objective 3 Measure 2 and ACI Objective 4 Measure 1', true, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicaid PI'), 'RT4a ', 'View, Download, or Transmit (VDT): Eligible Hospital/Critical Access Hospital', 'Required Test 4: Medicaid Promoting Interoperability Program', true, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Stage 2'), 'RT4a ', 'View, Download, or Transmit (VDT): Eligible Hospital/Critical Access Hospital', 'Required Test 4: Stage 2 Objective 8 Measure 2', true, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT4a ', 'View, Download, or Transmit (VDT): Eligible Professional', 'Required Test 4: Medicaid Promoting Interoperability Program', true, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Stage 2'), 'RT4a ', 'View, Download, or Transmit (VDT): Eligible Professional', 'Required Test 4: Stage 2 Objective 8 Measure 2', true, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC'), 'RT4b ', 'View, Download, or Transmit (VDT): Eligible Clinician ', 'Required Test 4: Merit-based Incentive Payment System (MIPS) Promoting Interoperability Performance Category', true, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC ACI Transition'), 'RT4b ', 'View, Download, or Transmit (VDT): Eligible Clinician', 'Required Test 4: Promoting Interoperability Transition Objective 3 Measure 2 ', true, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC Group'), 'RT4b ', 'View, Download, or Transmit (VDT): Eligible Clinician Group', 'Required Test 4: Stage 2 Objective 8 Measure 2 and Stage 3 Objective 6 Measure 1, ACI Transition Objective 3 Measure 2 and ACI Objective 4 Measure 1', true, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicaid PI'), 'RT4b ', 'View, Download, or Transmit (VDT): Eligible Hospital/Critical Access Hospital', 'Required Test 4: Medicaid Promoting Interoperability Program', true, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Stage 2'), 'RT4b ', 'View, Download, or Transmit (VDT): Eligible Hospital/Critical Access Hospital', 'Required Test 4: Stage 2 Objective 8 Measure 2', true, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT4b ', 'View, Download, or Transmit (VDT): Eligible Professional', 'Required Test 4: Medicaid Promoting Interoperability Program', true, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Stage 2'), 'RT4b ', 'View, Download, or Transmit (VDT): Eligible Professional', 'Required Test 4: Stage 2 Objective 8 Measure 2', true, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC ACI'), 'RT5', 'Secure Electronic Messaging: Eligible Clinician', 'Required Test 5: Promoting Interoperability Objective 4 Measure 2', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC ACI Transition'), 'RT5', 'Secure Electronic Messaging: Eligible Clinician', 'Required Test 5: Promoting Interoperability Transition Objective 5 Measure 1 ', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicaid PI'), 'RT5', 'Secure Electronic Messaging: Eligible Hospital/Critical Access Hospital', 'Required Test 5: Medicaid Promoting Interoperability Program', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Stage 2'), 'RT5', 'Secure Electronic Messaging: Eligible Hospital/Critical Access Hospital', 'Required Test 5: Stage 2 Objective 9', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT5', 'Secure Electronic Messaging: Eligible Professional', 'Required Test 5: Medicaid Promoting Interoperability Program', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Stage 2'), 'RT5', 'Secure Electronic Messaging: Eligible Professional', 'Required Test 5: Stage 2 Objective 9', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC ACI'), 'RT6', 'Patient-Generated Health Data: Eligible Clinician', 'Required Test 6: Promoting Interoperability Objective 4 Measure 3', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC Group'), 'RT6', 'Patient-Generated Health Data: Eligible Clinician Group', 'Required Test 6: Stage 3 Objective 6 Measure 3, ACI Objective 4 Measure 3', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicaid PI'), 'RT6', 'Patient-Generated Health Data: Eligible Hospital/Critical Access Hospital', 'Required Test 6: Medicaid Promoting Interoperability Program', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT6', 'Patient-Generated Health Data: Eligible Professional', 'Required Test 6: Medicaid Promoting Interoperability Program', false, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC ACI Transition'), 'RT2a ', 'Patient Electronic Access: Eligible Clinician', 'Required Test 2: Promoting Interoperability Transition Objective 3 Measure 1', true, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Stage 2'), 'RT2a ', 'Patient Electronic Access: Eligible Professional', 'Required Test 2: Stage 2 Objective 8 Measure 1', true, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC'), 'RT2c ', 'Provide Patients Electronic Access to Their Health Information (formerly Patient Electronic Access): Eligible Clinician', 'Required Test 2: Merit-based Incentive Payment System (MIPS) Promoting Interoperability Performance Category', true, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC ACI Transition'), 'RT2c ', 'Patient Electronic Access: Eligible Clinician', 'Required Test 2: Promoting Interoperability Transition Objective 3 Measure 1 ', true, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC Group'), 'RT2c ', 'Patient Electronic Access: Eligible Clinician Group', 'Required Test 2: Stage 2 Objective 8 Measure 1 and Stage 3 Objective 5 Measure 1, ACI Transition Objective 3 Measure 1 and ACI Objective 3 Measure 1', true, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicare and Medicaid PI'), 'RT2c ', 'Provide Patients Electronic Access to Their Health Information (formerly Patient Electronic Access): Eligible Hospital/Critical Access Hospital', 'Required Test 2: Medicare and Medicaid Promoting Interoperability Programs', true, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Stage 2'), 'RT2c ', 'Patient Electronic Access:  Eligible Hospital/Critical Access Hospital', 'Required Test 2: Stage 2 Objective 8 Measure 1', true, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT2c ', 'Patient Electronic Access: Eligible Professional', 'Required Test 2: Medicaid Promoting Interoperability Program', true, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Stage 2'), 'RT2c ', 'Patient Electronic Access: Eligible Professional', 'Required Test 2: Stage 2 Objective 8 Measure 1', true, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC ACI'), 'RT4a ', 'View, Download, or Transmit (VDT):  Eligible Clinician', 'Required Test 4: Promoting Interoperability Objective 4 Measure 1', true, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC ACI Transition'), 'RT4a ', 'View, Download, or Transmit (VDT):  Eligible Clinician', 'Required Test 4: Promoting Interoperability Transition Objective 3 Measure 2 ', true, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC Group'), 'RT4a ', 'View, Download, or Transmit (VDT): Eligible Clinician Group', 'Required Test 4: Stage 2 Objective 8 Measure 2 and Stage 3 Objective 6 Measure 1, ACI Transition Objective 3 Measure 2 and ACI Objective 4 Measure 1', true, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicaid PI'), 'RT4a ', 'View, Download, or Transmit (VDT): Eligible Hospital/Critical Access Hospital', 'Required Test 4: Medicaid Promoting Interoperability Program', true, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Stage 2'), 'RT4a ', 'View, Download, or Transmit (VDT): Eligible Hospital/Critical Access Hospital', 'Required Test 4: Stage 2 Objective 8 Measure 2', true, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT4a ', 'View, Download, or Transmit (VDT): Eligible Professional', 'Required Test 4: Medicaid Promoting Interoperability Program', true, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Stage 2'), 'RT4a ', 'View, Download, or Transmit (VDT): Eligible Professional', 'Required Test 4: Stage 2 Objective 8 Measure 2', true, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC ACI'), 'RT4c ', 'View, Download, or Transmit (VDT):  Eligible Clinician', 'Required Test 4: Promoting Interoperability Objective 4 Measure 1', true, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC ACI Transition'), 'RT4c ', 'View, Download, or Transmit (VDT):  Eligible Clinician', 'Required Test 4: Promoting Interoperability Transition Objective 3 Measure 2 ', true, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC Group'), 'RT4c ', 'View, Download, or Transmit (VDT): Eligible Clinician Group', 'Required Test 4: Stage 2 Objective 8 Measure 2 and Stage 3 Objective 6 Measure 1, ACI Transition Objective 3 Measure 2 and ACI Objective 4 Measure 1', true, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicaid PI'), 'RT4c ', 'View, Download, or Transmit (VDT): Eligible Hospital/Critical Access Hospital', 'Required Test 4: Medicaid Promoting Interoperability Program', true, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Stage 2'), 'RT4c ', 'View, Download, or Transmit (VDT): Eligible Hospital/Critical Access Hospital', 'Required Test 4: Stage 2 Objective 8 Measure 2', true, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT4c ', 'View, Download, or Transmit (VDT): Eligible Professional', 'Required Test 4: Medicaid Promoting Interoperability Program', true, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Stage 2'), 'RT4c ', 'View, Download, or Transmit (VDT): Eligible Professional', 'Required Test 4: Stage 2 Objective 8 Measure 2', true, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC'), 'RT2a ', 'Provide Patients Electronic Access to Their Health Information (formerly Patient Electronic Access): Eligible Clinician', 'Required Test 2: Merit-based Incentive Payment System (MIPS) Promoting Interoperability Performance Category', true, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC ACI Transition'), 'RT2a ', 'Patient Electronic Access: Eligible Clinician', 'Required Test 2: Promoting Interoperability Transition Objective 3 Measure 1 ', true, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC Group'), 'RT2a ', 'Patient Electronic Access: Eligible Clinician Group', 'Required Test 2: Stage 2 Objective 8 Measure 1 and Stage 3 Objective 5 Measure 1, ACI Transition Objective 3 Measure 1 and ACI Objective 3 Measure 1', true, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicare and Medicaid PI'), 'RT2a ', 'Provide Patients Electronic Access to Their Health Information (formerly Patient Electronic Access): Eligible Hospital/Critical Access Hospital', 'Required Test 2: Medicare and Medicaid Promoting Interoperability Programs', true, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC ACI Transition'), 'RT2c ', 'Patient Electronic Access: Eligible Clinician', 'Required Test 2: Promoting Interoperability Transition Objective 3 Measure 1', true, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicare and Medicaid PI'), 'RT2c ', 'Provide Patients Electronic Access to Their Health Information (formerly Patient Electronic Access): Eligible Hospital/Critical Access Hospital', 'Required Test 2: Medicare and Medicaid Promoting Interoperability Programs', true, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Stage 2'), 'RT2c ', 'Patient Electronic Access: Eligible Hospital/Critical Access Hospital', 'Required Test 2: Stage 2 Objective 8 Measure 1', true, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT2c ', 'Patient Electronic Access: Eligible Professional', 'Required Test 2: Medicaid Promoting Interoperability Program', true, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC ACI'), 'RT4a ', 'View, Download, or Transmit (VDT): Eligible Clinician', 'Required Test 4: Promoting Interoperability Objective 4 Measure 1', true, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC ACI Transition'), 'RT4a ', 'View, Download, or Transmit (VDT): Eligible Clinician', 'Required Test 4: Promoting Interoperability Transition Objective 3 Measure 2 ', true, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC ACI'), 'RT4c ', 'View, Download, or Transmit (VDT): Eligible Clinician', 'Required Test 4: Promoting Interoperability Objective 4 Measure 1', true, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC ACI Transition'), 'RT4c ', 'View, Download, or Transmit (VDT): Eligible Clinician', 'Required Test 4: Promoting Interoperability Transition Objective 3 Measure 2 ', true, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC'), 'RT15 ', 'Support Electronic Referral Loops by Receiving and Incorporating Health Information: Eligible Clinician', 'Required Test 15: Merit-based Incentive Payment System (MIPS) Promoting Interoperability Performance Category', false, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicare PI'), 'RT15 ', 'Support Electronic Referral Loops by Receiving and Incorporating Health Information: Eligible Hospital/Critical Access Hospital', 'Required Test 15: Medicare Promoting Interoperability Program', false, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC'), 'RT7 ', 'Support Electronic Referral Loops by Sending Health Information (formerly Patient Care Record Exchange): Eligible Clinician', 'Required Test 7: Merit-based Incentive Payment System (MIPS) Promoting Interoperability Performance Category', false, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicare and Medicaid PI'), 'RT7 ', 'Support Electronic Referral Loops by Sending Health Information (formerly Patient Care Record Exchange):  Eligible Hospital/Critical Access Hospital', 'Required Test 7: Medicare and Medicaid Promoting Interoperability Programs', false, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT7 ', 'Patient Care Record Exchange: Eligible Professional', 'Required Test 7: Medicaid Promoting Interoperability Program', false, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicaid PI'), 'RT8 ', 'Request/Accept Patient Care Record: Eligible Hospital/Critical Access Hospital', 'Required Test 8: Medicaid Promoting Interoperability Program', false, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT8 ', 'Request/Accept Patient Care Record: Eligible Professional', 'Required Test 8: Medicaid Promoting Interoperability Program', false, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicaid PI'), 'RT9 ', 'Medication/Clinical Information Reconciliation: Eligible Hospital/Critical Access Hospital', 'Required Test 9: Medicaid Promoting Interoperability Program', false, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT9 ', 'Medication/Clinical Information Reconciliation: Eligible Professional', 'Required Test 9: Medicaid Promoting Interoperability Program', false, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC'), 'RT1 ', 'Electronic Prescribing: Eligible Clinician', 'Required Test 1: Merit-based Incentive Payment System (MIPS) Promoting Interoperability Performance Category', false, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicare and Medicaid PI'), 'RT1 ', 'Electronic Prescribing: Eligible Hospital/Critical Access Hospital', 'Required Test 1: Medicare and Medicaid Promoting Interoperability Programs', false, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT1 ', 'Electronic Prescribing: Eligible Professional', 'Required Test 1: Medicaid Promoting Interoperability Program', false, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC'), 'RT14 ', 'Verify Opioid Treatment Agreement: Eligible Clinician', 'Required Test 14: Merit-based Incentive Payment System (MIPS) Promoting Interoperability Performance Category', false, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicare PI'), 'RT14 ', 'Verify Opioid Treatment Agreement: Eligible Hospital/Critical Access Hospital', 'Required Test 14: Medicare Promoting Interoperability Program', false, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT2a ', 'Patient Electronic Access: Eligible Professional', 'Required Test 2: Medicaid Promoting Interoperability Program', true, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicare and Medicaid PI'), 'RT2b ', 'Provide Patients Electronic Access to Their Health Information (formerly Patient Electronic Access): Eligible Hospital/Critical Access Hospital', 'Required Test 2: Medicare and Medicaid Promoting Interoperability Programs', true, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT2b ', 'Patient Electronic Access: Eligible Professional', 'Required Test 2: Medicaid Promoting Interoperability Program', true, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicaid PI'), 'RT4b ', 'View, Download, or Transmit (VDT): Eligible Hospital/Critical Access Hospital', 'Required Test 4: Medicaid Promoting Interoperability Program', true, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT4b ', 'View, Download, or Transmit (VDT): Eligible Professional', 'Required Test 4: Medicaid Promoting Interoperability Program', true, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EC'), 'RT2c ', 'Provide Patients Electronic Access to Their Health Information (formerly Patient Electronic Access): Eligible Clinician', 'Required Test 2: Merit-based Incentive Payment System (MIPS) Promoting Interoperability Performance Category', true, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicare and Medicaid PI'), 'RT2a ', 'Provide Patients Electronic Access to Their Health Information (formerly Patient Electronic Access): Eligible Clinician', 'Required Test 2: Medicare and Medicaid Promoting Interoperability Programs', true, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT2a ', 'Provide Patients Electronic Access to Their Health Information (formerly Patient Electronic Access): Eligible Hospital/Critical Access Hospital', 'Required Test 2: Medicaid Promoting Interoperability Program', true, true, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT4a ', 'View, Download, or Transmit (VDT): Eligible Hospital/Critical Access Hospital', 'Required Test 4: Medicaid Promoting Interoperability Program', true, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EH/CAH Medicaid PI'), 'RT4c ', 'View, Download, or Transmit (VDT): Eligible Hospital/Critical Access Hospital', 'Required Test 4: Medicaid Promoting Interoperability Program', true, false, -1;

INSERT INTO openchpl.mips_measure (mips_domain_id, required_test_abbr, required_test, measure_name, criteria_selection_required, removed, last_modified_user) 
SELECT (SELECT id FROM openchpl.mips_domain WHERE domain = 'EP Medicaid PI'), 'RT4c ', 'View, Download, or Transmit (VDT): Eligible Hospital/Critical Access Hospital', 'Required Test 4: Medicaid Promoting Interoperability Program', true, false, -1;
