ALTER TABLE openchpl.ehr_certification_id
DROP CONSTRAINT IF EXISTS unique_year_key;

ALTER TABLE openchpl.ehr_certification_id
DROP COLUMN IF EXISTS key CASCADE;