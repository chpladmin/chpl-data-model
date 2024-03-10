-- drop table that was never used
DROP TABLE IF EXISTS openchpl.quarterly_report_excluded_listing_map;

-- create new table for many-to-many map of surveillance process type to quarterly report
CREATE TABLE IF NOT EXISTS openchpl.quarterly_report_surveillance_process_type_map (
    id bigserial not null,
    quarterly_report_surveillance_map_id bigint not null,
	surveillance_process_type_id bigint,
	surveillance_process_type_other text,
    creation_date timestamp not null default now(),
    last_modified_date timestamp not null default now(),
    last_modified_user bigint,
	last_modified_sso_user uuid,
    deleted bool not null default false,
    CONSTRAINT quarterly_report_surveillance_process_type_map_pk PRIMARY KEY (id),
	CONSTRAINT quarterly_report_surveillance_map_fk FOREIGN KEY (quarterly_report_surveillance_map_id)
        REFERENCES openchpl.quarterly_report_surveillance_map (id)
	MATCH simple ON UPDATE NO ACTION ON DELETE RESTRICT,
	CONSTRAINT surveillance_process_type_fk FOREIGN KEY (surveillance_process_type_id)
        REFERENCES openchpl.surveillance_process_type (id)
	MATCH simple ON UPDATE NO ACTION ON DELETE RESTRICT
);
CREATE or replace TRIGGER quarterly_report_surveillance_process_type_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.quarterly_report_surveillance_process_type_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE or replace TRIGGER quarterly_report_surveillance_process_type_map_timestamp BEFORE UPDATE on openchpl.quarterly_report_surveillance_process_type_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS quarterly_report_surveillance_process_type_map_last_modified_user_constraint ON openchpl.quarterly_report_surveillance_process_type_map;
CREATE CONSTRAINT TRIGGER quarterly_report_surveillance_process_type_map_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.quarterly_report_surveillance_process_type_map DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();

-- migrate the old data into the new mapping table if the new table is empty (otherwise it's already been migrated)
INSERT INTO openchpl.quarterly_report_surveillance_process_type_map (quarterly_report_surveillance_map_id, surveillance_process_type_id, surveillance_process_type_other, last_modified_user, creation_date, last_modified_date, deleted)
SELECT id, surveillance_process_type_id, surveillance_process_type_other, last_modified_user, creation_date, last_modified_date, deleted
FROM openchpl.quarterly_report_surveillance_map
WHERE NOT EXISTS (
	SELECT * 
	FROM openchpl.quarterly_report_surveillance_process_type_map 
);

-- add new surveillance process types
INSERT INTO openchpl.surveillance_process_type (name, last_modified_user)
SELECT 'Correspondence with End User', -1
WHERE NOT EXISTS (
	SELECT * FROM openchpl.surveillance_process_type WHERE name = 'Correspondence with End User'
);

INSERT INTO openchpl.surveillance_process_type (name, last_modified_user)
SELECT 'Correspondence with Complainant', -1
WHERE NOT EXISTS (
	SELECT * FROM openchpl.surveillance_process_type WHERE name = 'Correspondence with Complainant'
);

INSERT INTO openchpl.surveillance_process_type (name, last_modified_user)
SELECT 'Correspondence with Developer', -1
WHERE NOT EXISTS (
	SELECT * FROM openchpl.surveillance_process_type WHERE name = 'Correspondence with Developer'
);