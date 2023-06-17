--
-- Add SED  to criterion attribute table
--

ALTER TABLE openchpl.certification_criterion_attribute
ADD COLUMN IF NOT EXISTS sed bool NOT NULL default false;

--
-- 2015 Criteria
--

-- a1
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 1;

-- a2
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 2;

-- a3
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 3;

-- a4
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 4;

-- a5
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 5;

-- a6
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 6;

-- a7
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 7;

-- a8
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 8;

-- a9
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 9;

-- a14
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 14;

-- b2
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 17;

-- b2Cures
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 166;

-- b3
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 18;

-- b3Cures
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 167;


--
-- 2014 Criteria
--

-- a1
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 61;

-- a2
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 62;

-- a6
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 66;

-- a7
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 67;

-- a8
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 68;

-- a16
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 76;

-- a18
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 78;

-- a19
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 79;

-- a20
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 80;

-- b3
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 83;

-- b4
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 84;

-- b9
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 90;

