--
-- Add Test Standard  to criterion attribute table
--

ALTER TABLE openchpl.certification_criterion_attribute
ADD COLUMN IF NOT EXISTS test_standard bool NOT NULL default false;

--
-- 2014 Criteria
--

UPDATE openchpl.certification_criterion_attribute
SET test_standard = true
WHERE criterion_id IN 
	(SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE certification_edition_id = 2);
