create table if not exists openchpl.response_cardinality_type (
    id bigserial not null,
    description text not null,
    creation_date timestamp not null default now(),
	last_modified_date timestamp not null default now(),
	last_modified_user int8 not null ,
	deleted bool not null default false,
	constraint response_cardinality_type_pk primary key (id)
);

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

create table if not exists openchpl.allowed_response (
	id bigserial not null,
    response text not null,
    creation_date timestamp not null default now(),
	last_modified_date timestamp not null default now(),
	last_modified_user int8 not null ,
	deleted bool not null default false,
	constraint allowed_response_pk primary key (id)
);

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

create table if not exists openchpl.form (
	id bigserial not null,
	description text not null,
	creation_date timestamp not null default now(),
	last_modified_date timestamp not null default now(),
	last_modified_user int8 not null ,
	deleted bool not null default false,
	constraint form_pk primary key (id)
);

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

alter table openchpl.form_item
drop constraint if exists parent_form_item_fk;

alter table openchpl.form_item
add constraint parent_form_item_fk FOREIGN KEY (parent_form_item_id)
	    REFERENCES openchpl.form_item (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE restrict;


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
    where r.id = af.attestation_valid_response_id),
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
        where r.id = af.attestation_valid_response_id));

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
------              ADD THE NEW FORM TO THE NEW MODEL                ------
------------------------------------------------------------------------------------
insert into openchpl.form (description, last_modified_user)
select 'Attestation Period 2022-04-01 to 2022-09-30', -1
where not exists (
    select * from openchpl.form where description = 'Attestation Period 2022-04-01 to 2022-09-30'
);

insert into openchpl.question (question, response_cardinality_type_id, last_modified_user)
select 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program. (optional)',
    (select id from openchpl.response_cardinality_type where description = 'Multiple'),
    -1
where not exists (
    select *
    from openchpl.question q
    where q.question = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program. (optional)'
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
select 'Completed a CAP', -1
where not exists (
    select * from openchpl.allowed_response where response = 'Completed a CAP'
);

insert into openchpl.question_allowed_response_map (question_id, allowed_response_id, sort_order, last_modified_user)
select
    (select id from openchpl.question where question = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program. (optional)'),
    (select id from openchpl.allowed_response where response = 'Not under a CAP'),
    1,
    -1
where not exists (
    select *
    from openchpl.question_allowed_response_map
    where question_id = (select id from openchpl.question where question = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program. (optional)')
    and allowed_response_id  = (select id from openchpl.allowed_response where response = 'Not under a CAP'));
   
insert into openchpl.question_allowed_response_map (question_id, allowed_response_id, sort_order, last_modified_user)
select
    (select id from openchpl.question where question = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program. (optional)'),
    (select id from openchpl.allowed_response where response = 'Under an open CAP'),
    1,
    -1
where not exists (
    select *
    from openchpl.question_allowed_response_map
    where question_id = (select id from openchpl.question where question = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program. (optional)')
    and allowed_response_id  = (select id from openchpl.allowed_response where response = 'Under an open CAP'));
   
insert into openchpl.question_allowed_response_map (question_id, allowed_response_id, sort_order, last_modified_user)
select
    (select id from openchpl.question where question = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program. (optional)'),
    (select id from openchpl.allowed_response where response = 'Completed a CAP'),
    1,
    -1
where not exists (
    select *
    from openchpl.question_allowed_response_map
    where question_id = (select id from openchpl.question where question = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program. (optional)')
    and allowed_response_id  = (select id from openchpl.allowed_response where response = 'Completed a CAP'));

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
    (select id from openchpl.question where question = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program. (optional)'),
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
    and question_id = (select id from openchpl.question where question = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program. (optional)')
    and parent_form_item_id = (
        select id 
        from openchpl.form_item 
        where form_id = (select id from openchpl.form where description = 'Attestation Period 2022-04-01 to 2022-09-30')
    	and question_id = (select id from openchpl.question where question = 'We attest to compliance with the Information Blocking Condition of Certification requirement described in [45 CFR 170.401](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.401).'))
    and parent_response_id = (select id from openchpl.allowed_response where response = 'Noncompliant'));
   
insert into openchpl.form_item (form_id, question_id, parent_form_item_id, parent_response_id, sort_order, required, last_modified_user)
select 
    (select id from openchpl.form where description = 'Attestation Period 2022-04-01 to 2022-09-30'),
    (select id from openchpl.question where question = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program. (optional)'),
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
    and question_id = (select id from openchpl.question where question = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program. (optional)')
    and parent_form_item_id = (
        select id 
        from openchpl.form_item 
        where form_id = (select id from openchpl.form where description = 'Attestation Period 2022-04-01 to 2022-09-30')
    	and question_id = (select id from openchpl.question where question = 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in [45 CFR 170.402](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.402).'))
    and parent_response_id = (select id from openchpl.allowed_response where response = 'Noncompliant'));

insert into openchpl.form_item (form_id, question_id, parent_form_item_id, parent_response_id, sort_order, required, last_modified_user)
select 
    (select id from openchpl.form where description = 'Attestation Period 2022-04-01 to 2022-09-30'),
    (select id from openchpl.question where question = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program. (optional)'),
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
    and question_id = (select id from openchpl.question where question = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program. (optional)')
    and parent_form_item_id = (
        select id 
        from openchpl.form_item 
        where form_id = (select id from openchpl.form where description = 'Attestation Period 2022-04-01 to 2022-09-30')
    	and question_id = (select id from openchpl.question where question = 'We attest to compliance with the Communications Condition and Maintenance of Certification requirements described in [45 CFR 170.403](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.403).'))
    and parent_response_id = (select id from openchpl.allowed_response where response = 'Noncompliant'));
   
insert into openchpl.form_item (form_id, question_id, parent_form_item_id, parent_response_id, sort_order, required, last_modified_user)
select 
    (select id from openchpl.form where description = 'Attestation Period 2022-04-01 to 2022-09-30'),
    (select id from openchpl.question where question = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program. (optional)'),
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
    and question_id = (select id from openchpl.question where question = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program. (optional)')
    and parent_form_item_id = (
        select id 
        from openchpl.form_item 
        where form_id = (select id from openchpl.form where description = 'Attestation Period 2022-04-01 to 2022-09-30')
    	and question_id = (select id from openchpl.question where question = 'We attest to compliance with the Application Programming Interfaces (APIs) Condition and Maintenance of Certification requirements described in [45 CFR 170.404](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.404).'))
    and parent_response_id = (select id from openchpl.allowed_response where response = 'Noncompliant'));
   
insert into openchpl.form_item (form_id, question_id, parent_form_item_id, parent_response_id, sort_order, required, last_modified_user)
select 
    (select id from openchpl.form where description = 'Attestation Period 2022-04-01 to 2022-09-30'),
    (select id from openchpl.question where question = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program. (optional)'),
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
    and question_id = (select id from openchpl.question where question = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program. (optional)')
    and parent_form_item_id = (
        select id 
        from openchpl.form_item 
        where form_id = (select id from openchpl.form where description = 'Attestation Period 2022-04-01 to 2022-09-30')
    	and question_id = (select id from openchpl.question where question = 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in [45 CFR 170.405](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.405).'))
    and parent_response_id = (select id from openchpl.allowed_response where response = 'Noncompliant'));
