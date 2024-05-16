-- Remove the duplicate developer status accidentally created
-- We are leaving the data from the "first click" and deleting from the "second click"
DELETE FROM openchpl.vendor_status_history WHERE vendor_status_history_id = 2188;
DELETE FROM openchpl.questionable_activity_developer WHERE id = 310;
DELETE FROM openchpl.activity WHERE activity_id = 108600;

---
--- OCD-4554
---
DROP VIEW openchpl.certified_product_details;
DROP VIEW openchpl.developer_search;

-- add columns for start/end dates
ALTER TABLE openchpl.vendor_status_history ADD COLUMN IF NOT EXISTS start_date date;
ALTER TABLE openchpl.vendor_status_history ADD COLUMN IF NOT EXISTS end_date date;

-- fill in start dates
UPDATE openchpl.vendor_status_history 
SET start_date = status_date::date
WHERE start_date IS NULL;

-- fill in end dates
UPDATE openchpl.vendor_status_history vsh
SET end_date = 
	(SELECT vsh2.status_date::date 
	FROM openchpl.vendor_status_history vsh2 
	WHERE vsh.vendor_id = vsh2.vendor_id 
	AND vsh2.status_date > vsh.status_date
	AND vsh2.deleted = false
	ORDER BY vsh2.status_date ASC
	LIMIT 1)
WHERE deleted = false
AND end_date IS NULL;

DELETE FROM openchpl.vendor_status_history
WHERE vendor_status_id = (SELECT vendor_status_id FROM openchpl.vendor_status WHERE name = 'Active');

ALTER TABLE openchpl.vendor_status_history ALTER COLUMN start_date SET NOT NULL;

DELETE FROM openchpl.vendor_status WHERE name = 'Active';