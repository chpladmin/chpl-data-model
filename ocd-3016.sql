do $$
begin
    if exists(select count(*) from openchpl.activity_concept where concept = 'COMPLAINT') THEN
        -- Just set the seq to the correct value
        perform setval('openchpl.activity_concept_activity_concept_id_seq', 16);
    else
        perform setval('openchpl.activity_concept_activity_concept_id_seq', 15);

        insert into openchpl.activity_concept (concept, last_modified_user)
            select 'COMPLAINT', -1
            where not exists
                (select *
                from openchpl.activity_concept
                where concept = 'COMPLAINT');
    end if;
end $$;
