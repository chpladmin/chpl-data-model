ALTER TABLE openchpl.conformance_method DROP COLUMN IF EXISTS removal_date;
ALTER TABLE openchpl.conformance_method ADD COLUMN removal_date date;

UPDATE openchpl.conformance_method
SET removal_date = '2021-11-15'
WHERE name = 'NCQA eCQM Test Method';