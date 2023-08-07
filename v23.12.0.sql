-- Deployment file for version 23.12.0
--     as of 2023-08-07
-- ./changes/ocd-4242.sql
create table if not exists openchpl.rule (
    id bigserial not null,
    name text not null,
    creation_date timestamp not null default now(),
    last_modified_date timestamp not null default now(),
    last_modified_user bigint not null ,
    deleted bool not null default false,
    constraint rule_pk primary key (id)
);

insert into openchpl.rule (name, last_modified_user)
select '2011', -1
where not exists (select * from openchpl.rule where name = '2011');

insert into openchpl.rule (name, last_modified_user)
select '2014', -1
where not exists (select * from openchpl.rule where name = '2014');

insert into openchpl.rule (name, last_modified_user)
select '2015', -1
where not exists (select * from openchpl.rule where name = '2015');

insert into openchpl.rule (name, last_modified_user)
select 'Cures', -1
where not exists (select * from openchpl.rule where name = 'Cures');

insert into openchpl.rule (name, last_modified_user)
select 'HTI-1', -1
where not exists (select * from openchpl.rule where name = 'HTI-1');

insert into openchpl.rule (name, last_modified_user)
select 'HTI-2', -1
where not exists (select * from openchpl.rule where name = 'HTI-2');

alter table openchpl.test_tool add column if not exists start_day date;

alter table openchpl.test_tool add column if not exists end_day date;

alter table openchpl.test_tool add column if not exists required_day date;

alter table openchpl.test_tool add column if not exists rule_id bigint;

alter table openchpl.test_tool drop constraint if exists rule_fk;
alter table openchpl.test_tool add constraint rule_fk foreign key (rule_id)
    references openchpl.rule (id)
    match simple on update no action on delete restrict;

alter table openchpl.test_tool add column if not exists value text;
update openchpl.test_tool
    set value = name;

alter table openchpl.test_tool add column if not exists regulatory_text_citation text;
;
-- ./changes/ocd-4245.sql
update openchpl.attestation_period
set form_id = 3
where id = 5;

insert into openchpl.attestation_period (period_start, period_end, submission_start, submission_end, description, form_id, last_modified_user)
select '2023-10-01',
    '2024-03-31',
    '2024-04-01',
    '2024-04-30',
    'Fifth Period',
    3,
    -1
where not exists (select * from openchpl.attestation_period where period_start = '2023-10-01' and period_end = '2024-03-31');

insert into openchpl.attestation_period (period_start, period_end, submission_start, submission_end, description, form_id, last_modified_user)
select '2024-04-01',
    '2024-09-30',
    '2024-10-01',
    '2024-10-31',
    'Sixth Period',
    3,
    -1
where not exists (select * from openchpl.attestation_period where period_start = '2024-04-01' and period_end = '2024-09-30');

insert into openchpl.attestation_period (period_start, period_end, submission_start, submission_end, description, form_id, last_modified_user)
select '2024-10-01',
    '2025-03-31',
    '2025-04-01',
    '2025-04-30',
    'Seventh Period',
    3,
    -1
where not exists (select * from openchpl.attestation_period where period_start = '2024-10-01' and period_end = '2025-03-31');

insert into openchpl.attestation_period (period_start, period_end, submission_start, submission_end, description, form_id, last_modified_user)
select '2025-04-01',
    '2025-09-30',
    '2025-10-01',
    '2025-10-31',
    'Eighth Period',
    3,
    -1
where not exists (select * from openchpl.attestation_period where period_start = '2025-04-01' and period_end = '2025-09-30');

insert into openchpl.attestation_period (period_start, period_end, submission_start, submission_end, description, form_id, last_modified_user)
select '2025-10-01',
    '2026-03-31',
    '2026-04-01',
    '2026-04-30',
    'Ninth Period',
    3,
    -1
where not exists (select * from openchpl.attestation_period where period_start = '2025-10-01' and period_end = '2026-03-31');

insert into openchpl.attestation_period (period_start, period_end, submission_start, submission_end, description, form_id, last_modified_user)
select '2026-04-01',
    '2026-09-30',
    '2026-10-01',
    '2026-10-31',
    'Tenth Period',
    3,
    -1
where not exists (select * from openchpl.attestation_period where period_start = '2026-04-01' and period_end = '2026-09-30');

insert into openchpl.attestation_period (period_start, period_end, submission_start, submission_end, description, form_id, last_modified_user)
select '2026-10-01',
    '2027-03-31',
    '2027-04-01',
    '2027-04-30',
    'Eleventh Period',
    3,
    -1
where not exists (select * from openchpl.attestation_period where period_start = '2026-10-01' and period_end = '2027-03-31');

insert into openchpl.attestation_period (period_start, period_end, submission_start, submission_end, description, form_id, last_modified_user)
select '2027-04-01',
    '2027-09-30',
    '2027-10-01',
    '2027-10-31',
    'Twelfth Period',
    3,
    -1
where not exists (select * from openchpl.attestation_period where period_start = '2027-04-01' and period_end = '2027-09-30');

insert into openchpl.attestation_period (period_start, period_end, submission_start, submission_end, description, form_id, last_modified_user)
select '2027-10-01',
    '2028-03-31',
    '2028-04-01',
    '2028-04-30',
    'Thirteenth Period',
    3,
    -1
where not exists (select * from openchpl.attestation_period where period_start = '2027-10-01' and period_end = '2028-03-31');

insert into openchpl.attestation_period (period_start, period_end, submission_start, submission_end, description, form_id, last_modified_user)
select '2028-04-01',
    '2028-09-30',
    '2028-10-01',
    '2028-10-31',
    'Fourteenth Period',
    3,
    -1
where not exists (select * from openchpl.attestation_period where period_start = '2028-04-01' and period_end = '2028-09-30');


;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('23.12.0', '2023-08-07', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
