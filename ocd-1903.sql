UPDATE openchpl.global_user_permission_map as gupm
SET user_permission_id_user_permission = 2
WHERE user_permission_id_user_permission = 3
AND NOT EXISTS (SELECT user_id FROM openchpl.global_user_permission_map WHERE (user_id, 2) IN (SELECT user_id, user_permission_id_user_permission FROM openchpl.global_user_permission_map));

UPDATE openchpl.global_user_permission_map as gupm
SET user_permission_id_user_permission = 4
WHERE user_permission_id_user_permission = 5
AND NOT EXISTS (SELECT user_id FROM openchpl.global_user_permission_map WHERE (user_id, 4) IN (SELECT user_id, user_permission_id_user_permission FROM openchpl.global_user_permission_map));

UPDATE openchpl.global_user_permission_map as gupm
SET user_permission_id_user_permission = 2
WHERE user_permission_id_user_permission = 3;

UPDATE openchpl.global_user_permission_map as gupm
SET user_permission_id_user_permission = 4
WHERE user_permission_id_user_permission = 5;

DELETE FROM openchpl.global_user_permission_map as gupm
WHERE user_permission_id_user_permission = 3;

DELETE FROM openchpl.global_user_permission_map as gupm
WHERE user_permission_id_user_permission = 5;

UPDATE openchpl.invited_user_permission 
SET user_permission_id = 2
WHERE user_permission_id = 3
AND NOT EXISTS (SELECT user_permission_id FROM openchpl.invited_user_permission WHERE (invited_user_id, 2) IN (SELECT invited_user_id, user_permission_id FROM openchpl.invited_user_permission));

UPDATE openchpl.invited_user_permission 
SET user_permission_id = 4
WHERE user_permission_id = 5
AND NOT EXISTS (SELECT user_permission_id FROM openchpl.invited_user_permission WHERE (invited_user_id, 4) IN (SELECT invited_user_id, user_permission_id FROM openchpl.invited_user_permission));

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
