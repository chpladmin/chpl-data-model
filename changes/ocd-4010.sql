insert into openchpl.questionable_activity_trigger (name, level, last_modified_user)
select 'Real World Testing Plans URL or Check Date updated outside normal update period', 'Listing', -1
where not exists (
	select *
	from openchpl.questionable_activity_trigger
	where name = 'Real World Testing Plans URL or Check Date updated outside normal update period'
	and level = 'Listing'
);

insert into openchpl.questionable_activity_trigger (name, level, last_modified_user)
select 'Real World Testing Results URL or Check Date updated outside normal update period', 'Listing', -1
where not exists (
	select *
	from openchpl.questionable_activity_trigger
	where name = 'Real World Testing Results URL or Check Date updated outside normal update period'
	and level = 'Listing'
);