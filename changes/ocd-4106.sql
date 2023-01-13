insert into openchpl.requirement_group_type ("name", last_modified_user)
values ('Inherited Certified Status', -1)
on conflict ("name") do nothing;

insert into openchpl.additional_requirement_type ("name", last_modified_user, requirement_group_type_id)
select 'Inherited Certified Status', -1, (select id from openchpl.requirement_group_type where "name" = 'Inherited Certified Status')
where not exists
 (select * from openchpl.additional_requirement_type where "name" = 'Inherited Certified Status');
