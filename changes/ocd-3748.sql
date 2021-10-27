insert into openchpl.surveillance_requirement_type
(name, last_modified_user)
select 'Real World Testing Submission', -1
where not exists
    (select *
    from openchpl.surveillance_requirement_type
    where name = 'Real World Testing Submission');
