--
-- OCD-2818 part 2 - drop tables no longer used
--
DROP TABLE IF EXISTS openchpl.global_user_permission_map;
DROP TABLE IF EXISTS openchpl.invited_user_permission;
ALTER TABLE openchpl.invited_user DROP COLUMN certification_body_id;
ALTER TABLE openchpl.invited_user DROP COLUMN testing_lab_id;