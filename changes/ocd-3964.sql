create table if not exists openchpl.response_cardinality_type (
    id bigserial not null,
    description text not null,
    creation_date timestamp not null default now(),
	last_modified_date timestamp not null default now(),
	last_modified_user int8 not null ,
	deleted bool not null default false,
	constraint response_cardinality_type_pk primary key (id)
);
drop trigger if exists response_cardinality_type_audit on openchpl.response_cardinality_type; 
create trigger response_cardinality_type_audit after insert or update or delete on openchpl.response_cardinality_type for each row execute procedure audit.if_modified_func();
drop trigger if exists response_cardinality_type_timestamp on openchpl.response_cardinality_type;
create trigger response_cardinality_type_timestamp before update on openchpl.response_cardinality_type for each row execute procedure openchpl.update_last_modified_date_column();

create table if not exists openchpl.section_heading (
    id bigserial not null,
    name text not null,
    sort_order int8 not null,
    creation_date timestamp not null default now(),
	last_modified_date timestamp not null default now(),
	last_modified_user int8 not null ,
	deleted bool not null default false,
	constraint section_heading_pk primary key (id)
);
drop trigger if exists section_heading_audit on openchpl.section_heading;
create trigger section_heading_audit after insert or update or delete on openchpl.section_heading for each row execute procedure audit.if_modified_func();
drop trigger if exists section_heading_timestamp on openchpl.section_heading;
create trigger section_heading_timestamp before update on openchpl.section_heading for each row execute procedure openchpl.update_last_modified_date_column();

create table if not exists openchpl.question (
    id bigserial not null,
    question text not null,
    response_cardinality_type_id bigint not null,
    section_heading_id bigint,
    creation_date timestamp not null default now(),
	last_modified_date timestamp not null default now(),
	last_modified_user int8 not null ,
	deleted bool not null default false,
	constraint question_pk primary key (id),
	constraint response_cardinality_type_fk foreign key (response_cardinality_type_id)
	    references openchpl.response_cardinality_type (id)
        match simple on update no action on delete restrict,
    constraint section_heading_fk foreign key (section_heading_id)
	    references openchpl.section_heading (id)
        match simple on update no action on delete restrict
);
drop trigger if exists question_audit on openchpl.question;
create trigger question_audit after insert or update or delete on openchpl.question for each row execute procedure audit.if_modified_func();
drop trigger if exists question_timestamp on openchpl.question;
create trigger question_timestamp before update on openchpl.question for each row execute procedure openchpl.update_last_modified_date_column();

create table if not exists openchpl.allowed_response (
	id bigserial not null,
    response text not null,
    creation_date timestamp not null default now(),
	last_modified_date timestamp not null default now(),
	last_modified_user int8 not null ,
	deleted bool not null default false,
	constraint allowed_response_pk primary key (id)
);
drop trigger if exists allowed_response_audit on openchpl.allowed_response;
create trigger allowed_response_audit after insert or update or delete on openchpl.allowed_response for each row execute procedure audit.if_modified_func();
drop trigger if exists allowed_response_timestamp on openchpl.allowed_response;
create trigger allowed_response_timestamp before update on openchpl.allowed_response for each row execute procedure openchpl.update_last_modified_date_column();

create table if not exists openchpl.question_allowed_response_map (
	id bigserial not null,
	question_id bigint not null,
	allowed_response_id bigint not null,
	sort_order int8 not null,
	creation_date timestamp not null default now(),
	last_modified_date timestamp not null default now(),
	last_modified_user int8 not null ,
	deleted bool not null default false,
	constraint question_allowed_response_map_pk primary key (id)
);
drop trigger if exists question_allowed_response_map_audit on openchpl.question_allowed_response_map;
create trigger question_allowed_response_map_audit after insert or update or delete on openchpl.question_allowed_response_map for each row execute procedure audit.if_modified_func();
drop trigger if exists question_allowed_response_map_timestamp on openchpl.question_allowed_response_map;
create trigger question_allowed_response_map_timestamp before update on openchpl.question_allowed_response_map for each row execute procedure openchpl.update_last_modified_date_column();

create table if not exists openchpl.form (
	id bigserial not null,
	description text not null,
	creation_date timestamp not null default now(),
	last_modified_date timestamp not null default now(),
	last_modified_user int8 not null ,
	deleted bool not null default false,
	constraint form_pk primary key (id)
);
drop trigger if exists form_audit on openchpl.form;
create trigger form_audit after insert or update or delete on openchpl.form for each row execute procedure audit.if_modified_func();
drop trigger if exists form_timestamp on openchpl.form;
create trigger form_timestamp before update on openchpl.form for each row execute procedure openchpl.update_last_modified_date_column();


create table if not exists openchpl.form_item (
	id bigserial not null,
	form_id bigint not null,
	question_id bigint not null,
	parent_form_item_id bigint,
	parent_response_id bigint,
	sort_order int8 not null,
	required boolean not null default true,
	creation_date timestamp not null default now(),
	last_modified_date timestamp not null default now(),
	last_modified_user int8 not null ,
	deleted bool not null default false,
	constraint form_item_pk primary key (id),
	constraint question_fk foreign key (question_id)
	    references openchpl.question (id)
        match simple on update no action on delete restrict,
    constraint parent_response_fk foreign key (parent_response_id)
	    references openchpl.allowed_response (id)
        match simple on update no action on delete restrict
);
drop trigger if exists form_item_audit on openchpl.form_item;
create trigger form_item_audit after insert or update or delete on openchpl.form_item for each row execute procedure audit.if_modified_func();
drop trigger if exists form_item_timestamp on openchpl.form_item;
create trigger form_item_timestamp before update on openchpl.form_item for each row execute procedure openchpl.update_last_modified_date_column();


alter table openchpl.form_item
drop constraint if exists parent_form_item_fk;

alter table openchpl.form_item
add constraint parent_form_item_fk foreign key (parent_form_item_id)
	    references openchpl.form_item (id)
        match simple on update no action on delete restrict;

alter table openchpl.attestation_period 
add column if not exists form_id bigint;

alter table openchpl.attestation_period
drop constraint if exists form_fk;

alter table openchpl.attestation_period
add constraint form_fk foreign key (form_id)
	    references openchpl.form (id)
        match simple on update no action on delete restrict;

------------------------------------------------------------------------------------       
------              CONVERT THE EXISTING FORM TO THE NEW MODEL                ------
------------------------------------------------------------------------------------
insert into openchpl.response_cardinality_type (description, last_modified_user) 
select 'Single', -1
where not exists (
    select *
    from openchpl.response_cardinality_type
    where description = 'Single');

insert into openchpl.response_cardinality_type (description, last_modified_user) 
select 'Multiple', -1
where not exists (
    select *
    from openchpl.response_cardinality_type
    where description = 'Multiple');

------------------------------------------------------------------------------------       
   
insert into openchpl.section_heading (name, sort_order, last_modified_user) 
select name, sort_order, -1
from openchpl.attestation_condition ac
where not exists (
    select *
    from openchpl.section_heading sh
    where sh.name = ac.name
);
   
------------------------------------------------------------------------------------       

insert into openchpl.question (question, response_cardinality_type_id, section_heading_id, last_modified_user)
select att.description,
    (select id from openchpl.response_cardinality_type where description = 'Single'),
    (select sh.id 
    from openchpl.attestation_condition ac
        inner join openchpl.section_heading sh
        on ac.name = sh.name
    where ac.id = att.attestation_condition_id),
    -1
from openchpl.attestation att
where not exists (
    select *
    from openchpl.question q
    where q.question = att.description
);

------------------------------------------------------------------------------------       

insert into openchpl.allowed_response (response, last_modified_user) 
select avr.response, -1
from openchpl.attestation_valid_response avr
where not exists (
    select * from openchpl.allowed_response ar where ar.response = avr.response
);

------------------------------------------------------------------------------------

insert into openchpl.question_allowed_response_map (question_id, allowed_response_id, sort_order, last_modified_user)
select 
    (select q.id 
    from openchpl.attestation att
        inner join openchpl.question q
        on att.description = q.question
    where att.id = af.attestation_id),
    (select r.id 
    from openchpl.attestation_valid_response att
        inner join openchpl.allowed_response r
        on att.response = r.response
    where att.id = af.attestation_valid_response_id),
    (select sort_order
    from openchpl.attestation_valid_response avr
    where id = af.attestation_valid_response_id),
    -1
from openchpl.attestation_form af
where not exists (
	select *
	from openchpl.question_allowed_response_map qarm
	where qarm.question_id = (
        select q.id 
        from openchpl.attestation att
            inner join openchpl.question q
            on att.description = q.question
        where att.id = af.attestation_id)
    and qarm.allowed_response_id = (
        select r.id 
        from openchpl.attestation_valid_response att
            inner join openchpl.allowed_response r
            on att.response = r.response
        where att.id = af.attestation_valid_response_id));

------------------------------------------------------------------------------------
       
insert into openchpl.form (description, last_modified_user)
select 'Attestation Period 2020-06-30 to 2022-03-31', -1
where not exists (
    select * from openchpl.form where description = 'Attestation Period 2020-06-30 to 2022-03-31'
);

------------------------------------------------------------------------------------

insert into openchpl.form_item (form_id, question_id, sort_order, last_modified_user)
select distinct
    (select id from openchpl.form where description = 'Attestation Period 2020-06-30 to 2022-03-31'),
    (select q.id
    from openchpl.question q 
        inner join openchpl.attestation att_a
        on q.question = att_a.description 
    where att_a.id = att.id),
    att.sort_order,
    -1
from openchpl.attestation att
where not exists (
	select *
	from openchpl.form_item
	where form_id = (select id from openchpl.form where description = 'Attestation Period 2020-06-30 to 2022-03-31')
	and question_id = (
	    select q.id
        from openchpl.question q 
            inner join openchpl.attestation att_b
            on q.question = att_b.description 
        where att_b.id = att.id));

------------------------------------------------------------------------------------

update openchpl.attestation_period
set form_id = (select id from openchpl.form where description = 'Attestation Period 2020-06-30 to 2022-03-31')
where description = 'First Period';
       
------------------------------------------------------------------------------------       
------              ADD THE NEW FORM TO THE NEW MODEL                ------
------------------------------------------------------------------------------------
insert into openchpl.form (description, last_modified_user)
select 'Attestation Period 2022-04-01 to 2022-09-30', -1
where not exists (
    select * from openchpl.form where description = 'Attestation Period 2022-04-01 to 2022-09-30'
);

insert into openchpl.question (question, response_cardinality_type_id, last_modified_user)
select 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program. (optional - check all that apply)',
    (select id from openchpl.response_cardinality_type where description = 'Multiple'),
    -1
where not exists (
    select *
    from openchpl.question q
    where q.question = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program. (optional - check all that apply)'
);

insert into openchpl.allowed_response (response, last_modified_user) 
select 'Not under a CAP', -1
where not exists (
    select * from openchpl.allowed_response where response = 'Not under a CAP'
);
       
insert into openchpl.allowed_response (response, last_modified_user) 
select 'Under an open CAP', -1
where not exists (
    select * from openchpl.allowed_response where response = 'Under an open CAP'
);

insert into openchpl.allowed_response (response, last_modified_user) 
select 'Completed a CAP during the specified Attestation Period', -1
where not exists (
    select * from openchpl.allowed_response where response = 'Completed a CAP during the specified Attestation Period'
);

insert into openchpl.question_allowed_response_map (question_id, allowed_response_id, sort_order, last_modified_user)
select
    (select id from openchpl.question where question = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program. (optional - check all that apply)'),
    (select id from openchpl.allowed_response where response = 'Not under a CAP'),
    1,
    -1
where not exists (
    select *
    from openchpl.question_allowed_response_map
    where question_id = (select id from openchpl.question where question = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program. (optional - check all that apply)')
    and allowed_response_id  = (select id from openchpl.allowed_response where response = 'Not under a CAP'));
   
insert into openchpl.question_allowed_response_map (question_id, allowed_response_id, sort_order, last_modified_user)
select
    (select id from openchpl.question where question = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program. (optional - check all that apply)'),
    (select id from openchpl.allowed_response where response = 'Under an open CAP'),
    2,
    -1
where not exists (
    select *
    from openchpl.question_allowed_response_map
    where question_id = (select id from openchpl.question where question = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program. (optional - check all that apply)')
    and allowed_response_id  = (select id from openchpl.allowed_response where response = 'Under an open CAP'));
   
insert into openchpl.question_allowed_response_map (question_id, allowed_response_id, sort_order, last_modified_user)
select
    (select id from openchpl.question where question = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program. (optional - check all that apply)'),
    (select id from openchpl.allowed_response where response = 'Completed a CAP during the specified Attestation Period'),
    3,
    -1
where not exists (
    select *
    from openchpl.question_allowed_response_map
    where question_id = (select id from openchpl.question where question = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program. (optional - check all that apply)')
    and allowed_response_id  = (select id from openchpl.allowed_response where response = 'Completed a CAP during the specified Attestation Period'));

----  For the second period form items, copy the first period form items, but attach to second period form table.
----  Then add the subordinate questions...
insert into openchpl.form_item (form_id, question_id, sort_order, last_modified_user)
select 
    (select id from openchpl.form where description = 'Attestation Period 2022-04-01 to 2022-09-30'),
    question_id,
    sort_order,
    -1
from openchpl.form_item fi
where form_id = (select id from openchpl.form where description = 'Attestation Period 2020-06-30 to 2022-03-31')
and not exists (
	select * 
	from openchpl.form_item
	where form_id = (select id from openchpl.form where description = 'Attestation Period 2022-04-01 to 2022-09-30')
	and question_id = fi.question_id
);
   
---- Add the new subordinate questions to the form
insert into openchpl.form_item (form_id, question_id, parent_form_item_id, parent_response_id, sort_order, required, last_modified_user)
select 
    (select id from openchpl.form where description = 'Attestation Period 2022-04-01 to 2022-09-30'),
    (select id from openchpl.question where question = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program. (optional - check all that apply)'),
    (select id 
    from openchpl.form_item 
    where form_id = (select id from openchpl.form where description = 'Attestation Period 2022-04-01 to 2022-09-30')
    and question_id = (select id from openchpl.question where question = 'We attest to compliance with the Information Blocking Condition of Certification requirement described in [45 CFR 170.401](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.401).')),
    (select id from openchpl.allowed_response where response = 'Noncompliant'),
    1,
    false,
    -1
where not exists (
	select *
	from openchpl.form_item
    where form_id = (select id from openchpl.form where description = 'Attestation Period 2022-04-01 to 2022-09-30')
    and question_id = (select id from openchpl.question where question = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program. (optional - check all that apply)')
    and parent_form_item_id = (
        select id 
        from openchpl.form_item 
        where form_id = (select id from openchpl.form where description = 'Attestation Period 2022-04-01 to 2022-09-30')
    	and question_id = (select id from openchpl.question where question = 'We attest to compliance with the Information Blocking Condition of Certification requirement described in [45 CFR 170.401](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.401).'))
    and parent_response_id = (select id from openchpl.allowed_response where response = 'Noncompliant'));
   
insert into openchpl.form_item (form_id, question_id, parent_form_item_id, parent_response_id, sort_order, required, last_modified_user)
select 
    (select id from openchpl.form where description = 'Attestation Period 2022-04-01 to 2022-09-30'),
    (select id from openchpl.question where question = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program. (optional - check all that apply)'),
    (select id 
    from openchpl.form_item 
    where form_id = (select id from openchpl.form where description = 'Attestation Period 2022-04-01 to 2022-09-30')
    and question_id = (select id from openchpl.question where question = 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in [45 CFR 170.402](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.402).')),
    (select id from openchpl.allowed_response where response = 'Noncompliant'),
    1,
    false,
    -1
where not exists (
	select *
	from openchpl.form_item
    where form_id = (select id from openchpl.form where description = 'Attestation Period 2022-04-01 to 2022-09-30')
    and question_id = (select id from openchpl.question where question = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program. (optional - check all that apply)')
    and parent_form_item_id = (
        select id 
        from openchpl.form_item 
        where form_id = (select id from openchpl.form where description = 'Attestation Period 2022-04-01 to 2022-09-30')
    	and question_id = (select id from openchpl.question where question = 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in [45 CFR 170.402](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.402).'))
    and parent_response_id = (select id from openchpl.allowed_response where response = 'Noncompliant'));

insert into openchpl.form_item (form_id, question_id, parent_form_item_id, parent_response_id, sort_order, required, last_modified_user)
select 
    (select id from openchpl.form where description = 'Attestation Period 2022-04-01 to 2022-09-30'),
    (select id from openchpl.question where question = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program. (optional - check all that apply)'),
    (select id 
    from openchpl.form_item 
    where form_id = (select id from openchpl.form where description = 'Attestation Period 2022-04-01 to 2022-09-30')
    and question_id = (select id from openchpl.question where question = 'We attest to compliance with the Communications Condition and Maintenance of Certification requirements described in [45 CFR 170.403](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.403).')),
    (select id from openchpl.allowed_response where response = 'Noncompliant'),
    1,
    false,
    -1
where not exists (
	select *
	from openchpl.form_item
    where form_id = (select id from openchpl.form where description = 'Attestation Period 2022-04-01 to 2022-09-30')
    and question_id = (select id from openchpl.question where question = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program. (optional - check all that apply)')
    and parent_form_item_id = (
        select id 
        from openchpl.form_item 
        where form_id = (select id from openchpl.form where description = 'Attestation Period 2022-04-01 to 2022-09-30')
    	and question_id = (select id from openchpl.question where question = 'We attest to compliance with the Communications Condition and Maintenance of Certification requirements described in [45 CFR 170.403](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.403).'))
    and parent_response_id = (select id from openchpl.allowed_response where response = 'Noncompliant'));
   
insert into openchpl.form_item (form_id, question_id, parent_form_item_id, parent_response_id, sort_order, required, last_modified_user)
select 
    (select id from openchpl.form where description = 'Attestation Period 2022-04-01 to 2022-09-30'),
    (select id from openchpl.question where question = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program. (optional - check all that apply)'),
    (select id 
    from openchpl.form_item 
    where form_id = (select id from openchpl.form where description = 'Attestation Period 2022-04-01 to 2022-09-30')
    and question_id = (select id from openchpl.question where question = 'We attest to compliance with the Application Programming Interfaces (APIs) Condition and Maintenance of Certification requirements described in [45 CFR 170.404](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.404).')),
    (select id from openchpl.allowed_response where response = 'Noncompliant'),
    1,
    false,
    -1
where not exists (
	select *
	from openchpl.form_item
    where form_id = (select id from openchpl.form where description = 'Attestation Period 2022-04-01 to 2022-09-30')
    and question_id = (select id from openchpl.question where question = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program. (optional - check all that apply)')
    and parent_form_item_id = (
        select id 
        from openchpl.form_item 
        where form_id = (select id from openchpl.form where description = 'Attestation Period 2022-04-01 to 2022-09-30')
    	and question_id = (select id from openchpl.question where question = 'We attest to compliance with the Application Programming Interfaces (APIs) Condition and Maintenance of Certification requirements described in [45 CFR 170.404](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.404).'))
    and parent_response_id = (select id from openchpl.allowed_response where response = 'Noncompliant'));
   
insert into openchpl.form_item (form_id, question_id, parent_form_item_id, parent_response_id, sort_order, required, last_modified_user)
select 
    (select id from openchpl.form where description = 'Attestation Period 2022-04-01 to 2022-09-30'),
    (select id from openchpl.question where question = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program. (optional - check all that apply)'),
    (select id 
    from openchpl.form_item 
    where form_id = (select id from openchpl.form where description = 'Attestation Period 2022-04-01 to 2022-09-30')
    and question_id = (select id from openchpl.question where question = 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in [45 CFR 170.405](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.405).')),
    (select id from openchpl.allowed_response where response = 'Noncompliant'),
    1,
    false,
    -1
where not exists (
	select *
	from openchpl.form_item
    where form_id = (select id from openchpl.form where description = 'Attestation Period 2022-04-01 to 2022-09-30')
    and question_id = (select id from openchpl.question where question = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program. (optional - check all that apply)')
    and parent_form_item_id = (
        select id 
        from openchpl.form_item 
        where form_id = (select id from openchpl.form where description = 'Attestation Period 2022-04-01 to 2022-09-30')
    	and question_id = (select id from openchpl.question where question = 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in [45 CFR 170.405](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.405).'))
    and parent_response_id = (select id from openchpl.allowed_response where response = 'Noncompliant'));

update openchpl.attestation_period
set form_id = (select id from openchpl.form where description = 'Attestation Period 2022-04-01 to 2022-09-30')
where description = 'Second Period';

------------------------------------------------------------------------------------       
------     CONVERT DEVELOPER ATTESTATIONS TO SUPPORT MULTIPLE RESPONSES       ------
------------------------------------------------------------------------------------

create table if not exists openchpl.attestation_submission (
	id bigserial not null,
	developer_id bigint not null,
	attestation_period_id bigint not null,
	signature text not null,
	signature_email text not null,
	creation_date timestamp not null default now(),
	last_modified_date timestamp not null default now(),
	last_modified_user bigint not null,
	deleted bool not null default false,
	drop_developer_attestation_submission_id bigint,
	constraint attestation_submission_pk primary key (id),
	constraint developer_id_fk foreign key (developer_id)
        references openchpl.vendor (vendor_id) match full
        on update cascade on delete restrict,
	constraint attestation_period_id_fk foreign key (attestation_period_id)
        references openchpl.attestation_period (id) match full
        on update cascade on delete restrict
);
drop trigger if exists attestation_submission_audit on openchpl.attestation_submission;
create trigger attestation_submission_audit after insert or update or delete on openchpl.attestation_submission for each row execute procedure audit.if_modified_func();
drop trigger if exists attestation_submission_timestamp on openchpl.attestation_submission;
create trigger attestation_submission_timestamp before update on openchpl.attestation_submission for each row execute procedure openchpl.update_last_modified_date_column();

create table if not exists openchpl.attestation_submission_response (
	id bigserial not null,
	attestation_submission_id bigint not null,
	response_id bigint not null,
	form_item_id bigint not null,
	creation_date timestamp not null default now(),
	last_modified_date timestamp not null default now(),
	last_modified_user bigint not null,
	deleted bool not null default false,
	constraint attestation_submission_response_pk primary key (id),
	constraint attestation_submission_fk foreign key (attestation_submission_id)
        references openchpl.attestation_submission (id) match full
        on update cascade on delete restrict,
	constraint response_fk foreign key (response_id)
        references openchpl.allowed_response (id) match full
        on update cascade on delete restrict,
   constraint form_item_fk foreign key (form_item_id)
        references openchpl.form_item (id) match full
        on update cascade on delete restrict
);
drop trigger if exists attestation_submission_response_audit on openchpl.attestation_submission_response;
create trigger attestation_submission_response_audit after insert or update or delete on openchpl.attestation_submission_response for each row execute procedure audit.if_modified_func();
drop trigger if exists attestation_submission_response_timestamp on openchpl.attestation_submission_response;
create trigger attestation_submission_response_timestamp before update on openchpl.attestation_submission_response for each row execute procedure openchpl.update_last_modified_date_column();

insert into openchpl.attestation_submission (developer_id, attestation_period_id, signature, signature_email, last_modified_user, deleted, drop_developer_attestation_submission_id) 
select developer_id, attestation_period_id, signature, signature_email, last_modified_user, deleted, id
from openchpl.developer_attestation_submission das
where not exists (
	select *
	from openchpl.attestation_submission
	where developer_id = das.developer_id
	and attestation_period_id = das.attestation_period_id
	and deleted = das.deleted
);

insert into openchpl.attestation_submission_response (attestation_submission_id, response_id, form_item_id, last_modified_user, deleted)
select 
	(select id from openchpl.attestation_submission where drop_developer_attestation_submission_id = dar.developer_attestation_submission_id),
	(select ar.id 
	from openchpl.allowed_response ar
		inner join openchpl.attestation_valid_response avr
		on ar.response = avr.response 
	where avr.id = dar.attestation_valid_response_id),
	(select fi.id
	from openchpl.form f
	    inner join openchpl.form_item fi
	    	on f.id = fi.form_id 
	    inner join openchpl.question q
	        on fi.question_id = q.id
	    inner join openchpl.attestation a
	        on q.question = a.description
	    inner join openchpl.attestation_period ap
	    	on ap.form_id = f.id
	 where ap.id = 1
	 and a.id = dar.attestation_id),
	 dar.last_modified_user,
	 dar.deleted 
from openchpl.developer_attestation_response dar
where not exists (
	select *
	from openchpl.attestation_submission_response
	where attestation_submission_id = (select id from openchpl.attestation_submission where drop_developer_attestation_submission_id = dar.developer_attestation_submission_id)
	and response_id = (
		select ar.id 
		from openchpl.allowed_response ar
			inner join openchpl.attestation_valid_response avr
			on ar.response = avr.response 
		where avr.id = dar.attestation_valid_response_id)
	and form_item_id = (
	    select fi.id
		from openchpl.form f
	    	inner join openchpl.form_item fi
	    		on f.id = fi.form_id 
		    inner join openchpl.question q
		        on fi.question_id = q.id
		    inner join openchpl.attestation a
		        on q.question = a.description
		    inner join openchpl.attestation_period ap
		    	on ap.form_id = f.id
	 	where ap.id = 1
	 	and a.id = dar.attestation_id)
	 and deleted = dar.deleted);
	 
------------------------------------------------------------------------------------       
------     CONVERT CHANGE REQUEST ATTESTATIONS TO SUPPORT MULTIPLE RESPONSES       ------
------------------------------------------------------------------------------------

create table if not exists openchpl.change_request_attestation_submission_response (
	id bigserial not null,
	change_request_attestation_submission_id bigint not null,
	response_id bigint not null,
	form_item_id bigint not null,
	creation_date timestamp not null default now(),
	last_modified_date timestamp not null default now(),
	last_modified_user bigint not null,
	deleted bool not null default false,
	constraint change_request_attestation_submission_response_pk primary key (id),
	constraint change_request_attestation_submission_fk foreign key (change_request_attestation_submission_id)
        references openchpl.change_request_attestation_submission (id) match full
        on update cascade on delete restrict,
	constraint response_fk foreign key (response_id)
        references openchpl.allowed_response (id) match full
        on update cascade on delete restrict,
   constraint form_item_fk foreign key (form_item_id)
        references openchpl.form_item (id) match full
        on update cascade on delete restrict
);
drop trigger if exists change_request_attestation_submission_response_audit on openchpl.change_request_attestation_submission_response;
create trigger change_request_attestation_submission_response_audit after insert or update or delete on openchpl.change_request_attestation_submission_response for each row execute procedure audit.if_modified_func();
drop trigger if exists change_request_attestation_submission_response_timestamp on openchpl.change_request_attestation_submission_response;
create trigger change_request_attestation_submission_response_timestamp before update on openchpl.change_request_attestation_submission_response for each row execute procedure openchpl.update_last_modified_date_column();

insert into openchpl.change_request_attestation_submission_response (change_request_attestation_submission_id, response_id, form_item_id, last_modified_user, deleted)
select 
	crar.change_request_attestation_submission_id,
	(select ar.id 
	from openchpl.allowed_response ar
		inner join openchpl.attestation_valid_response avr
		on ar.response = avr.response 
	where avr.id = crar.attestation_valid_response_id),
	-- This is a little hard coded
	(select fi.id
	from openchpl.form f
	    inner join openchpl.form_item fi
	    	on f.id = fi.form_id 
	    inner join openchpl.question q
	        on fi.question_id = q.id
	    inner join openchpl.attestation a
	        on q.question = a.description
	    inner join openchpl.attestation_period ap
	    	on ap.form_id = f.id
	 where ap.id = 1
	 and a.id = crar.attestation_id),
	 crar.last_modified_user,
	 crar.deleted 
from openchpl.change_request_attestation_response crar
where not exists (
	select *
	from openchpl.change_request_attestation_submission_response
	where change_request_attestation_submission_id = crar.change_request_attestation_submission_id
	and response_id = (
		select ar.id 
		from openchpl.allowed_response ar
			inner join openchpl.attestation_valid_response avr
			on ar.response = avr.response 
		where avr.id = crar.attestation_valid_response_id)
	and form_item_id = (
	    select fi.id
		from openchpl.form f
	    	inner join openchpl.form_item fi
	    		on f.id = fi.form_id 
		    inner join openchpl.question q
		        on fi.question_id = q.id
		    inner join openchpl.attestation a
		        on q.question = a.description
		    inner join openchpl.attestation_period ap
		    	on ap.form_id = f.id
	 	where ap.id = 1
	 	and a.id = crar.attestation_id)
	 and deleted = crar.deleted);

