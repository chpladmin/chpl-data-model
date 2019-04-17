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

-- Jim Dow is the only user that was ACB + ATL and at this point will have been migrated to an ACB. 
-- He is actually supposed to be an ATL so change his permissions to ATL.
UPDATE openchpl.user
SET user_permission_id = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ATL')
WHERE user_name = 'jpdow01';

-- Some users had strange combinations of roles and associated acbs/atls (for example admin role with permission on multiple acbs)
-- Remove anything that shouldn't be there.
UPDATE openchpl.user_testing_lab_map
SET deleted = true
WHERE user_id IN
	(SELECT user_id FROM openchpl.user WHERE user_permission_id = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ACB'));
UPDATE openchpl.user_testing_lab_map
SET deleted = true
WHERE user_id IN
	(SELECT user_id FROM openchpl.user WHERE user_permission_id = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ADMIN'));
UPDATE openchpl.user_testing_lab_map
SET deleted = true
WHERE user_id IN
	(SELECT user_id FROM openchpl.user WHERE user_permission_id = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ONC'));
UPDATE openchpl.user_testing_lab_map
SET deleted = true
WHERE user_id IN
	(SELECT user_id FROM openchpl.user WHERE user_permission_id = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'CMS_STAFF'));
UPDATE openchpl.user_testing_lab_map
SET deleted = true
WHERE user_id IN
	(SELECT user_id FROM openchpl.user WHERE user_permission_id = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ONC_STAFF'));		
UPDATE openchpl.user_certification_body_map
SET deleted = true
WHERE user_id IN
	(SELECT user_id FROM openchpl.user WHERE user_permission_id = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ATL'));
UPDATE openchpl.user_certification_body_map
SET deleted = true
WHERE user_id IN
	(SELECT user_id FROM openchpl.user WHERE user_permission_id = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ADMIN'));
UPDATE openchpl.user_certification_body_map
SET deleted = true
WHERE user_id IN
	(SELECT user_id FROM openchpl.user WHERE user_permission_id = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ONC'));
UPDATE openchpl.user_certification_body_map
SET deleted = true
WHERE user_id IN
	(SELECT user_id FROM openchpl.user WHERE user_permission_id = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'CMS_STAFF'));
UPDATE openchpl.user_certification_body_map
SET deleted = true
WHERE user_id IN
	(SELECT user_id FROM openchpl.user WHERE user_permission_id = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ONC_STAFF'));
	

-- There are three users who have been removed from their organizations but not marked as deleted.
-- Mark them deleted.
UPDATE openchpl.user
SET deleted = true
WHERE user_name IN ('jodigonzalez', 'rshelby', 'mohitt');

UPDATE openchpl.user_certification_body_map
SET deleted = true
WHERE user_id IN (SELECT user_id from openchpl.user where user_name IN('jodigonzalez', 'rshelby', 'mohitt'));

UPDATE openchpl.user_testing_lab_map
SET deleted = true
WHERE user_id IN (SELECT user_id from openchpl.user where user_name IN('jodigonzalez', 'rshelby', 'mohitt'));

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

---
-- Update ACL class name due to auth refactor
---
UPDATE openchpl.acl_class SET class = 'gov.healthit.chpl.dto.auth.UserDTO' WHERE class='gov.healthit.chpl.auth.dto.UserDTO';

--
-- print out the user accounts before migration and after so we can confirm they are correct
--
select u.user_name,
	u.deleted,
	string_agg(distinct up.authority, ',') as roles_before_migration,
	p.authority as role_after_migration, 
	string_agg(distinct acb.name, ',') as acb_access,
	string_agg(distinct atl.name, ',') as atl_access
from openchpl.user u
left outer join openchpl.user_permission p on u.user_permission_id = p.user_permission_id
left outer join openchpl.global_user_permission_map old_p on u.user_id = old_p.user_id and old_p.deleted = false
left outer join openchpl.user_permission up on up.user_permission_id = old_p.user_permission_id_user_permission
left outer join openchpl.user_certification_body_map ucb on ucb.user_id = u.user_id and ucb.deleted = false
left outer join openchpl.certification_body acb on ucb.certification_body_id = acb.certification_body_id
left outer join openchpl.user_testing_lab_map utl on utl.user_id = u.user_id and utl.deleted = false
left outer join openchpl.testing_lab atl on atl.testing_lab_id = utl.testing_lab_id
group by u.user_name, p.authority, u.deleted
order by u.user_name asc;
