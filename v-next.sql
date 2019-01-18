----------------------------------------------------
-- OCD-2609 Add ROLE_ONC
----------------------------------------------------
INSERT INTO openchpl.user_permission
    (name, description, authority, last_modified_user)
SELECT 'ONC', 'This permission gives ONC users administrative privileges.', 'ROLE_ONC', -1
WHERE
    NOT EXISTS (
        SELECT name FROM openchpl.user_permission WHERE name = 'ONC'
    );
----------------------------------------------------
-- OCD-2609 Convert all current ROLE_ADMIN users
-- (except our admin) to ROLE_ONC.
----------------------------------------------------
UPDATE openchpl.global_user_permission_map 
SET user_permission_id_user_permission = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ONC')
WHERE user_permission_id_user_permission = -2
AND user_id != -2; -- our admin

----------------------------------------------------
-- OCD-2615 Remove ROLE_ONC_STAFF
----------------------------------------------------
-- mark all ROLE_ONC_STAFF user permissions as deleted
UPDATE openchpl.global_user_permission_map
SET deleted = true, last_modified_user = -1
WHERE user_permission_id_user_permission = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ONC_STAFF');

UPDATE openchpl.invited_user_permission
SET deleted = true, last_modified_user = -1
WHERE user_permission_id = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ONC_STAFF');

-- insert a row for a ROLE_ONC role where there was a row for ROLE_ONC_STAFF
INSERT INTO openchpl.global_user_permission_map (user_id, user_permission_id_user_permission, last_modified_user)
SELECT user_id, (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ONC'), -1
	FROM openchpl.global_user_permission_map	
	WHERE user_permission_id_user_permission = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ONC_STAFF')
	AND user_id NOT IN 
		(SELECT DISTINCT user_id 
		FROM openchpl.global_user_permission_map 
		WHERE user_permission_id_user_permission = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ONC'));

UPDATE openchpl.user_permission SET deleted = true, last_modified_user = -1 WHERE name = 'ONC_STAFF';

--OCD-2635
ALTER TABLE openchpl.pending_test_participant ALTER COLUMN test_participant_unique_id TYPE varchar(20);

ALTER TABLE openchpl.pending_test_task ALTER COLUMN test_task_unique_id TYPE varchar(20);


--re-add soft delete triggers
\i dev/openchpl_soft-delete.sql