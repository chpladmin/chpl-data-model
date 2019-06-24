
ALTER TABLE IF EXISTS openchpl.complaint DROP CONSTRAINT IF EXISTS complaint_type_fk;
ALTER TABLE IF EXISTS openchpl.complaint DROP CONSTRAINT IF EXISTS complainant_type_fk;
DROP TABLE IF EXISTS openchpl.complaint_type;
DROP TABLE IF EXISTS openchpl.complainant_type;

CREATE TABLE openchpl.complainant_type (
	complainant_type_id bigserial not null,
	name text not null,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
    CONSTRAINT complainant_type_pk PRIMARY KEY (complainant_type_id)
);

DO $$
BEGIN
    IF EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name = 'complaint' AND column_name = 'complaint_type_id')
    THEN
        ALTER TABLE openchpl.complaint RENAME COLUMN complaint_type_id TO complainant_type_id;
    END IF;
    IF NOT EXISTS(SELECT column_name FROM information_schema.columns WHERE table_name = 'complaint' AND column_name = 'complainant_type_other')
    THEN 
        ALTER TABLE openchpl.complaint ADD COLUMN complainant_type_other text;
    END IF;
END $$;


INSERT INTO openchpl.complainant_type (name, last_modified_user)
SELECT 'Developer', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.complainant_type
	 WHERE name = 'Developer');

INSERT INTO openchpl.complainant_type (name, last_modified_user)
SELECT 'Provider', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.complainant_type
	 WHERE name = 'Provider');

INSERT INTO openchpl.complainant_type (name, last_modified_user)
SELECT 'Third  Party Organization', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.complainant_type
	 WHERE name = 'Third  Party Organization');

INSERT INTO openchpl.complainant_type (name, last_modified_user)
SELECT 'Government Entity', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.complainant_type
	 WHERE name = 'Government Entity');

INSERT INTO openchpl.complainant_type (name, last_modified_user)
SELECT 'Patient', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.complainant_type
	 WHERE name = 'Patient');
 
INSERT INTO openchpl.complainant_type (name, last_modified_user)
SELECT 'Anonymous', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.complainant_type
	 WHERE name = 'Anonymous');

INSERT INTO openchpl.complainant_type (name, last_modified_user)
SELECT 'Other - [Please Describe]', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.complainant_type
	 WHERE name = 'Other - [Please Describe]');


ALTER TABLE openchpl.complaint 
ADD CONSTRAINT complainant_type_fk FOREIGN KEY (complainant_type_id)
		REFERENCES openchpl.complainant_type (complainant_type_id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT;

