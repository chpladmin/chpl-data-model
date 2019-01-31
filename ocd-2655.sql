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
	ALTER TABLE openchpl.pending_surveillance 
	ADD COLUMN user_permission_id BIGINT;
	
	UPDATE openchpl.pending_surveillance
	SET user_permission_id = (SELECT user_permission_id FROM openchpl.user_permission WHERE name LIKE 'ACB');
	
	ALTER TABLE openchpl.pending_surveillance
	ALTER COLUMN user_permission_id SET NOT NULL;
	
	ALTER TABLE openchpl.pending_surveillance
	ADD CONSTRAINT user_permission_fk
	FOREIGN KEY (user_permission_id)
	REFERENCES openchpl.user_permission (user_permission_id)
	MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE;
 END IF;
END
$$
