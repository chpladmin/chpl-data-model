--
-- Add Export Documentation to criterion attribute table
--

ALTER TABLE openchpl.certification_criterion_attribute
ADD COLUMN IF NOT EXISTS export_documentation bool NOT NULL default false;

--
-- 2015 Criteria
--

-- b10
UPDATE openchpl.certification_criterion_attribute
SET export_documentation = true
WHERE criterion_id = 171;

