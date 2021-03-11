insert into openchpl.filter_type (name, last_modified_user)
select 'ONC-ATL Report', -1
where not exists (select * from openchpl.filter_type where name = 'ONC-ATL Report');

