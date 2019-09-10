-- Deployment file for version 17.10.0
--     as of 2019-09-10
-- ocd-3018-2.sql
select address_id, count(*) from (
		select address_id from openchpl.vendor where deleted = false
		union all 
		select address_id from openchpl.certification_body where deleted = false
		union all 
		select address_id from openchpl.testing_lab where deleted = false) addr_cnt
where address_id is not null
group by address_id
having count(*) > 1;

do $$
    declare addr_count integer;
begin
	--Is addr_id 285 still tied to multiple agencies
	select count(*) into addr_count from (
		select address_id from openchpl.vendor where deleted = false
		union all 
		select address_id from openchpl.certification_body where deleted = false
		union all 
		select address_id from openchpl.testing_lab where deleted = false) addr_cnt
	where address_id = 285
	group by address_id;

	if addr_count > 1 then
		insert into openchpl.address (street_line_1, street_line_2, city, state, zipcode, country, last_modified_user)
		select street_line_1, street_line_2, city, state, zipcode, country, -1
		from openchpl.address
		where address_id = 285;
		
		update openchpl.vendor
		set address_id = lastval(), last_modified_user = -1
		where vendor_id = 2034;
	end if;
end $$;

select address_id, count(*) from (
		select address_id from openchpl.vendor where deleted = false
		union all 
		select address_id from openchpl.certification_body where deleted = false
		union all 
		select address_id from openchpl.testing_lab where deleted = false) addr_cnt
where address_id is not null
group by address_id
having count(*) > 1;;
-- ocd-3013.sql
alter table openchpl.user drop column if exists last_logged_in_date;

alter table openchpl.user add column last_logged_in_date timestamp;

;
-- ocd-2748.sql
insert into openchpl.filter_type (name, last_modified_user)
select 'API Key Usage Report', -1
where not exists
	(select *
	from openchpl.filter_type
	where name = 'API Key Usage Report');
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('17.10.0', '2019-09-10', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
