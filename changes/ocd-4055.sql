ALTER TABLE openchpl.certification_body
ALTER COLUMN retirement_date TYPE date;

ALTER TABLE openchpl.testing_lab
ALTER COLUMN retirement_date TYPE date;

ALTER TABLE openchpl.testing_lab
DROP COLUMN IF EXISTS accredidation_number;
