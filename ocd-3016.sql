do $$
	declare row_cnt int;
begin
	row_cnt := count(*) from openchpl.activity_concept;
	perform setval('openchpl.activity_concept_activity_concept_id_seq', row_cnt);

	insert into openchpl.activity_concept (concept, last_modified_user)
	select 'COMPLAINT', -1
	where not exists
	        (select *
	        from openchpl.activity_concept
	        where concept = 'COMPLAINT');
end $$;