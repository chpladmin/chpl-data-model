-- Deployment file for version 20.0.0
--     as of 2021-05-17
-- ./changes/ocd-3594.sql
DROP TABLE IF EXISTS openchpl.job CASCADE;
DROP TABLE IF EXISTS openchpl.job_message CASCADE;
DROP TABLE IF EXISTS openchpl.job_status CASCADE;
DROP TABLE IF EXISTS openchpl.job_type CASCADE;
;
-- ./changes/ocd-3644.sql
alter table openchpl.certification_criterion_attribute
drop column if exists service_base_url_list;

alter table openchpl.certification_criterion_attribute
add column service_base_url_list bool not null default false;

alter table openchpl.certification_result
drop column if exists service_base_url_list cascade;

alter table openchpl.certification_result
add column service_base_url_list varchar(1024);

alter table openchpl.pending_certification_result
drop column if exists service_base_url_list;

alter table openchpl.pending_certification_result
add column service_base_url_list text;

alter table openchpl.pending_certification_result
alter column api_documentation type text,
alter column export_documentation type text,
alter column documentation_url type text,
alter column use_cases type text;

update openchpl.certification_criterion_attribute
set service_base_url_list = true where criterion_id = 182;

insert into openchpl.url_type (name, last_modified_user)
select 'Service Base URL List', -1
where not exists (select * from openchpl.url_type where name = 'Service Base URL List');
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('20.0.0', '2021-05-17', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
