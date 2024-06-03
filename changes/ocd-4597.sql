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
select 'HTI-1', '2024-03-12', 1
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
