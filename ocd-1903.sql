UPDATE openchpl.global_user_permission_map as gupm
SET user_permission_id_user_permission = 2
WHERE user_id = 22;

DELETE FROM openchpl.global_user_permission_map as gupm
WHERE user_permission_id_user_permission = 3;

DELETE FROM openchpl.global_user_permission_map as gupm
WHERE user_permission_id_user_permission = 5;

DELETE FROM openchpl.invited_user_permission as iup
WHERE iup.user_permission_id = 3;

DELETE FROM openchpl.invited_user_permission as iup
WHERE iup.user_permission_id = 5;

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

