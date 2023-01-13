--
-- Rename tables, columns, indexes to use functionality_tested language
--

ALTER TABLE IF EXISTS openchpl.test_functionality
RENAME COLUMN test_functionality_id TO id;

ALTER TABLE IF EXISTS openchpl.test_functionality
RENAME TO functionality_tested;

ALTER TABLE openchpl.functionality_tested
DROP COLUMN IF EXISTS certification_edition_id;

ALTER INDEX IF EXISTS openchpl.test_functionality_pk RENAME TO functionality_tested_pk;
ALTER INDEX IF EXISTS openchpl.ix_test_functionality RENAME TO ix_functionality_tested;
DROP TRIGGER IF EXISTS test_functionality_audit on openchpl.functionality_tested;
DROP TRIGGER IF EXISTS functionality_tested_audit on openchpl.functionality_tested;
CREATE TRIGGER functionality_tested_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.functionality_tested FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
DROP TRIGGER IF EXISTS test_functionality_timestamp on openchpl.functionality_tested;
DROP TRIGGER IF EXISTS functionality_tested_timestamp on openchpl.functionality_tested;
CREATE TRIGGER functionality_tested_timestamp BEFORE UPDATE on openchpl.functionality_tested FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

ALTER TABLE IF EXISTS openchpl.test_functionality_criteria_map
RENAME COLUMN test_functionality_id TO functionality_tested_id;

ALTER TABLE IF EXISTS openchpl.test_functionality_criteria_map
RENAME TO functionality_tested_criteria_map;

ALTER INDEX IF EXISTS openchpl.test_functionality_criteria_map_pk RENAME TO functionality_tested_criteria_map_pk;
DROP TRIGGER IF EXISTS test_functionality_criteria_map_audit on openchpl.functionality_tested_criteria_map;
DROP TRIGGER IF EXISTS functionality_tested_criteria_map_audit on openchpl.functionality_tested_criteria_map;
CREATE TRIGGER functionality_tested_criteria_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.functionality_tested_criteria_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
DROP TRIGGER IF EXISTS test_functionality_criteria_map_timestamp on openchpl.functionality_tested_criteria_map;
DROP TRIGGER IF EXISTS functionality_tested_criteria_map_timestamp on openchpl.functionality_tested_criteria_map;
CREATE TRIGGER functionality_tested_criteria_map_timestamp BEFORE UPDATE on openchpl.functionality_tested_criteria_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

ALTER TABLE IF EXISTS openchpl.certification_result_test_functionality
RENAME COLUMN certification_result_test_functionality_id TO id;

ALTER TABLE IF EXISTS openchpl.certification_result_test_functionality
RENAME COLUMN test_functionality_id TO functionality_tested_id;

ALTER TABLE IF EXISTS openchpl.certification_result_test_functionality
RENAME TO certification_result_functionality_tested;

ALTER INDEX IF EXISTS openchpl.certification_result_test_functionality_pk RENAME TO certification_result_functionality_tested_pk;
ALTER INDEX IF EXISTS openchpl.ix_certification_result_test_functionality RENAME TO ix_certification_result_functionality_tested;
--audit triggers for this table are already properly named

--
-- Add functionality tested to criterion attribute table
--

ALTER TABLE openchpl.certification_criterion_attribute
ADD COLUMN IF NOT EXISTS functionality_tested bool NOT NULL default false;

--
-- 2015 Criteria
--

-- a1
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 1;

-- a2
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 2;

-- a3
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 3;

-- a4
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 4;

-- a5
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 5;

-- a6
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 6;

-- a7
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 7;

-- a8
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 8;

-- a10
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 10;

-- a13
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 13;

-- a14
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 14;

-- b1
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 16;

-- b1Cures
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 165;

-- b3
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 18;

-- b3Cures
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 167;

-- b4
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 19;

-- b5
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 20;

-- b6
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 21;

-- c3 (c3Cures cannot have functionality tested)
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 27;

-- d7
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 35;

-- d9
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 37;

-- e1
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 40;

-- e1Cures
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 178;

-- f5 (f5Cures cannot have functionality tested)
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 47;

-- g4
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 53;

-- g5
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 54;

-- g6 (g6Cures cannot have functionality tested)
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 55;

-- g8
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 57;

-- g9 (g9Cures cannot have functionality tested)
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 59;

--
-- 2014 Criteria
--

-- a4
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 64;

-- a5
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 65;

-- a6
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 66;

-- a7
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 67;

-- a8
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 68;

-- a14
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 74;

-- b1
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 81;

-- b2
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 82;

-- b7
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 88;

-- b8
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 89;

-- e1
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 103;

-- e2
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 104;

-- f3
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 108;

-- f7
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 112;










