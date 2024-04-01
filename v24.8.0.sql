-- Deployment file for version 24.8.0
--     as of 2024-04-01
-- ./changes/ocd-4438.sql
create table if not exists openchpl.updated_criteria_status_report (
	id bigserial not null,
	report_day date not null,
	certification_criterion_id bigint not null,
	listings_with_criterion_count int not null,
	fully_up_to_date_count int not null,
	code_sets_up_to_date_count int not null,
	functionalities_tested_up_to_date_count int not null,
	standards_up_to_date_count int not null,
	creation_date timestamp not null default now(),
    last_modified_date timestamp not null default now(),
    last_modified_user bigint,
    last_modified_sso_user uuid,
    deleted bool not null default false,
	constraint updated_criteria_status_report_pk primary key (id),
	constraint certification_criterion_fk foreign key (certification_criterion_id)
        references openchpl.certification_criterion (certification_criterion_id)
        match simple on update no action on delete restrict
);

CREATE or replace TRIGGER updated_criteria_status_report_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.updated_criteria_status_report FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE or replace TRIGGER updated_criteria_status_report_timestamp BEFORE UPDATE on openchpl.updated_criteria_status_report FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS updated_criteria_status_report_last_modified_user_constraint ON openchpl.updated_criteria_status_report;
CREATE CONSTRAINT TRIGGER updated_criteria_status_report_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.updated_criteria_status_report DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();
;
-- ./changes/ocd-4484.sql
-- drop table that was never used
DROP TABLE IF EXISTS openchpl.quarterly_report_excluded_listing_map;

-- create new table for many-to-many map of surveillance process type to quarterly report
CREATE TABLE IF NOT EXISTS openchpl.quarterly_report_surveillance_process_type_map (
    id bigserial not null,
    quarterly_report_surveillance_map_id bigint not null,
	surveillance_process_type_id bigint,
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

-- Migrate the old data into the new mapping table if the new table is empty (otherwise it's already been migrated)
-- Ignore 'Other' records - we will handle those below
INSERT INTO openchpl.quarterly_report_surveillance_process_type_map (quarterly_report_surveillance_map_id, surveillance_process_type_id,  last_modified_user, creation_date, last_modified_date, deleted)
SELECT id, surveillance_process_type_id, last_modified_user, creation_date, last_modified_date, deleted
FROM openchpl.quarterly_report_surveillance_map
WHERE surveillance_process_type_id != 5
AND NOT EXISTS (
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

-- There are only 2 records using the 'surveillance process type other' field and they both have the 
-- value 'Correspondence with Developer'. Katie said we can just make those NOT be 'Other' type and map
-- them to the new process type added above. 
INSERT INTO openchpl.quarterly_report_surveillance_process_type_map (quarterly_report_surveillance_map_id, surveillance_process_type_id,  last_modified_user, creation_date, last_modified_date, deleted)
SELECT id, (SELECT id from openchpl.surveillance_process_type WHERE name = 'Correspondence with Developer'), last_modified_user, creation_date, last_modified_date, deleted
FROM openchpl.quarterly_report_surveillance_map
WHERE id = 307
AND NOT EXISTS (
	SELECT * 
	FROM openchpl.quarterly_report_surveillance_process_type_map 
	WHERE quarterly_report_surveillance_map_id = 307
	AND surveillance_process_type_id = (SELECT id from openchpl.surveillance_process_type WHERE name = 'Correspondence with Developer')
);

UPDATE openchpl.quarterly_report_surveillance_map SET surveillance_process_type_other = NULL WHERE id = 307;

INSERT INTO openchpl.quarterly_report_surveillance_process_type_map (quarterly_report_surveillance_map_id, surveillance_process_type_id,  last_modified_user, creation_date, last_modified_date, deleted)
SELECT id, (SELECT id from openchpl.surveillance_process_type WHERE name = 'Correspondence with Developer'), last_modified_user, creation_date, last_modified_date, deleted
FROM openchpl.quarterly_report_surveillance_map
WHERE id = 315
AND NOT EXISTS (
	SELECT * 
	FROM openchpl.quarterly_report_surveillance_process_type_map 
	WHERE quarterly_report_surveillance_map_id = 315
	AND surveillance_process_type_id = (SELECT id from openchpl.surveillance_process_type WHERE name = 'Correspondence with Developer')
);

UPDATE openchpl.quarterly_report_surveillance_map SET surveillance_process_type_other = NULL WHERE id = 315;

-- Change 'Other - [Please Describe]' to just 'Other' (approved by Roxanne 3/21/24)
UPDATE openchpl.surveillance_process_type SET name = 'Other' WHERE name = 'Other - [Please describe]';


;
-- ./changes/ocd-4501.sql
insert into openchpl.questionable_activity_trigger (name, level, last_modified_user)
select 'Code Set has been removed', 'Certification Criteria', -1
where not exists (
    select *
    from openchpl.questionable_activity_trigger
    where name = 'Code Set has been removed');
;
-- ./changes/ocd-4532.sql
create table if not exists openchpl.user_invitation (
    id bigserial not null,
    email text not null,
	token uuid not null,
	creation_date timestamp not null default now(),
    last_modified_date timestamp not null default now(),
    last_modified_user bigint,
	last_modified_sso_user uuid,
    deleted bool not null default false,
    constraint user_invitation_pk primary key (id)
);
CREATE or replace TRIGGER user_invitation_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.user_invitation FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE or replace TRIGGER user_invitation_timestamp BEFORE UPDATE on openchpl.user_invitation FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS user_invitation_last_modified_user_constraint ON openchpl.user_invitation;
CREATE CONSTRAINT TRIGGER user_invitation_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.user_invitation DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();
;
-- ./changes/ocd-4535.sql
insert into openchpl.certification_result_standard (certification_result_id, standard_id, last_modified_user)
select cr.certification_result_id, 50, -1
from openchpl.certification_result cr
where cr.certification_criterion_id = 179
and cr.deleted = false
and not exists (
	select * 
	from openchpl.certification_result_standard
	where certification_result_id = cr.certification_result_id 
	and standard_id = 50
	and deleted = false);;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('24.8.0', '2024-04-01', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
