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
select 'Annual Real World Testing Results', false, -1
where not exists (
    select * 
    from openchpl.additional_nonconformity_type
    where name = 'Annual Real World Testing Results'
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

create or replace view openchpl.nonconformity_type as  
	select certification_criterion_id as id, certification_edition_id, number, title, removed, 'CRITERION' as classification
	from openchpl.certification_criterion
	where certification_edition_id in (3,2)
	union
	select id, null, name, null, removed, 'REQUIREMENT'
	from openchpl.additional_nonconformity_type;
