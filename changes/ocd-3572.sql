alter table openchpl.surveillance_nonconformity
add column if not exists non_conformity_close_date DATE;

alter table openchpl.broken_surveillance_rules
add column if not exists non_conformity_close_date DATE;

alter table openchpl.pending_surveillance_nonconformity
add column if not exists non_conformity_close_date DATE;

-- Set Close Date to the CAP End Date for non-conformities that are closed
update openchpl.surveillance_nonconformity
set non_conformity_close_date = corrective_action_end_date
where nonconformity_status_id =
    (select id from openchpl.nonconformity_status where name = 'Closed');

-- If the Close Date was not set above (CAP End Date was null), use the surveillance End Date
-- This must be run after the above 'standard' date conversion
update openchpl.surveillance_nonconformity sn
set non_conformity_close_date =
	(select s.end_date
	from openchpl.surveillance_requirement sr
 		inner join openchpl.surveillance s
			 on sr.surveillance_id = s.id
	where sr.id = sn.surveillance_requirement_id)
where sn.nonconformity_status_id =
    (select id from openchpl.nonconformity_status where name = 'Closed')
and sn.non_conformity_close_date is null;

alter table openchpl.surveillance_nonconformity alter column nonconformity_status_id drop not null;

-- Add the deprecated endpoint
insert into openchpl.deprecated_api
(http_method, api_operation, change_description, last_modified_user)
select 'GET',
	'/data/nonconformity_status_types',
	'This endpoint is deprecated and will be removed in a future release. The "Non-conformity Status" is now derived based on the existence of a "Non-conformity Close Date".',
	-1
where not exists (
	select *
	from openchpl.deprecated_api
	where http_method = 'GET'
	and api_operation = '/data/nonconformity_status_types');
