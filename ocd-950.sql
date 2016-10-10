--create new table
CREATE TABLE IF NOT EXISTS openchpl.vendor_status(
	vendor_status_id bigserial not null,
	name varchar(100) not null,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT vendor_status_pk PRIMARY KEY (vendor_status_id),
	CONSTRAINT vendor_status_unique_key UNIQUE (name)
);

--insert data if it's not already there
INSERT INTO openchpl.vendor_status
    (name, last_modified_user)
SELECT 'Active', -1
WHERE
    NOT EXISTS (
        SELECT name FROM openchpl.vendor_status WHERE name = 'Active'
    );

INSERT INTO openchpl.vendor_status
    (name, last_modified_user)
SELECT 'Suspended by ONC', -1
WHERE
    NOT EXISTS (
        SELECT name FROM openchpl.vendor_status WHERE name = 'Suspended by ONC'
    );

INSERT INTO openchpl.vendor_status
    (name, last_modified_user)
SELECT 'Under certification ban by ONC', -1
WHERE
    NOT EXISTS (
        SELECT name FROM openchpl.vendor_status WHERE name = 'Under certification ban by ONC'
    );
	
--drop and add the column
ALTER TABLE openchpl.vendor
DROP COLUMN IF EXISTS vendor_status_id;
ALTER TABLE openchpl.vendor
ADD COLUMN vendor_status_id bigint DEFAULT 1; 

--drop and add the constraints
ALTER TABLE openchpl.vendor DROP CONSTRAINT IF EXISTS vendor_status_fk;
ALTER TABLE openchpl.vendor
ADD CONSTRAINT vendor_status_fk FOREIGN KEY (vendor_status_id)
      REFERENCES openchpl.vendor_status (vendor_status_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE RESTRICT;
	  
-- add audit triggers
DROP TRIGGER IF EXISTS vendor_status_audit on openchpl.vendor_status;
CREATE TRIGGER vendor_status_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.vendor_status FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
DROP TRIGGER IF EXISTS vendor_status_timestamp on openchpl.vendor_status;
CREATE TRIGGER vendor_status_timestamp BEFORE UPDATE on openchpl.vendor_status FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();