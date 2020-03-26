insert into openchpl.change_request_type (name, last_modified_user)
select 'Developer Details Change Request', -1
where not exists (select * from openchpl.change_request_type where name = 'Developer Details Change Request');