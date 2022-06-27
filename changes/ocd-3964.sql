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
    parent_attestation_id bigint,
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
    CONSTRAINT parent_attestation_fk FOREIGN KEY (parent_attestation_id)
	    REFERENCES openchpl.attestation (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE restrict,
    CONSTRAINT when_valid_response_fk FOREIGN KEY (when_valid_response_id)
	    REFERENCES openchpl.valid_response (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE restrict,
	CONSTRAINT attestation_period_fk FOREIGN KEY (attestation_period_id)
	    REFERENCES openchpl.attestation (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE restrict
);

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

---------  Add the table to support dependent attestations  ---------
  /*
create table if not exists openchpl.dependent_attestation_form_item (
    id bigserial not null,
    attestation_form_item_id bigint not null,
    when_valid_response_id bigint not null,
    child_attestation_id bigint not null,
    sort_order bigint not null,
    required boolean not null default true,
    creation_date timestamp NOT NULL DEFAULT now(),
	last_modified_date timestamp NOT NULL DEFAULT now(),
	last_modified_user int8 NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT dependent_attestation_form_item_pk PRIMARY KEY (id),
	CONSTRAINT attestation_form_item_fk FOREIGN KEY (attestation_form_item_id)
	    REFERENCES openchpl.attestation_form_item (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE restrict,
    CONSTRAINT when_valid_response_fk FOREIGN KEY (when_valid_response_id)
	    REFERENCES openchpl.valid_response (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE restrict,
    CONSTRAINT child_attestation_fk FOREIGN KEY (child_attestation_id)
	    REFERENCES openchpl.attestation (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE restrict);
*/  
---------  Add the Dependent Attestations  ---------
insert into openchpl.attestation_form_item (attestation_period_id, attestation_id, when_valid_response_id, parent_attestation_id, sort_order, required, last_modified_user)
select
	(select id from openchpl.attestation_period where description = 'Second Period'),
    (select id from openchpl.attestation where description = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program.'),
    (select id from openchpl.valid_response where response = 'Noncompliant'),
    (select id from openchpl.attestation where description = 'We attest to compliance with the Information Blocking Condition of Certification requirement described in [45 CFR 170.401](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.401).'),
    1,
    false,
    -1
where not exists
    (select * 
    from openchpl.attestation_form_item
    where attestation_period_id = (select id from openchpl.attestation_period where description = 'Second Period') 
    and attestation_id = (select id from openchpl.attestation where description = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program.')
    and when_valid_response_id = (select id from openchpl.valid_response where response = 'Noncompliant')
    and parent_attestation_id = 
    	(select id from openchpl.attestation 
		where description ='We attest to compliance with the Information Blocking Condition of Certification requirement described in [45 CFR 170.401](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.401).'));
    			
insert into openchpl.attestation_form_item (attestation_period_id, attestation_id, when_valid_response_id, parent_attestation_id, sort_order, required, last_modified_user)
select
	(select id from openchpl.attestation_period where description = 'Second Period'),
    (select id from openchpl.attestation where description = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program.'),
    (select id from openchpl.valid_response where response = 'Noncompliant'),
    (select id from openchpl.attestation where description = 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in [45 CFR 170.402](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.402).'),
    1,
    false,
    -1
where not exists
    (select * 
    from openchpl.attestation_form_item
    where attestation_period_id = (select id from openchpl.attestation_period where description = 'Second Period') 
    and attestation_id = (select id from openchpl.attestation where description = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program.')
    and when_valid_response_id = (select id from openchpl.valid_response where response = 'Noncompliant')
    and parent_attestation_id = 
    	(select id from openchpl.attestation 
		where description ='We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in [45 CFR 170.402](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.402).'));

			
insert into openchpl.attestation_form_item (attestation_period_id, attestation_id, when_valid_response_id, parent_attestation_id, sort_order, required, last_modified_user)
select
	(select id from openchpl.attestation_period where description = 'Second Period'),
    (select id from openchpl.attestation where description = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program.'),
    (select id from openchpl.valid_response where response = 'Noncompliant'),
    (select id from openchpl.attestation where description = 'We attest to compliance with the Communications Condition and Maintenance of Certification requirements described in [45 CFR 170.403](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.403).'),
    1,
    false,
    -1
where not exists
    (select * 
    from openchpl.attestation_form_item
    where attestation_period_id = (select id from openchpl.attestation_period where description = 'Second Period') 
    and attestation_id = (select id from openchpl.attestation where description = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program.')
    and when_valid_response_id = (select id from openchpl.valid_response where response = 'Noncompliant')
    and parent_attestation_id = 
    	(select id from openchpl.attestation 
		where description ='We attest to compliance with the Communications Condition and Maintenance of Certification requirements described in [45 CFR 170.403](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.403).'));
	
insert into openchpl.attestation_form_item (attestation_period_id, attestation_id, when_valid_response_id, parent_attestation_id, sort_order, required, last_modified_user)
select
	(select id from openchpl.attestation_period where description = 'Second Period'),
    (select id from openchpl.attestation where description = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program.'),
    (select id from openchpl.valid_response where response = 'Noncompliant'),
    (select id from openchpl.attestation where description = 'We attest to compliance with the Application Programming Interfaces (APIs) Condition and Maintenance of Certification requirements described in [45 CFR 170.404](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.404).'),
    1,
    false,
    -1
where not exists
    (select * 
    from openchpl.attestation_form_item
    where attestation_period_id = (select id from openchpl.attestation_period where description = 'Second Period') 
    and attestation_id = (select id from openchpl.attestation where description = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program.')
    and when_valid_response_id = (select id from openchpl.valid_response where response = 'Noncompliant')
    and parent_attestation_id = 
    	(select id from openchpl.attestation 
		where description ='We attest to compliance with the Application Programming Interfaces (APIs) Condition and Maintenance of Certification requirements described in [45 CFR 170.404](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.404).'));
    			
insert into openchpl.attestation_form_item (attestation_period_id, attestation_id, when_valid_response_id, parent_attestation_id, sort_order, required, last_modified_user)
select
	(select id from openchpl.attestation_period where description = 'Second Period'),
    (select id from openchpl.attestation where description = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program.'),
    (select id from openchpl.valid_response where response = 'Noncompliant'),
    (select id from openchpl.attestation where description = 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in [45 CFR 170.405](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.405).'),
    1,
    false,
    -1
where not exists
    (select * 
    from openchpl.attestation_form_item
    where attestation_period_id = (select id from openchpl.attestation_period where description = 'Second Period') 
    and attestation_id = (select id from openchpl.attestation where description = 'For a selection of "Noncompliant", please indicate the status of a Corrective Action Plan (CAP) under the Certification Program.')
    and when_valid_response_id = (select id from openchpl.valid_response where response = 'Noncompliant')
    and parent_attestation_id = 
    	(select id from openchpl.attestation 
		where description ='We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in [45 CFR 170.405](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.405).'));
