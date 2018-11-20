--
-- OCD-2571: Remove erroneous Listing
--
update openchpl.certified_product
set deleted = true
where certified_product_id = 9677;
