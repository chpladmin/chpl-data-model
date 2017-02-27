-------------------------------------------------------------------------------------
-- OCD-1249 Add column to surveillance for "role" of creator
-------------------------------------------------------------------------------------
DO $$ 
    BEGIN
        BEGIN
            ALTER TABLE openchpl.surveillance ADD COLUMN user_permission_id BIGINT NOT NULL DEFAULT 3;
			RAISE NOTICE 'Added column user_permission_id to openchpl.surveillance';
        EXCEPTION
            WHEN duplicate_column THEN RAISE NOTICE 'column user_permission_id already exists in openchpl.surveillance';
        END;
		
		BEGIN
			ALTER TABLE openchpl.surveillance ALTER COLUMN user_permission_id DROP DEFAULT;
			RAISE NOTICE 'Altered user_permission_id column to NOT default to 3';
		END;

        BEGIN
            ALTER TABLE openchpl.surveillance
		ADD CONSTRAINT user_permission_id_fk
		FOREIGN KEY (user_permission_id)
		REFERENCES openchpl.user_permission
		MATCH FULL
		ON DELETE CASCADE
		ON UPDATE CASCADE;
		RAISE NOTICE 'Added FK constraint user_permission_id_fk to openchpl.surveillance';
        EXCEPTION
            WHEN duplicate_object THEN RAISE NOTICE 'Table constraint openchpl.user_permission_id_fk already exists for openchpl.surveillance';
        END;
    END;
$$
