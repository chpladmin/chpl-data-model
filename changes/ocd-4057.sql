insert into openchpl.questionable_activity_trigger (name, level, last_modified_user)
select 'Non Active Certificate Edited', 'Listing', -1
where not exists (
    select *
    from openchpl.questionable_activity_trigger
    where name = 'Non Active Certificate Edited'
    and level = 'Listing'
);
