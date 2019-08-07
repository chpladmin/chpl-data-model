do $$
begin
	declare addr_count integer;

	--Is addr_id 1 still tied to multiple agencies
	select count(*) into addr_count from (
		select address_id from openchpl.vendor where deleted = false
		union all 
		select address_id from openchpl.certification_body where deleted = false
		union all 
		select address_id from openchpl.testing_lab where deleted = false) addr_cnt
	where address_id = 1
	group by address_id;

	if addr_count > 1 then
		insert into openchpl.address (street_line_1, street_line_2, city, state, zipcode, country, last_modified_user)
		select street_line_1, street_line_2, city, state, zipcode, country, -1
		from openchpl.address
		where address_id = 1;
		
		update openchpl.testing_lab
		set address_id = lastval(), last_modified_user = -1
		where vendor_id = 1;
	end if;

	--Is addr_id 2 still tied to multiple agencies
	select count(*) into addr_count from (
		select address_id from openchpl.vendor where deleted = false
		union all 
		select address_id from openchpl.certification_body where deleted = false
		union all 
		select address_id from openchpl.testing_lab where deleted = false) addr_cnt
	where address_id = 2
	group by address_id;

	if addr_count > 1 then
		insert into openchpl.address (street_line_1, street_line_2, city, state, zipcode, country, last_modified_user)
		select street_line_1, street_line_2, city, state, zipcode, country, -1
		from openchpl.address
		where address_id = 2;
		
		update openchpl.testing_lab
		set address_id = lastval(), last_modified_user = -1
		where vendor_id = 3;
	end if;

	--Is addr_id 81 still tied to multiple agencies
	select count(*) into addr_count from (
		select address_id from openchpl.vendor where deleted = false
		union all 
		select address_id from openchpl.certification_body where deleted = false
		union all 
		select address_id from openchpl.testing_lab where deleted = false) addr_cnt
	where address_id = 81
	group by address_id;

	if addr_count > 1 then
		insert into openchpl.address (street_line_1, street_line_2, city, state, zipcode, country, last_modified_user)
		select street_line_1, street_line_2, city, state, zipcode, country, -1
		from openchpl.address
		where address_id = 81;
		
		update openchpl.vendor
		set address_id = lastval(), last_modified_user = -1
		where vendor_id = 1565;
	end if;

	--Is addr_id 359 still tied to multiple agencies
	select count(*) into addr_count from (
		select address_id from openchpl.vendor where deleted = false
		union all 
		select address_id from openchpl.certification_body where deleted = false
		union all 
		select address_id from openchpl.testing_lab where deleted = false) addr_cnt
	where address_id = 359
	group by address_id;

	if addr_count > 1 then
		insert into openchpl.address (street_line_1, street_line_2, city, state, zipcode, country, last_modified_user)
		select street_line_1, street_line_2, city, state, zipcode, country, -1
		from openchpl.address
		where address_id = 359;
		
		update openchpl.vendor
		set address_id = lastval(), last_modified_user = -1
		where vendor_id = 2027;
	end if;

	--Is addr_id 351 still tied to multiple agencies
	select count(*) into addr_count from (
		select address_id from openchpl.vendor where deleted = false
		union all 
		select address_id from openchpl.certification_body where deleted = false
		union all 
		select address_id from openchpl.testing_lab where deleted = false) addr_cnt
	where address_id = 351
	group by address_id;

	if addr_count > 1 then
		insert into openchpl.address (street_line_1, street_line_2, city, state, zipcode, country, last_modified_user)
		select street_line_1, street_line_2, city, state, zipcode, country, -1
		from openchpl.address
		where address_id = 351;
		
		update openchpl.vendor
		set address_id = lastval(), last_modified_user = -1
		where vendor_id = 2007;
	end if;

	--Is addr_id 437 still tied to multiple agencies
	select count(*) into addr_count from (
		select address_id from openchpl.vendor where deleted = false
		union all 
		select address_id from openchpl.certification_body where deleted = false
		union all 
		select address_id from openchpl.testing_lab where deleted = false) addr_cnt
	where address_id = 437
	group by address_id;

	if addr_count > 1 then
		insert into openchpl.address (street_line_1, street_line_2, city, state, zipcode, country, last_modified_user)
		select street_line_1, street_line_2, city, state, zipcode, country, -1
		from openchpl.address
		where address_id = 437;
		
		update openchpl.vendor
		set address_id = lastval(), last_modified_user = -1
		where vendor_id = 2032;
	end if;

end $$;
