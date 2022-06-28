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
    section_heading_id bigint not null,
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







---------  Change the existing datamodel to updated model  ---------

alter table if exists openchpl.attestation_valid_response rename to valid_response;
alter table if exists openchpl.attestation_valid_response_map rename constraint attestation_form_pk to attestation_valid_response_map_pk;

alter table if exists openchpl.attestation_form rename to attestation_valid_response_map;
alter table if exists openchpl.attestation_valid_response_map rename constraint attestation_form_pk to attestation_valid_response_map_pk;

alter table openchpl.attestation alter column attestation_condition_id drop not null;

alter table openchpl.attestation_valid_response_map rename column attestation_valid_response_id to valid_response_id;

create table if not exists openchpl.attestation_form_item (
    id bigserial not null,
    attestation_period_id bigint not null,
    attestation_id bigint not null,
    parent_attestation_form_item_id bigint,
    when_valid_response_id bigint,
    sort_order bigint not null,
    required boolean not null default true,
    creation_date timestamp NOT NULL DEFAULT now(),
	last_modified_date timestamp NOT NULL DEFAULT now(),
	last_modified_user int8 NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT attestation_form_item_pk PRIMARY KEY (id),
	CONSTRAINT attestation_fk FOREIGN KEY (attestation_id)
	    REFERENCES openchpl.attestation (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE restrict,
    CONSTRAINT when_valid_response_fk FOREIGN KEY (when_valid_response_id)
	    REFERENCES openchpl.valid_response (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE restrict,
	CONSTRAINT attestation_period_fk FOREIGN KEY (attestation_period_id)
	    REFERENCES openchpl.attestation (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE restrict
);

alter table openchpl.attestation_form_item
drop constraint if exists parent_attestation_form_item_fk;

alter table openchpl.attestation_form_item
add constraint parent_attestation_form_item_fk FOREIGN KEY (parent_attestation_form_item_id)
	    REFERENCES openchpl.attestation_form_id (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE restrict;

insert into openchpl.attestation_form_item (attestation_period_id, attestation_id, sort_order, last_modified_user)
select 
	(select id from openchpl.attestation_period where description = 'First Period'),
	id,
	sort_order,
	-1
from openchpl.attestation a
where not exists 
    (select *
    from openchpl.attestation_form_item f
    where f.attestation_id = a.id
    and f.attestation_period_id = (select id from openchpl.attestation_period where description = 'First Period'));

   
---------  Copy the First Attestation Period's Form for the Second Attestestation Period
insert into openchpl.attestation_form_item (attestation_id, attestation_period_id, sort_order, last_modified_user) 
select attestation_id, 
    (select id from openchpl.attestation_period where description = 'Second Period'),
    sort_order,    
    -1
from openchpl.attestation_form_item
where attestation_period_id = (select id from openchpl.attestation_period where description = 'First Period')
except
select attestation_id, 
    (select id from openchpl.attestation_period where description = 'Second Period'),
    sort_order,
    -1
from openchpl.attestation_form_item
where attestation_period_id = (select id from openchpl.attestation_period where description = 'Second Period');

---------  Add the new Attestation (dependent) and Responses  ---------
insert into openchpl.attestation (description, sort_order, last_modified_user)
select 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program.', 
    1,
    -1 
where not exists 
    (select * 
    from openchpl.attestation 
    where description = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program.');

insert into openchpl.valid_response (response, sort_order, last_modified_user)
select 'Not under a CAP', 1, -1
where not exists 
    (select *
    from openchpl.valid_response
    where response = 'Not under a CAP');

insert into openchpl.valid_response (response, sort_order, last_modified_user)
select 'Under an open CAP', 2, -1
where not exists 
    (select *
    from openchpl.valid_response
    where response = 'Under an open CAP');

insert into openchpl.valid_response (response, sort_order, last_modified_user)
select 'Completed a CAP', 3, -1
where not exists 
    (select *
    from openchpl.valid_response
    where response = 'Completed a CAP');

insert into openchpl.attestation_valid_response_map (attestation_id, valid_response_id, last_modified_user)
select
   (select id from openchpl.attestation where description = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program.'),
   (select id from openchpl.valid_response where response = 'Not under a CAP'),
   -1
where not exists 
   (select *
   from openchpl.attestation_valid_response_map
   where attestation_id = (select id from openchpl.attestation where description = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program.')
   and valid_response_id = (select id from openchpl.valid_response where response = 'Not under a CAP'));

insert into openchpl.attestation_valid_response_map (attestation_id, valid_response_id, last_modified_user)
select
   (select id from openchpl.attestation where description = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program.'),
   (select id from openchpl.valid_response where response = 'Under an open CAP'),
   -1
where not exists 
   (select *
   from openchpl.attestation_valid_response_map
   where attestation_id = (select id from openchpl.attestation where description = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program.')
   and valid_response_id = (select id from openchpl.valid_response where response = 'Under an open CAP'));

insert into openchpl.attestation_valid_response_map (attestation_id, valid_response_id, last_modified_user)
select
   (select id from openchpl.attestation where description = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program.'),
   (select id from openchpl.valid_response where response = 'Completed a CAP'),
   -1
where not exists 
   (select *
   from openchpl.attestation_valid_response_map
   where attestation_id = (select id from openchpl.attestation where description = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program.')
   and valid_response_id = (select id from openchpl.valid_response where response = 'Completed a CAP'));

---------  Add the Dependent Attestations  ---------
insert into openchpl.attestation_form_item (attestation_period_id, attestation_id, when_valid_response_id, parent_attestation_form_item_id, sort_order, required, last_modified_user)
select
	(select id from openchpl.attestation_period where description = 'Second Period'),
    (select id from openchpl.attestation where description = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program.'),
    (select id from openchpl.valid_response where response = 'Noncompliant'),
    (select id from openchpl.attestation_form_item 
    	where attestation_id = (select id from openchpl.attestation where description = 'We attest to compliance with the Information Blocking Condition of Certification requirement described in [45 CFR 170.401](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.401).')
    	and attestation_period_id = (select id from openchpl.attestation_period where description = 'Second Period')),
    1,
    false,
    -1
where not exists
    (select * 
    from openchpl.attestation_form_item
    where attestation_period_id = (select id from openchpl.attestation_period where description = 'Second Period') 
    and attestation_id = (select id from openchpl.attestation where description = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program.')
    and when_valid_response_id = (select id from openchpl.valid_response where response = 'Noncompliant')
    and parent_attestation_form_item_id = 
    	(select id from openchpl.attestation_form_item
		where attestation_id = (select id from openchpl.attestation where description ='We attest to compliance with the Information Blocking Condition of Certification requirement described in [45 CFR 170.401](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.401).')
	    and attestation_period_id = (select id from openchpl.attestation_period where description = 'Second Period')));
    			
insert into openchpl.attestation_form_item (attestation_period_id, attestation_id, when_valid_response_id, parent_attestation_form_item_id, sort_order, required, last_modified_user)
select
	(select id from openchpl.attestation_period where description = 'Second Period'),
    (select id from openchpl.attestation where description = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program.'),
    (select id from openchpl.valid_response where response = 'Noncompliant'),
    (select id from openchpl.attestation_form_item
        where attestation_id = (select id from openchpl.attestation where description = 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in [45 CFR 170.402](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.402).')
        and attestation_period_id = (select id from openchpl.attestation_period where description = 'Second Period')),
    1,
    false,
    -1
where not exists
    (select * 
    from openchpl.attestation_form_item
    where attestation_period_id = (select id from openchpl.attestation_period where description = 'Second Period') 
    and attestation_id = (select id from openchpl.attestation where description = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program.')
    and when_valid_response_id = (select id from openchpl.valid_response where response = 'Noncompliant')
    and parent_attestation_form_item_id = 
    	(select id from openchpl.attestation_form_item 
		where attestation_id = (select id from openchpl.attestation where description ='We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in [45 CFR 170.402](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.402).')
	    and attestation_period_id = (select id from openchpl.attestation_period where description = 'Second Period')));

			
insert into openchpl.attestation_form_item (attestation_period_id, attestation_id, when_valid_response_id, parent_attestation_form_item_id, sort_order, required, last_modified_user)
select
	(select id from openchpl.attestation_period where description = 'Second Period'),
    (select id from openchpl.attestation where description = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program.'),
    (select id from openchpl.valid_response where response = 'Noncompliant'),
    (select id from openchpl.attestation_form_item 
        where attestation_id = (select id from openchpl.attestation where description = 'We attest to compliance with the Communications Condition and Maintenance of Certification requirements described in [45 CFR 170.403](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.403).')
        and attestation_period_id = (select id from openchpl.attestation_period where description = 'Second Period')),
    1,
    false,
    -1
where not exists
    (select * 
    from openchpl.attestation_form_item
    where attestation_period_id = (select id from openchpl.attestation_period where description = 'Second Period') 
    and attestation_id = (select id from openchpl.attestation where description = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program.')
    and when_valid_response_id = (select id from openchpl.valid_response where response = 'Noncompliant')
    and parent_attestation_form_item_id = 
    	(select id from openchpl.attestation_form_item 
		where attestation_id = (select id from openchpl.attestation where description ='We attest to compliance with the Communications Condition and Maintenance of Certification requirements described in [45 CFR 170.403](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.403).')
	    and attestation_period_id = (select id from openchpl.attestation_period where description = 'Second Period')));
	
insert into openchpl.attestation_form_item (attestation_period_id, attestation_id, when_valid_response_id, parent_attestation_form_item_id, sort_order, required, last_modified_user)
select
	(select id from openchpl.attestation_period where description = 'Second Period'),
    (select id from openchpl.attestation where description = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program.'),
    (select id from openchpl.valid_response where response = 'Noncompliant'),
    (select id from openchpl.attestation_form_item 
        where attestation_id = (select id from openchpl.attestation where description = 'We attest to compliance with the Application Programming Interfaces (APIs) Condition and Maintenance of Certification requirements described in [45 CFR 170.404](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.404).')
        and attestation_period_id = (select id from openchpl.attestation_period where description = 'Second Period')),
    1,
    false,
    -1
where not exists
    (select * 
    from openchpl.attestation_form_item
    where attestation_period_id = (select id from openchpl.attestation_period where description = 'Second Period') 
    and attestation_id = (select id from openchpl.attestation where description = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program.')
    and when_valid_response_id = (select id from openchpl.valid_response where response = 'Noncompliant')
    and parent_attestation_form_item_id = 
    	(select id from openchpl.attestation_form_item 
		where attestation_id = (select id from openchpl.attestation where description ='We attest to compliance with the Application Programming Interfaces (APIs) Condition and Maintenance of Certification requirements described in [45 CFR 170.404](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.404).')
		and attestation_period_id = (select id from openchpl.attestation_period where description = 'Second Period')));
    			
insert into openchpl.attestation_form_item (attestation_period_id, attestation_id, when_valid_response_id, parent_attestation_form_item_id, sort_order, required, last_modified_user)
select
	(select id from openchpl.attestation_period where description = 'Second Period'),
    (select id from openchpl.attestation where description = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program.'),
    (select id from openchpl.valid_response where response = 'Noncompliant'),
    (select id from openchpl.attestation_form_item 
        where attestation_id = (select id from openchpl.attestation where description = 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in [45 CFR 170.405](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.405).')
        and attestation_period_id = (select id from openchpl.attestation_period where description = 'Second Period')),
    1,
    false,
    -1
where not exists
    (select * 
    from openchpl.attestation_form_item
    where attestation_period_id = (select id from openchpl.attestation_period where description = 'Second Period') 
    and attestation_id = (select id from openchpl.attestation where description = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program.')
    and when_valid_response_id = (select id from openchpl.valid_response where response = 'Noncompliant')
    and parent_attestation_form_item_id = 
    	(select id from openchpl.attestation_form_item 
		where attestation_id = (select id from openchpl.attestation where description ='We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in [45 CFR 170.405](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.405).')
		and attestation_period_id = (select id from openchpl.attestation_period where description = 'Second Period')));
