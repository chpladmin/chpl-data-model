---------------------------------------
-- OCD-2679
-- Step 1
-- Setup CHPL managed user/acb
-- relationship
---------------------------------------

DO $$
BEGIN
  -- Clear out the ACL tables, if necessary
  -- This needs to be done in a particular order due to FK constraints
  IF EXISTS(SELECT * FROM information_schema.tables WHERE table_catalog = 'openchpl' AND table_name = 'acl_entry_backup')
  THEN
      DELETE FROM openchpl.acl_entry;
  END IF;
  
  IF EXISTS(SELECT * FROM information_schema.tables WHERE table_catalog = 'openchpl' AND table_name = 'acl_object_identity_backup')
  THEN
      DELETE FROM openchpl.acl_object_identity;
  END IF;
    
  IF EXISTS(SELECT * FROM information_schema.tables WHERE table_catalog = 'openchpl' AND table_name = 'acl_class_backup')
  THEN
      DELETE FROM openchpl.acl_class;
  END IF;
  
  IF EXISTS(SELECT * FROM information_schema.tables WHERE table_catalog = 'openchpl' AND table_name = 'acl_class_backup')
  THEN
	  INSERT INTO openchpl.acl_class
	  SELECT * FROM openchpl.acl_class_backup;
  END IF;

  IF EXISTS(SELECT * FROM information_schema.tables WHERE table_catalog = 'openchpl' AND table_name = 'acl_class_backup')
  THEN
	  INSERT INTO openchpl.acl_object_identity
	  SELECT * FROM openchpl.acl_object_identity_backup;
  END IF;

  IF EXISTS(SELECT * FROM information_schema.tables WHERE table_catalog = 'openchpl' AND table_name = 'acl_entry_backup')
  THEN
	  INSERT INTO openchpl.acl_entry
	  SELECT * FROM openchpl.acl_entry_backup;
  END IF;
END $$;


-- Create new table to support relationship between user and certification_body table
DROP TABLE IF EXISTS openchpl.user_certification_body_map;
CREATE TABLE IF NOT EXISTS openchpl.user_certification_body_map (
id bigserial NOT NULL,
user_id bigint NOT NULL,
certification_body_id bigint NOT NULL,
retired bool NOT NULL DEFAULT false,
creation_date timestamp NOT NULL DEFAULT NOW(),
last_modified_date timestamp NOT NULL DEFAULT NOW(),
last_modified_user bigint NOT NULL,
deleted bool NOT NULL DEFAULT false,
CONSTRAINT user_certification_body_pk PRIMARY KEY (id),
CONSTRAINT user_fk FOREIGN KEY (user_id)
	REFERENCES openchpl.user (user_id) 
	MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
CONSTRAINT certification_body_fk FOREIGN KEY (certification_body_id)
	REFERENCES openchpl.certification_body (certification_body_id) 
	MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);

-- Populate the new table based on the ACL tables
INSERT INTO openchpl.user_certification_body_map
(user_id, certification_body_id, last_modified_user)
select sid.id, oi.object_id_identity, -2
from openchpl.acl_sid sid
inner join openchpl.acl_entry entry
	on sid.id = entry.sid
inner join openchpl.acl_object_identity oi
	on entry.acl_object_identity = oi.id
inner join openchpl.acl_class c
	on oi.object_id_class = c.id
where c.class = 'gov.healthit.chpl.dto.CertificationBodyDTO'
and exists (select * from openchpl.user where user_id = sid.id);

--Add audit triggers
CREATE TRIGGER user_certification_body_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.user_certification_body_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER user_certification_body_map_timestamp BEFORE UPDATE on openchpl.user_certification_body_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

-- Backup acl_entry table
DROP TABLE IF EXISTS openchpl.acl_entry_backup;

CREATE TABLE openchpl.acl_entry_backup AS
SELECT * FROM openchpl.acl_entry;

DELETE FROM openchpl.acl_entry
WHERE acl_object_identity IN 
(SELECT aoi."id" 
FROM openchpl.acl_object_identity aoi
	INNER JOIN openchpl.acl_class ac
		ON aoi.object_id_class = ac."id"
WHERE ac."class" = 'gov.healthit.chpl.dto.CertificationBodyDTO');

-- Backup acl_object_identity table
DROP TABLE IF EXISTS openchpl.acl_object_identity_backup;

CREATE TABLE openchpl.acl_object_identity_backup AS
SELECT * FROM openchpl.acl_object_identity;

DELETE FROM openchpl.acl_object_identity
WHERE object_id_class IN 
(SELECT "id" 
 FROM openchpl.acl_class 
 WHERE "class" = 'gov.healthit.chpl.dto.CertificationBodyDTO');

-- Backup acl_class table
DROP TABLE IF EXISTS openchpl.acl_class_backup;

CREATE TABLE openchpl.acl_class_backup AS
SELECT * FROM openchpl.acl_class;

DELETE FROM openchpl.acl_class
WHERE "class" = 'gov.healthit.chpl.dto.CertificationBodyDTO';