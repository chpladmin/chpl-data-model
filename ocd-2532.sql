--Remove the column test_functionality.certification_criterion_id_deleted
ALTER TABLE openchpl.test_functionality DROP COLUMN IF EXISTS certification_criterion_id_deleted;
