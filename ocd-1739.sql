--
-- OCD-1739: clean up unused MUU data
--

DROP TABLE IF EXISTS openchpl.accurate_as_of_date;
ALTER TABLE openchpl.certified_product DROP COLUMN IF EXISTS meaningful_use_users;

-- TODO: remove from data-model and audit files.