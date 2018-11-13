ALTER TABLE openchpl.certification_body DROP COLUMN IF EXISTS retired;
ALTER TABLE openchpl.certification_body ADD COLUMN retired boolean default false;

UPDATE openchpl.certification_body
SET retired = deleted;

ALTER TABLE openchpl.testing_lab DROP COLUMN IF EXISTS retired;
ALTER TABLE openchpl.testing_lab ADD COLUMN retired boolean default false;

UPDATE openchpl.testing_lab
SET retired = deleted;

-- All ACBs and ATLs should have their 'deleted' column set to false
-- but this can't be done until the retired column has been released
-- to production. See OCD-1665.sql.