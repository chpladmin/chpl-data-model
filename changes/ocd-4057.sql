insert into openchpl.questionable_activity_trigger (name, level, last_modified_user)
select 'Non Active Listing Edited', 'Listing', -1
where not exists (
    select *
    from openchpl.questionable_activity_trigger
    where name = 'Non Active Listing Edited'
    and level = 'Listing'
);
