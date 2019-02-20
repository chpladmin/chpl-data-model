DO $$
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
END $$ ;