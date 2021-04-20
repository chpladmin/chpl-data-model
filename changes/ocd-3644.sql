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
add column service_base_url_list varchar(1024);

update openchpl.certification_criterion_attribute
set service_base_url_list = true where criterion_id = 182;

insert into openchpl.url_type (name, last_modified_user)
select 'Service Base URL List', -1
where not exists (select * from openchpl.url_type where name = 'Service Base URL List');
