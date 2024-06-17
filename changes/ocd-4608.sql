-- load changes to the soft delete triggers before attempting to delete the listing
\i dev/openchpl_soft-delete.sql

-- delete the listing
UPDATE openchpl.certified_product
SET deleted = true
WHERE certified_product_id = 11486;
