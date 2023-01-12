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










