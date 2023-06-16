--
-- Add G1 Success to criterion attribute table
--

ALTER TABLE openchpl.certification_criterion_attribute
ADD COLUMN IF NOT EXISTS g1_success bool NOT NULL default false;

--
-- 2014 Criteria
--

-- a1
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 61;

-- a3
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 63;

-- a4
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 64;

-- a5
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 65;

-- a6
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 66;

-- a7
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 67;

-- a9
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 69;

-- a11
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 71;

-- a12
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 72;

-- a13
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 73;

-- a14
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 74;

-- a15
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 75;

-- a16
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 76;

-- a17
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 77;

-- b2
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 82;

-- b3
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 83;

-- b4
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 84;

-- b5A
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 85;

-- b5B
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 86;

-- b6
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 87;

-- e1
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 103;

-- e2
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 104;

-- e3
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 105;
