--
-- Add Api Documentation to criterion attribute table
--

ALTER TABLE openchpl.certification_criterion_attribute
ADD COLUMN IF NOT EXISTS api_documentation bool NOT NULL default false;

--
-- 2015 Criteria
--

-- g7
UPDATE openchpl.certification_criterion_attribute
SET api_documentation = true
WHERE criterion_id = 56;

-- g8
UPDATE openchpl.certification_criterion_attribute
SET api_documentation = true
WHERE criterion_id = 57;

-- g9
UPDATE openchpl.certification_criterion_attribute
SET api_documentation = true
WHERE criterion_id = 58;

-- g9Cures
UPDATE openchpl.certification_criterion_attribute
SET api_documentation = true
WHERE criterion_id = 181;

-- g10
UPDATE openchpl.certification_criterion_attribute
SET api_documentation = true
WHERE criterion_id = 182;

