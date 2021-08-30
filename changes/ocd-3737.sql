DROP VIEW openchpl.certified_product_summary;

DROP VIEW openchpl.certified_product_details CASCADE;

ALTER TABLE openchpl.certified_product DROP COLUMN IF EXISTS rwt_eligibility_year;
