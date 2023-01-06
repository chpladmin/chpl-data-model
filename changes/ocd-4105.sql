do $$
declare
  	m_requirement_count integer := 0;
  	m_nonconformity_count integer := 0;
  	affected_count integer;
begin
	raise notice '******  REQUIREMENT TYPE *******';

	select count(*)
	into m_requirement_count
	from openchpl.surveillance_requirement sr
	where sr.requirement_type_id in
   		(select id 
   		from openchpl.requirement_type
   		where title in ('170.523 (m)(1): Adaptations and updates',
   						'170.523 (m)(2): Adaptations and updates',
   						'170.523 (m)(3): Adaptations and updates',
   						'170.523 (m)(4): Adaptations and updates',
   						'170.523 (m)(5): Adaptations and updates'));

  	raise notice 'The number of surveillance requirements is %', m_requirement_count;

  	if m_requirement_count > 0 then
  		raise notice 'Need to "remove" the requirements';
  		update openchpl.additional_requirement_type
  		set removed = true 
  		where name in ('170.523 (m)(1): Adaptations and updates',
   						'170.523 (m)(2): Adaptations and updates',
   						'170.523 (m)(3): Adaptations and updates',
   						'170.523 (m)(4): Adaptations and updates',
   						'170.523 (m)(5): Adaptations and updates');
   		get diagnostics affected_count = row_count;
		raise notice 'Removed % requirement type(s)', affected_count;
  	else
  		raise notice 'Need to "delete" the requirements';
  		update openchpl.additional_requirement_type
  		set deleted = true 
  		where name in ('170.523 (m)(1): Adaptations and updates',
   						'170.523 (m)(2): Adaptations and updates',
   						'170.523 (m)(3): Adaptations and updates',
   						'170.523 (m)(4): Adaptations and updates',
   						'170.523 (m)(5): Adaptations and updates');
   		get diagnostics affected_count = row_count;
		raise notice 'Deleted % requirement type(s)', affected_count;
  	end if;

  	insert into openchpl.additional_requirement_type (requirement_group_type_id, name, removed, last_modified_user)
  	select 6, '170.523 (m): Adaptations and updates', false, -1
  	where not exists 
  		(select *
  		from openchpl.additional_requirement_type
  		where name = '170.523 (m): Adaptations and updates');

  	get diagnostics affected_count = row_count;

	update openchpl.additional_requirement_type
	set name = '170.523 (m): Adaptations and updates'
	where name= '170.523(m) Adaptations and updates';

	if affected_count = 0 then
  		raise notice '170.523 (m) requirement already exists';
  	else
  		raise notice '170.523 (m) requirement added';
  	end if;

  	raise notice '******  NONCONFORMITY TYPE *******';

	select count(*)
	into m_nonconformity_count
	from openchpl.surveillance_nonconformity sn
	where nonconformity_type_id in
   		(select id
   		from openchpl.nonconformity_type
   		where title in ('170.523 (m)(1): Adaptations and updates',
   						'170.523 (m)(2): Adaptations and updates',
   						'170.523 (m)(3): Adaptations and updates',
   						'170.523 (m)(4): Adaptations and updates',
   						'170.523 (m)(5): Adaptations and updates'));

  	raise notice 'The number of surveillance nonconforities is %', m_nonconformity_count;

  	if m_nonconformity_count > 0 then
  		raise notice 'Need to "remove" the nonconformities';
  		update openchpl.additional_nonconformity_type
  		set removed = true 
  		where name in ('170.523 (m)(1): Adaptations and updates',
   						'170.523 (m)(2): Adaptations and updates',
   						'170.523 (m)(3): Adaptations and updates',
   						'170.523 (m)(4): Adaptations and updates',
   						'170.523 (m)(5): Adaptations and updates');
   		get diagnostics affected_count = row_count;
		raise notice 'Removed % nonconformity type(s)', affected_count;
  	else
  		raise notice 'Need to "delete" the nonconformities';
  		update openchpl.additional_nonconformity_type
  		set deleted = true 
  		where name in ('170.523 (m)(1): Adaptations and updates',
   						'170.523 (m)(2): Adaptations and updates',
   						'170.523 (m)(3): Adaptations and updates',
   						'170.523 (m)(4): Adaptations and updates',
   						'170.523 (m)(5): Adaptations and updates');
   		get diagnostics affected_count = row_count;
		raise notice 'Deleted % nonconformity type(s)', affected_count;
  	end if;

  	insert into openchpl.additional_nonconformity_type (name, removed, last_modified_user)
  	select '170.523 (m): Adaptations and updates', false, -1
  	where not exists 
  		(select *
  		from openchpl.additional_nonconformity_type
  		where name = '170.523 (m): Adaptations and updates');

  	get diagnostics affected_count = row_count;

	update openchpl.additional_nonconformity_type
	set name = '170.523 (m): Adaptations and updates'
	where name= '170.523(m) Adaptations and updates';

  	if affected_count = 0 then
  		raise notice '170.523 (m) nonconfomrity already exists';
  	else
  		raise notice '170.523 (m) nonconformity added';
  	end if;
  	raise notice 'Completed';
end $$;
