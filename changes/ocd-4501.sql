insert into openchpl.questionable_activity_trigger (name, level, last_modified_user)
select 'Code Set has been removed', 'Certification Criteria', -1
where not exists (
    select *
    from openchpl.questionable_activity_trigger
    where name = 'Code Set has been removed');
