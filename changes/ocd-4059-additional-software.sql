--
-- Add Additional Software to criterion attribute table
--

ALTER TABLE openchpl.certification_criterion_attribute
ADD COLUMN IF NOT EXISTS additional_software bool NOT NULL default false;

--
-- All Criteria
--

UPDATE openchpl.certification_criterion_attribute
SET additional_software = true;
