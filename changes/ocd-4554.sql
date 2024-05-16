DROP VIEW openchpl.certified_product_details;
DROP VIEW openchpl.developer_search;

DELETE FROM openchpl.vendor_status_history
WHERE vendor_status_id = (SELECT vendor_status_id FROM openchpl.vendor_status WHERE name = 'Active');

DELETE FROM openchpl.vendor_status WHERE name = 'Active';