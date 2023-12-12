-- Deployment file for version 24.4.0
--     as of 2023-12-11
-- ./changes/ocd-4325.sql
-- Remove (Cures Update) from all criteria titles

UPDATE openchpl.certification_criterion
SET title = REPLACE(title, ' (Cures Update)', '');
;
-- ./changes/ocd-4326.sql
-- add to questionable activity trigger

INSERT INTO openchpl.questionable_activity_trigger (name, level, last_modified_user)
SELECT 'Uploaded After Certification Date', 'Listing', -1
WHERE
NOT EXISTS (
	SELECT name FROM openchpl.questionable_activity_trigger WHERE name = 'Uploaded After Certification Date'
);

INSERT INTO openchpl.questionable_activity_trigger (name, level, last_modified_user)
SELECT 'Attested to Removed Certification Criteria', 'Listing', -1
WHERE
NOT EXISTS (
	SELECT name FROM openchpl.questionable_activity_trigger WHERE name = 'Attested to Removed Certification Criteria'
);

INSERT INTO openchpl.questionable_activity_trigger (name, level, last_modified_user)
SELECT 'Expired Test Tool Added', 'Certification Criteria', -1
WHERE
NOT EXISTS (
	SELECT name FROM openchpl.questionable_activity_trigger WHERE name = 'Expired Test Tool Added'
);

INSERT INTO openchpl.questionable_activity_trigger (name, level, last_modified_user)
SELECT 'Expired Functionality Tested Added', 'Certification Criteria', -1
WHERE
NOT EXISTS (
	SELECT name FROM openchpl.questionable_activity_trigger WHERE name = 'Expired Functionality Tested Added'
);

INSERT INTO openchpl.questionable_activity_trigger (name, level, last_modified_user)
SELECT 'Expired Standard Added', 'Certification Criteria', -1
WHERE
NOT EXISTS (
	SELECT name FROM openchpl.questionable_activity_trigger WHERE name = 'Expired Standard Added'
);
;
-- ./changes/ocd-4333.sql
create table if not exists openchpl.standard (
    id bigserial not null,
    rule_id int,
    value text not null,
    regulatory_text_citation text not null,
    additional_information text,
    start_day date,
    end_day date,
    required_day date,
    creation_date timestamp not null default now(),
    last_modified_date timestamp not null default now(),
    last_modified_user bigint not null ,
    deleted bool not null default false,
    constraint standard_pk primary key (id),
    constraint rule_fk foreign key (rule_id)
	    references openchpl.rule (id)
	    match simple on update no action on delete restrict
);
CREATE or replace TRIGGER standard_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.standard FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE or replace TRIGGER standard_timestamp BEFORE UPDATE on openchpl.standard FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();


create table if not exists openchpl.standard_criteria_map (
    id bigserial not null,
    standard_id int not null,
    certification_criterion_id int not null,
    creation_date timestamp not null default now(),
    last_modified_date timestamp not null default now(),
    last_modified_user bigint not null ,
    deleted bool not null default false,
    constraint standard_criteria_map_pk primary key (id),
    constraint standard_fk foreign key (standard_id)
        references openchpl.standard (id)
        match simple on update no action on delete restrict,
    constraint certification_criterion_fk foreign key (certification_criterion_id)
        references openchpl.certification_criterion (certification_criterion_id)
	match simple on update no action on delete restrict
);
CREATE or replace TRIGGER standard_criteria_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.standard_criteria_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE or replace TRIGGER standard_criteria_map_timestamp BEFORE UPDATE on openchpl.standard_criteria_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

create table if not exists openchpl.certification_result_standard (
    id bigserial not null,
    standard_id int not null,
    certification_result_id int not null,
    creation_date timestamp not null default now(),
    last_modified_date timestamp not null default now(),
    last_modified_user bigint not null ,
    deleted bool not null default false,
    constraint certification_result_standard_pk primary key (id),
    constraint standard_fk foreign key (standard_id)
        references openchpl.standard (id)
        match simple on update no action on delete restrict,
    constraint certification_result_fk foreign key (certification_result_id)
        references openchpl.certification_result (certification_result_id)
        match simple on update no action on delete restrict
);
CREATE or replace TRIGGER certification_result_standard_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certification_result_standard FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE or replace TRIGGER certification_result_standard_timestamp BEFORE UPDATE on openchpl.certification_result_standard FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

alter table openchpl.certification_criterion_attribute add column if not exists standard boolean default false;

update openchpl.certification_criterion_attribute cca
set standard = true
where criterion_id in (
	select cc.certification_criterion_id
	from openchpl.certification_criterion cc
	where cc.number like '%.315%');
;
-- ./changes/ocd-4412.sql
INSERT INTO openchpl.cqm_criterion (cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
  SELECT 'CMS314',
	'HIV Viral Suppression',
	'Percentage of patients, regardless of age, diagnosed with HIV prior to or during the first 90 days of the measurement period, with an eligible encounter in the first 240 days of the measurement period, whose last HIV viral load test result was less than 200 copies/mL ',
	'Intermiedate Clinical Outcome',
	'N/A',
	-1,
	(SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v1'),
	(select cqm_criterion_type_id from openchpl.cqm_criterion_type where name = 'Ambulatory'),
	false
  WHERE NOT EXISTS (select * from openchpl.cqm_criterion where cms_ID = 'CMS314');

-- This is necessary to fix the descriuption in the lower envs, where the description was originally cut short due to copy/paste error
UPDATE openchpl.cqm_criterion
SET description = 'Percentage of patients, regardless of age, diagnosed with HIV prior to or during the first 90 days of the measurement period, with an eligible encounter in the first 240 days of the measurement period, whose last HIV viral load test result was less than 200 copies/mL during the measurement period'
WHERE cms_id = 'CMS314';



;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('24.4.0', '2023-12-11', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
