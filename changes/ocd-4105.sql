do $$ 
declare
  	m_requirement_count integer := 0;
  	affected_count integer;
begin
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

 	raise notice 'Completed';
end $$;
