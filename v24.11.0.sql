-- Deployment file for version 24.11.0
--     as of 2024-07-08
-- ./changes/ocd-4554.sql
-- Remove old 'statuses' field from Developer
UPDATE openchpl.activity
SET original_data = (original_data::jsonb - 'statuses')::text
WHERE activity_object_concept_id = 3
AND original_data IS NOT NULL;

UPDATE openchpl.activity
SET new_data = (new_data::jsonb - 'statuses')::text
WHERE activity_object_concept_id = 3
AND new_data IS NOT NULL;

-- Remove the duplicate developer status accidentally created
-- We are leaving the data from the "first click" and deleting from the "second click"
DELETE FROM openchpl.vendor_status_history WHERE vendor_status_history_id = 2188;
DELETE FROM openchpl.questionable_activity_developer WHERE id = 310;
DELETE FROM openchpl.activity WHERE activity_id = 108600;

---
--- OCD-4554
---
DROP VIEW openchpl.certified_product_details;
DROP VIEW openchpl.developer_search;

-- add columns for start/end dates
ALTER TABLE openchpl.vendor_status_history ADD COLUMN IF NOT EXISTS start_date date;
ALTER TABLE openchpl.vendor_status_history ADD COLUMN IF NOT EXISTS end_date date;

-- fill in start dates
UPDATE openchpl.vendor_status_history 
SET start_date = status_date::date
WHERE start_date IS NULL;

-- fill in end dates
UPDATE openchpl.vendor_status_history vsh
SET end_date = 
	(SELECT vsh2.status_date::date 
	FROM openchpl.vendor_status_history vsh2 
	WHERE vsh.vendor_id = vsh2.vendor_id 
	AND vsh2.status_date > vsh.status_date
	AND vsh2.deleted = false
	ORDER BY vsh2.status_date ASC
	LIMIT 1)
WHERE deleted = false
AND end_date IS NULL;

DELETE FROM openchpl.vendor_status_history
WHERE vendor_status_id = (SELECT vendor_status_id FROM openchpl.vendor_status WHERE name = 'Active');

ALTER TABLE openchpl.vendor_status_history ALTER COLUMN start_date SET NOT NULL;

DELETE FROM openchpl.vendor_status WHERE name = 'Active';;
-- ./changes/ocd-4597.sql
create table if not exists openchpl.criteria_migration_report (
	id bigserial not null,
	report_name text not null,
	start_date date not null,
	creation_date timestamp not null default now(),
	last_modified_date timestamp not null default now(),
	last_modified_user bigint,
	last_modified_sso_user uuid,
	deleted bool not null default false,
	constraint criteria_migration_report_pk primary key (id)
);

create table if not exists openchpl.criteria_migration_definition (
	id bigserial not null,
	criteria_migration_report_id bigint not null,
	original_certification_criterion_id bigint not null,
	updated_certification_criterion_id bigint not null,
	creation_date timestamp not null default now(),
	last_modified_date timestamp not null default now(),
	last_modified_user bigint,
	last_modified_sso_user uuid,
	deleted bool not null default false,
	constraint criteria_migration_definition_pk primary key (id),
	constraint criteria_migration_report_fk foreign key (criteria_migration_report_id)
		references openchpl.criteria_migration_report (id)
		match simple on update no action on delete restrict
);

create table if not exists openchpl.criteria_migration_count (
	id bigserial not null,
	criteria_migration_definition_id bigint not null,
	report_date date not null,
	original_criterion_count int not null,
	updated_criterion_count int not null,
	original_to_updated_criterion_count int not null,
	creation_date timestamp not null default now(),
	last_modified_date timestamp not null default now(),
	last_modified_user bigint,
	last_modified_sso_user uuid,
	deleted bool not null default false,
	constraint criteria_migration_count_pk primary key (id),
	constraint criteria_migration_definition_fk foreign key (criteria_migration_definition_id)
		references openchpl.criteria_migration_definition (id)
		match simple on update no action on delete restrict
);

insert into openchpl.criteria_migration_report (report_name, start_date, last_modified_user)
select 'Cures', '2020-06-30', 1
where not exists (select * from openchpl.criteria_migration_report where report_name = 'Cures');

insert into openchpl.criteria_migration_report (report_name, start_date, last_modified_user)
select 'HTI-1', '2024-03-11', 1
where not exists (select * from openchpl.criteria_migration_report where report_name = 'HTI-1');

insert into openchpl.criteria_migration_definition (criteria_migration_report_id, original_certification_criterion_id, updated_certification_criterion_id, last_modified_user)
select (select id from openchpl.criteria_migration_report where report_name = 'Cures'), 21, 171, -1
where not exists (
	select *
	from openchpl.criteria_migration_definition 
	where criteria_migration_report_id = (select id from openchpl.criteria_migration_report where report_name = 'Cures')
	and original_certification_criterion_id = 21
	and updated_certification_criterion_id = 171);
	
insert into openchpl.criteria_migration_definition (criteria_migration_report_id, original_certification_criterion_id, updated_certification_criterion_id, last_modified_user)
select (select id from openchpl.criteria_migration_report where report_name = 'HTI-1'), 9, 210, -1
where not exists (
	select *
	from openchpl.criteria_migration_definition 
	where criteria_migration_report_id = (select id from openchpl.criteria_migration_report where report_name = 'HTI-1')
	and original_certification_criterion_id = 9
	and updated_certification_criterion_id = 210);
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('24.11.0', '2024-07-08', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
