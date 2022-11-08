create table if not exists openchpl.additional_nonconformity_type(
    id bigint not null default nextval('openchpl.certification_criterion_certification_criterion_id_seq'),
    name text not null,
    removed boolean not null default false,
	creation_date timestamp not null default now(),
	last_modified_date timestamp not null default now(),
	last_modified_user bigint not null,
	deleted bool not null default false,
    constraint additional_nonconformity_type_pk primary key (id)
);

alter table openchpl.surveillance_nonconformity
add column if not exists nonconformity_type_id bigint;

insert into openchpl.additional_nonconformity_type(name, removed, last_modified_user) 
select '170.523 (k)(1)', false, -1
where not exists (
    select * 
    from openchpl.additional_nonconformity_type
    where name = '170.523 (k)(1)'
    and removed = false
);

insert into openchpl.additional_nonconformity_type(name, removed, last_modified_user) 
select '170.523 (k)(2)', true, -1
where not exists (
    select * 
    from openchpl.additional_nonconformity_type
    where name = '170.523 (k)(2)'
    and removed = true
);

insert into openchpl.additional_nonconformity_type(name, removed, last_modified_user) 
select '170.523 (l)', false, -1
where not exists (
    select * 
    from openchpl.additional_nonconformity_type
    where name = '170.523 (l)'
    and removed = false
);

insert into openchpl.additional_nonconformity_type(name, removed, last_modified_user) 
select 'Annual Real World Testing Plan', false, -1
where not exists (
    select * 
    from openchpl.additional_nonconformity_type
    where name = 'Annual Real World Testing Plan'
    and removed = false
);

insert into openchpl.additional_nonconformity_type(name, removed, last_modified_user) 
select 'Annual Real World Testing Results Reports', false, -1
where not exists (
    select * 
    from openchpl.additional_nonconformity_type
    where name = 'Annual Real World Testing Results Reports' 
    and removed = false
);

insert into openchpl.additional_nonconformity_type(name, removed, last_modified_user) 
select 'Semiannual Attestations Submission', false, -1
where not exists (
    select * 
    from openchpl.additional_nonconformity_type
    where name = 'Semiannual Attestations Submission'
    and removed = false
);

insert into openchpl.additional_nonconformity_type(name, removed, last_modified_user) 
select 'Other Non-Conformity', false, -1
where not exists (
    select * 
    from openchpl.additional_nonconformity_type
    where name = 'Other Non-Conformity'
    and removed = false
);

drop view if exists openchpl.nonconformity_type;

create or replace view openchpl.nonconformity_type as  
	select certification_criterion_id as id, certification_edition_id, number, title, removed, 'CRITERION' as classification
	from openchpl.certification_criterion
	where certification_edition_id in (3,2)
	union
	select id, null, null, name, removed, 'REQUIREMENT'
	from openchpl.additional_nonconformity_type;

update openchpl.surveillance_nonconformity
set nonconformity_type_id = certification_criterion_id 
where certification_criterion_id is not null
and nonconformity_type_id is null;

update openchpl.surveillance_nonconformity sn
set nonconformity_type_id = (select id from openchpl.nonconformity_type where title = sn.nonconformity_type) 
where certification_criterion_id is null
and nonconformity_type_id is null;

alter table if exists openchpl.surveillance_requirement_type 
rename to requirement_group_type;

create table if not exists openchpl.additional_requirement_type(
    id bigint not null default nextval('openchpl.certification_criterion_certification_criterion_id_seq'),
	requirement_group_type_id bigint not null,
    name text not null,
    removed boolean not null default false,
	creation_date timestamp not null default now(),
	last_modified_date timestamp not null default now(),
	last_modified_user bigint not null,
	deleted bool not null default false,
    constraint additional_requirement_type_pk primary key (id)
);

insert into openchpl.additional_requirement_type(requirement_group_type_id, name, removed, last_modified_user) 
select 2, '170.523 (k)(1)', false, -1
where not exists (
    select * 
    from openchpl.additional_requirement_type
    where name = '170.523 (k)(1)'
    and removed = false
);

insert into openchpl.additional_requirement_type(requirement_group_type_id, name, removed, last_modified_user) 
select 2, '170.523 (k)(2)', true, -1
where not exists (
    select * 
    from openchpl.additional_requirement_type
    where name = '170.523 (k)(2)'
    and removed = true
);

insert into openchpl.additional_requirement_type(requirement_group_type_id, name, removed, last_modified_user) 
select 4, 'Annual Real World Testing Plan', false, -1
where not exists (
    select * 
    from openchpl.additional_requirement_type
    where name = 'Annual Real World Testing Plan'
    and removed = false
);	

insert into openchpl.additional_requirement_type(requirement_group_type_id, name, removed, last_modified_user) 
select 4, 'Annual Real World Testing Results Reports', false, -1
where not exists (
    select * 
    from openchpl.additional_requirement_type
    where name = 'Annual Real World Testing Results Reports'
    and removed = false
);

insert into openchpl.additional_requirement_type(requirement_group_type_id, name, removed, last_modified_user) 
select 5, 'Semiannual Attestations Submission', false, -1
where not exists (
    select * 
    from openchpl.additional_requirement_type
    where name = 'Semiannual Attestations Submission'
    and removed = false
);

drop view if exists openchpl.requirement_type;

create view openchpl.requirement_type as 
select certification_criterion_id as id, title, number, removed, certification_edition_id, 1 as requirement_group_type_id
from openchpl.certification_criterion
where certification_edition_id in (2,3)
union
select id, name, null, removed, null, requirement_group_type_id
from openchpl.additional_requirement_type;

alter table openchpl.surveillance_requirement
add column if not exists requirement_type_id bigint;

alter table openchpl.surveillance_requirement
add column if not exists requirement_type_other text;

--Convert the requirements that are criterion
update openchpl.surveillance_requirement
set requirement_type_id = certification_criterion_id 
where type_id = 1
and requirement_type_id is null;

--convert everything that is not a criterion or other
update openchpl.surveillance_requirement sr
set requirement_type_id = 
    (select id 
    from openchpl.requirement_type 
    where title = sr.requirement)
where type_id not in (1, 3)
and requirement_type_id is null;

--convert other, anything that has not been converted
update openchpl.surveillance_requirement sr
set requirement_type_id = null,
requirement_type_other = requirement
where requirement_type_id is null
and requirement_type_id is null;

alter table openchpl.surveillance_requirement
alter column type_id drop not null;


--new requirement types
insert into openchpl.requirement_group_type (name, last_modified_user)
select 'Developer Submission Requirement', -1
where not exists (
    select *
	from openchpl.requirement_group_type
	where name = 'Developer Submission Requirement'
);

insert into openchpl.additional_requirement_type (requirement_group_type_id, name, last_modified_user)
select (select id from openchpl.requirement_group_type where name = 'Developer Submission Requirement'),
    '170.523 (m)(1): Adaptations and updates',
	-1
where not exists (
    select *
	from openchpl.additional_requirement_type
    where name = '170.523 (m)(1): Adaptations and updates'
);

insert into openchpl.additional_requirement_type (requirement_group_type_id, name, last_modified_user)
select (select id from openchpl.requirement_group_type where name = 'Developer Submission Requirement'),
    '170.523 (m)(2): Adaptations and updates',
	-1
where not exists (
    select *
	from openchpl.additional_requirement_type
    where name = '170.523 (m)(2): Adaptations and updates'
);

insert into openchpl.additional_requirement_type (requirement_group_type_id, name, last_modified_user)
select (select id from openchpl.requirement_group_type where name = 'Developer Submission Requirement'),
    '170.523 (m)(3): Adaptations and updates',
	-1
where not exists (
    select *
	from openchpl.additional_requirement_type
    where name = '170.523 (m)(3): Adaptations and updates'
);

insert into openchpl.additional_requirement_type (requirement_group_type_id, name, last_modified_user)
select (select id from openchpl.requirement_group_type where name = 'Developer Submission Requirement'),
    '170.523 (m)(4): Adaptations and updates',
	-1
where not exists (
    select *
	from openchpl.additional_requirement_type
    where name = '170.523 (m)(4): Adaptations and updates'
);

insert into openchpl.additional_requirement_type (requirement_group_type_id, name, last_modified_user)
select (select id from openchpl.requirement_group_type where name = 'Developer Submission Requirement'),
    '170.523 (m)(5): Adaptations and updates',
	-1
where not exists (
    select *
	from openchpl.additional_requirement_type
    where name = '170.523 (m)(5): Adaptations and updates'
);


insert into openchpl.additional_requirement_type (requirement_group_type_id, name, last_modified_user)
select (select id from openchpl.requirement_group_type where name = 'Developer Submission Requirement'),
    '170.523 (t): Health IT Module voluntary standards and implementation specifications updates notices',
	-1
where not exists (
    select *
	from openchpl.additional_requirement_type
    where name = '170.523 (t): Health IT Module voluntary standards and implementation specifications updates notices'
);

--new requirement types
insert into openchpl.additional_nonconformity_type (name, removed, last_modified_user)
select '170.523 (m)(1): Adaptations and updates', false, -1
where not exists (
    select *
	from openchpl.additional_nonconformity_type
	where name = '170.523 (m)(1): Adaptations and updates'
);

insert into openchpl.additional_nonconformity_type (name, removed, last_modified_user)
select '170.523 (m)(2): Adaptations and updates', false, -1
where not exists (
    select *
	from openchpl.additional_nonconformity_type
	where name = '170.523 (m)(2): Adaptations and updates'
);

insert into openchpl.additional_nonconformity_type (name, removed, last_modified_user)
select '170.523 (m)(3): Adaptations and updates', false, -1
where not exists (
    select *
	from openchpl.additional_nonconformity_type
	where name = '170.523 (m)(3): Adaptations and updates'
);

insert into openchpl.additional_nonconformity_type (name, removed, last_modified_user)
select '170.523 (m)(4): Adaptations and updates', false, -1
where not exists (
    select *
	from openchpl.additional_nonconformity_type
	where name = '170.523 (m)(4): Adaptations and updates'
);

insert into openchpl.additional_nonconformity_type (name, removed, last_modified_user)
select '170.523 (m)(5): Adaptations and updates', false, -1
where not exists (
    select *
	from openchpl.additional_nonconformity_type
	where name = '170.523 (m)(5): Adaptations and updates'
);

insert into openchpl.additional_nonconformity_type (name, removed, last_modified_user)
select '170.523 (t): Health IT Module voluntary standards and implementation specifications updates notices', false, -1
where not exists (
    select *
	from openchpl.additional_nonconformity_type
	where name = '170.523 (t): Health IT Module voluntary standards and implementation specifications updates notices'
);
--COLUMNS TO BE DROPPED IN THE FUTURE
--surveillance_requirement.type_id
--surveillance_requirement.certification_criterion_id
--surveillance_requirement.requirement
--surveillance_nonconformity.certification_criterion_id
--surveillance_nonconformity.nonconformity_type
