-- Deployment file for version 17.9.0
--     as of 2019-08-26
-- ocd-3018.sql
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
		where testing_lab_id = 1;
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
		where testing_lab_id = 3;
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
		where vendor_id = 1880;
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
    
    --Is addr_id 500 still tied to multiple agencies
	select count(*) into addr_count from (
		select address_id from openchpl.vendor where deleted = false
		union all 
		select address_id from openchpl.certification_body where deleted = false
		union all 
		select address_id from openchpl.testing_lab where deleted = false) addr_cnt
	where address_id = 500
	group by address_id;

	if addr_count > 1 then
		insert into openchpl.address (street_line_1, street_line_2, city, state, zipcode, country, last_modified_user)
		select street_line_1, street_line_2, city, state, zipcode, country, -1
		from openchpl.address
		where address_id = 500;
		
		update openchpl.vendor
		set address_id = lastval(), last_modified_user = -1
		where vendor_id = 1886;
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
-- ocd-2158.sql
-- create table to map users to developers
DROP TABLE IF EXISTS openchpl.user_developer_map;
CREATE TABLE openchpl.user_developer_map (
	id bigserial NOT NULL,
	user_id bigint NOT NULL,
	developer_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT user_developer_map_pk PRIMARY KEY (id),
	CONSTRAINT user_fk FOREIGN KEY (user_id)
		REFERENCES openchpl.user (user_id)
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
	CONSTRAINT developer_fk FOREIGN KEY (developer_id)
		REFERENCES openchpl.vendor (vendor_id)
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);
CREATE TRIGGER user_developer_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.user_developer_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER user_developer_map_timestamp BEFORE UPDATE on openchpl.user_developer_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

-- insert developer role
INSERT INTO openchpl.user_permission ("name", description, authority, last_modified_user)
SELECT 'DEVELOPER', 'This permission gives a user the ability to submit update requests for their organization(s).', 'ROLE_DEVELOPER', -1
WHERE NOT EXISTS
        (SELECT *
        FROM openchpl.user_permission
        WHERE authority = 'ROLE_DEVELOPER');
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('17.9.0', '2019-08-26', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
