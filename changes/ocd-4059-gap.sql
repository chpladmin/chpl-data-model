--
-- Add GAP to criterion attribute table
--

ALTER TABLE openchpl.certification_criterion_attribute
ADD COLUMN IF NOT EXISTS gap bool NOT NULL default false;

--
-- 2015 Criteria
--

-- a1
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 1;

-- a2
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 2;

-- a3
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 3;

-- a4
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 4;

-- a7
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 7;

-- a8
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 8;


-- a10
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 10;

-- a11
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 11;

--d1
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 29;


--d4
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 32;

--d5
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 33;

--d6
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 34;

--d7
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 35;

--d11
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 39;

-- f3
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 45;

--
-- 2014 Criteria
--

-- a1
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 61;

-- a6
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 66;

-- a7
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 67;

-- a17
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 77;

-- a18
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 78;

-- a19
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 79;

-- a20
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 80;

-- b5B
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 86;

-- d1
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 94;

-- d5
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 98;

-- d6
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 99;

-- d8
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 101;

-- d9
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 102;

-- f1
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 106;

-- f7
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 112;

-- h1
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 117;

-- h2
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 118;

-- h3
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 119;
