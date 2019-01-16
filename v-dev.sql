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

-----------------------------------------------------------------
-- OCD-2655 Allow ROLE_ONC and ROLE_ADMIN to upload surveillance
-----------------------------------------------------------------
-- Add user permission id to pending surveillance table
-- Update all of the existing data to use 'ACB', since this was the only role to access before this change
-- Alter the new column to be 'not null'
DO
$$
BEGIN
IF NOT EXISTS (SELECT column_name FROM information_schema.columns WHERE table_schema='openchpl' AND table_name='pending_surveillance' AND column_name='user_permission_id') THEN
	ALTER TABLE openchpl.pending_surveillance ADD COLUMN user_permission_id BIGINT;
	UPDATE openchpl.pending_surveillance SET user_permission_id = (SELECT user_permission_id FROM openchpl.user_permission WHERE name LIKE 'ACB');
	ALTER TABLE openchpl.pending_surveillance ALTER COLUMN user_permission_id SET NOT NULL;
END IF;
END
$$
