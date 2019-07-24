insert into openchpl.activity_concept (concept, last_modified_user)
select 'COMPLAINT', -1
where not exists
	(select *
	from openchpl.activity_concept
	where concept = 'COMPLAINT');

