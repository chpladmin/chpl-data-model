-- remove the developers with no listings

UPDATE openchpl.vendor
SET deleted = true
WHERE vendor_id IN (710, 1645, 937, 1464, 1644, 34, 1744, 647);
