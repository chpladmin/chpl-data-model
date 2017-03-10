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
$$;
-- remove all acl_entry values for pending certified products
DELETE from openchpl.acl_entry 
WHERE acl_object_identity IN
	( SELECT acl_object_identity.id 
	  FROM openchpl.acl_object_identity, openchpl.acl_class 
	  WHERE acl_object_identity.object_id_class = acl_class.id 
	  AND acl_class.class = 'gov.healthit.chpl.dto.PendingCertifiedProductDTO' );
	  
-- remove all object identity values for pending certified products
DELETE from openchpl.acl_object_identity 
WHERE object_id_class IN
	( SELECT id FROM openchpl.acl_class WHERE acl_class.class = 'gov.healthit.chpl.dto.PendingCertifiedProductDTO' );

-- remove PendingCertifiedProductDTO class reference
DELETE FROM openchpl.acl_class WHERE class = 'gov.healthit.chpl.dto.PendingCertifiedProductDTO'; 

-- update the TestingLab acl class id to 3 so there is no gap in the data; foreign key updates should all be made with cascade
UPDATE openchpl.acl_class SET id = 3 WHERE class = 'gov.healthit.chpl.dto.TestingLabDTO'; 

--set the acl_class id generation sequence back to 4 since that would be the next value
SELECT pg_catalog.setval('openchpl.acl_class_id_seq', 4, true);
