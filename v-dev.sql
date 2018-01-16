--
-- OCD-1996
--

--these two tables could generate questionable activity from a listing update API call
--and any listing update API call could have a reason
ALTER TABLE openchpl.questionable_activity_certification_result DROP COLUMN IF EXISTS reason;
ALTER TABLE openchpl.questionable_activity_listing DROP COLUMN IF EXISTS reason;
ALTER TABLE openchpl.questionable_activity_certification_result ADD COLUMN reason text;
ALTER TABLE openchpl.questionable_activity_listing ADD COLUMN reason text;