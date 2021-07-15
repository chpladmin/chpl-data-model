alter table openchpl.surveillance_nonconformity
add column if not exists non_conformity_close_date DATE;

alter table openchpl.broken_surveillance_rules
add column if not exists non_conformity_close_date DATE;

alter table openchpl.pending_surveillance_nonconformity
add column if not exists non_conformity_close_date DATE;

update openchpl.surveillance_nonconformity
set non_conformity_close_date = corrective_action_end_date
where nonconformity_status_id =
    (select id from openchpl.nonconformity_status where name = 'Closed');
