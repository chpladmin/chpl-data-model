--
-- Add Documentation URL to criterion attribute table
--

ALTER TABLE openchpl.certification_criterion_attribute
ADD COLUMN IF NOT EXISTS documentation_url bool NOT NULL default false;

--
-- 2015 Criteria
--

-- d12
UPDATE openchpl.certification_criterion_attribute
SET documentation_url = true
WHERE criterion_id = 176;

-- d13
UPDATE openchpl.certification_criterion_attribute
SET documentation_url = true
WHERE criterion_id = 177;
