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
SET user_permission_id_user_permission = (SELECT user_permission_id FROM openchpl.user_permission where name = 'ONC')
WHERE user_permission_id_user_permission = -2
AND user_id != -2; -- our admin

--re-add soft delete triggers
\i dev/openchpl_soft-delete.sql