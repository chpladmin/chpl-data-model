-- OCD-2111
-- Delete duplicate certified_product record, created by bug in upload process
UPDATE openchpl.certified_product
SET deleted = true
WHERE certified_product_id = 9275;
