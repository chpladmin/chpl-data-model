ALTER TABLE openchpl.ucd_process 
ALTER COLUMN name TYPE text;

ALTER TABLE openchpl.ucd_process 
ALTER COLUMN name SET NOT NULL;

DROP VIEW openchpl.certified_product_details;
DROP VIEW openchpl.certified_product_summary;

ALTER TABLE openchpl.certified_product
ALTER COLUMN sed_testing_end TYPE date;

UPDATE openchpl.certified_product
SET sed_testing_end = NULL
WHERE sed_testing_end = '1970-01-01';