-- OCD-4212 Remove ATL Users and Permission

UPDATE openchpl.user_permission
SET deleted = true
WHERE name = 'ATL';

UPDATE openchpl.user_testing_lab_map
SET deleted = true;

UPDATE openchpl.user 
SET deleted = TRUE
WHERE user_permission_id = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ATL');

-- OCD-4225 Remove ONC_STAFF Users and permission
UPDATE openchpl.user_permission
SET deleted = true
WHERE name = 'ONC_STAFF';

UPDATE openchpl.user 
SET deleted = TRUE
WHERE user_permission_id = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ONC_STAFF');
