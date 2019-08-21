insert into openchpl.filter_type (name, last_modified_user)
select 'API Key Usage Report', -1
where not exists
	(select *
	from openchpl.filter_type
	where name = 'API Key Usage Report');