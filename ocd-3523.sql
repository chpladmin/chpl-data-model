UPDATE openchpl.contact c
SET friendly_name = null
FROM openchpl.vendor
WHERE vendor.contact_id = c.contact_id;

UPDATE openchpl.contact c
SET friendly_name = null
FROM openchpl.product
WHERE product.contact_id = c.contact_id;