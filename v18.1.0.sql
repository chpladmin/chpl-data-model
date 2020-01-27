-- Deployment file for version 18.1.0
--     as of 2020-01-27
-- ocd-3224.sql
alter table openchpl.certification_result
drop column if exists attestation_answer cascade,
drop column if exists export_documentation cascade,
drop column if exists documentation_url cascade,
drop column if exists use_cases cascade;

alter table openchpl.certification_result
add column attestation_answer bool,
add column export_documentation varchar(1024),
add column documentation_url varchar(1024),
add column use_cases varchar(1024);

alter table openchpl.pending_certification_result
drop column if exists attestation_answer,
drop column if exists export_documentation,
drop column if exists documentation_url,
drop column if exists use_cases;

alter table openchpl.pending_certification_result
add column attestation_answer bool,
add column export_documentation varchar(1024),
add column documentation_url varchar(1024),
add column use_cases varchar(1024);
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('18.1.0', '2020-01-27', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
