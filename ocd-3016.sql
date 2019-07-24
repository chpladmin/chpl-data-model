insert into openchpl.activity_concept (concept, last_modified_user)
select 'COMPLAINTS', -1
where not exists 
	(select *
	from openchpl.activity_concept
	where concept = 'COMPLAINTS');

