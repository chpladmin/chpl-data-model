--
-- OCD-2068
--
ALTER TABLE openchpl.questionable_activity_listing DROP COLUMN IF EXISTS certification_status_change_reason;
ALTER TABLE openchpl.questionable_activity_listing ADD COLUMN certification_status_change_reason text;
