-- Remove the duplicate developer status accidentally created
-- We are leaving the data from the "first click" and deleting from the "second click"
DELETE FROM openchpl.vendor_status_history WHERE vendor_status_history_id = 2188;
DELETE FROM openchpl.questionable_activity_developer WHERE id = 310;
DELETE FROM openchpl.activity WHERE activity_id = 108600;