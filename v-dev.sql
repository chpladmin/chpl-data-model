-- Update certification_body table
ALTER TABLE openchpl.certification_body DROP COLUMN IF EXISTS retired;
ALTER TABLE openchpl.certification_body ADD COLUMN retired boolean default false;

UPDATE openchpl.certification_body
SET retired = false
where name = 'InfoGard';

UPDATE openchpl.certification_body
SET retired = true
where name = 'CCHIT';

UPDATE openchpl.certification_body
SET retired = false
where name = 'Drummond Group';

UPDATE openchpl.certification_body
SET retired = false
where name = 'SLI Compliance';

UPDATE openchpl.certification_body
SET retired = true
where name = 'Surescripts LLC';

UPDATE openchpl.certification_body
SET retired = false
where name = 'ICSA Labs';

UPDATE openchpl.certification_body
SET retired = true
where name = 'Pending';

UPDATE openchpl.certification_body
SET deleted = false;

-- Update testing labs
ALTER TABLE openchpl.testing_lab DROP COLUMN IF EXISTS retired;
ALTER TABLE openchpl.testing_lab ADD COLUMN retired boolean default false;

UPDATE openchpl.testing_lab
SET retired = false
where name = 'InfoGard';

UPDATE openchpl.testing_lab
SET retired = true
where name = 'CCHIT';

UPDATE openchpl.testing_lab
SET retired = false
where name = 'Drummond Group';

UPDATE openchpl.testing_lab
SET retired = false
where name = 'SLI Compliance';

UPDATE openchpl.testing_lab
SET retired = false
where name = 'ICSA Labs';

UPDATE openchpl.testing_lab
SET retired = true
where name = 'National Technical Systems';

UPDATE openchpl.testing_lab
SET retired = false
where name = 'National Committee for Quality Assurance (NCQA)';

UPDATE openchpl.testing_lab
SET deleted = false;
