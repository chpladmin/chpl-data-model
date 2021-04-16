alter table openchpl.certification_criterion_attribute
drop column if exists service_base_url_list;

alter table openchpl.certification_criterion_attribute
add column service_base_url_list bool not null default false;

insert into openchpl.certification_criterion_attribute (criterion_id, service_base_url_list, last_modified_user) values (182, true, -1);
