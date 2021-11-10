insert into openchpl.surveillance_requirement_type
(name, last_modified_user)
select 'Real World Testing Submission', -1
where not exists
    (select *
    from openchpl.surveillance_requirement_type
    where name = 'Real World Testing Submission');

insert into openchpl.questionable_activity_trigger
(name, level, last_modified_user)
select 'Removed Non-Conformity added to Surveillance', 'Listing', -1
where not exists
	(select *
	from openchpl.questionable_activity_trigger
	where name = 'Removed Non-Conformity added to Surveillance'
	and level ='Listing');

insert into openchpl.questionable_activity_trigger
(name, level, last_modified_user)
select 'Removed Requirement added to Surveillance', 'Listing', -1
where not exists
	(select *
	from openchpl.questionable_activity_trigger
	where name = 'Removed Requirement added to Surveillance'
	and level ='Listing');
