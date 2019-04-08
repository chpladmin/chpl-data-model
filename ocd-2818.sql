--
-- OCD-2818 Change many-to-many mapping of users to roles to be one-to-one and migrate existing data
--
-- drop column
ALTER TABLE openchpl.user DROP COLUMN IF EXISTS user_permission_id;
-- add column, allow to be null for now until we have filled it in
ALTER TABLE openchpl.user ADD COLUMN user_permission_id bigint;

-- set permission for admin users
UPDATE openchpl.user
SET user_permission_id = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ADMIN')
WHERE user_id IN 
	(SELECT user_id 
	 FROM openchpl.global_user_permission_map 
	 WHERE user_permission_id_user_permission = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ADMIN'))
AND user_permission_id IS NULL;

-- set permissions for onc users
UPDATE openchpl.user
SET user_permission_id = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ONC')
WHERE user_id IN 
	(SELECT user_id 
	 FROM openchpl.global_user_permission_map 
	 WHERE user_permission_id_user_permission = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ONC'))
AND user_permission_id IS NULL;

-- set permissions for acb users
UPDATE openchpl.user
SET user_permission_id = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ACB')
WHERE user_id IN 
	(SELECT user_id 
	 FROM openchpl.global_user_permission_map 
	 WHERE user_permission_id_user_permission = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ACB'))
AND user_permission_id IS NULL;

-- set permissions for atl users
UPDATE openchpl.user
SET user_permission_id = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ATL')
WHERE user_id IN 
	(SELECT user_id 
	 FROM openchpl.global_user_permission_map 
	 WHERE user_permission_id_user_permission = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ATL'))
AND user_permission_id IS NULL;

-- set permissions for cms_staff users
UPDATE openchpl.user
SET user_permission_id = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'CMS_STAFF')
WHERE user_id IN 
	(SELECT user_id 
	 FROM openchpl.global_user_permission_map 
	 WHERE user_permission_id_user_permission = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'CMS_STAFF'))
AND user_permission_id IS NULL;

-- set permissions for onc_staff users (probably aren't any but just to make sure we have no null values in the table)
UPDATE openchpl.user
SET user_permission_id = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ONC_STAFF')
WHERE user_id IN 
	(SELECT user_id 
	 FROM openchpl.global_user_permission_map 
	 WHERE user_permission_id_user_permission = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ONC_STAFF'))
AND user_permission_id IS NULL;

-- set the new permission column to not be null
ALTER TABLE openchpl.user ALTER COLUMN user_permission_id SET NOT NULL;

-- add foreign key index
ALTER TABLE openchpl.user ADD CONSTRAINT user_permission_fk FOREIGN KEY (user_permission_id)
      REFERENCES openchpl.user_permission (user_permission_id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT;

-- If a user had ACB and ATL permissions they would now have ACB only.
-- Go through the user_testing_lab_map and remove permissions to any ATLs that they had.
UPDATE openchpl.user_testing_lab_map
SET deleted = true
WHERE user_id IN (SELECT user_id FROM openchpl.user WHERE user_permission_id = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ACB'));

---
--- Update Invitation tables
---
-- drop column
ALTER TABLE openchpl.invited_user DROP COLUMN IF EXISTS user_permission_id;
-- add column, allow to be null for now until we have filled it in
ALTER TABLE openchpl.invited_user ADD COLUMN user_permission_id bigint;

-- set permission for admin invitations
UPDATE openchpl.invited_user
SET user_permission_id = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ADMIN')
WHERE invited_user_id IN 
	(SELECT invited_user_id 
	 FROM openchpl.invited_user_permission 
	 WHERE user_permission_id = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ADMIN'))
AND user_permission_id IS NULL;

-- set permissions for onc invitations
UPDATE openchpl.invited_user
SET user_permission_id = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ONC')
WHERE invited_user_id IN 
	(SELECT invited_user_id 
	 FROM openchpl.invited_user_permission 
	 WHERE user_permission_id = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ONC'))
AND user_permission_id IS NULL;

-- set permissions for acb invitations
UPDATE openchpl.invited_user
SET user_permission_id = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ACB')
WHERE invited_user_id IN 
	(SELECT invited_user_id 
	 FROM openchpl.invited_user_permission 
	 WHERE user_permission_id = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ACB'))
AND user_permission_id IS NULL;

-- set permissions for atl invitations
UPDATE openchpl.invited_user
SET user_permission_id = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ATL')
WHERE invited_user_id IN 
	(SELECT invited_user_id 
	 FROM openchpl.invited_user_permission 
	 WHERE user_permission_id = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ATL'))
AND user_permission_id IS NULL;

-- set permissions for cms_staff invitations
UPDATE openchpl.invited_user
SET user_permission_id = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'CMS_STAFF')
WHERE invited_user_id IN 
	(SELECT invited_user_id 
	 FROM openchpl.invited_user_permission 
	 WHERE user_permission_id = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'CMS_STAFF'))
AND user_permission_id IS NULL;

-- set permissions for cms_staff invitations
UPDATE openchpl.invited_user
SET user_permission_id = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ONC_STAFF')
WHERE invited_user_id IN 
	(SELECT invited_user_id 
	 FROM openchpl.invited_user_permission 
	 WHERE user_permission_id = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ONC_STAFF'))
AND user_permission_id IS NULL;

-- set the new permission column to not be null
ALTER TABLE openchpl.invited_user ALTER COLUMN user_permission_id SET NOT NULL;

-- add foreign key index
ALTER TABLE openchpl.invited_user ADD CONSTRAINT user_permission_fk FOREIGN KEY (user_permission_id)
      REFERENCES openchpl.user_permission (user_permission_id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT;

-- migrate the certification_body_id and testing_lab_id to a single column
ALTER TABLE openchpl.invited_user DROP COLUMN permission_object_id;
ALTER TABLE openchpl.invited_user ADD COLUMN permission_object_id bigint;

UPDATE openchpl.invited_user
SET permission_object_id = certification_body_id
WHERE certification_body_id IS NOT NULL;

UPDATE openchpl.invited_user
SET permission_object_id = testing_lab_id
WHERE permission_object_id IS NULL
AND testing_lab_id IS NOT NULL;
