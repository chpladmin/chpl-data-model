UPDATE openchpl.invited_user_permission 
SET user_permission_id = 2
WHERE user_permission_id = 3;

UPDATE openchpl.invited_user_permission 
SET user_permission_id = 4
WHERE user_permission_id = 5;

DELETE FROM openchpl.invited_user_permission as up
WHERE up.user_permission_id = 5;

DELETE FROM openchpl.invited_user_permission as up
WHERE up.user_permission_id = 3;

DELETE FROM openchpl.user_permission as up
WHERE up.user_permission_id = 5;

DELETE FROM openchpl.user_permission as up
WHERE up.user_permission_id = 3;

UPDATE openchpl.user_permission as up
SET name = 'ACB'
WHERE up.user_permission_id = 2;

UPDATE openchpl.user_permission as up
SET authority = 'ROLE_ACB'
WHERE up.user_permission_id = 2;

UPDATE openchpl.user_permission as up
SET name = 'ATL'
WHERE up.user_permission_id = 4;

UPDATE openchpl.user_permission as up
SET authority = 'ROLE_ATL'
WHERE up.user_permission_id = 4;