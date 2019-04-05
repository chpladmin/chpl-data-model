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

-- set the column to not be null
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