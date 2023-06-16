--
-- Add Use Cases to criterion attribute table
--

ALTER TABLE openchpl.certification_criterion_attribute
ADD COLUMN IF NOT EXISTS use_cases bool NOT NULL default false;

--
-- 2015 Criteria
--

-- d13
UPDATE openchpl.certification_criterion_attribute
SET use_cases = true
WHERE criterion_id = 177;
