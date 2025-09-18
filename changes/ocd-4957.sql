DROP VIEW IF EXISTS openchpl.certification_result_details;
DROP VIEW IF EXISTS openchpl.certified_product_details;

ALTER TABLE openchpl.certification_criterion_attribute DROP COLUMN gap;
ALTER TABLE openchpl.certification_result DROP COLUMN gap;
