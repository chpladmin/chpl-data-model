-- Deployment file for version 23.8.0
--     as of 2023-06-12
-- ./changes/ocd-4207.sql
create table if not exists openchpl.chpl_uptime_monitor (
	id bigserial not null,
	description text not null,
	datadog_monitor_key text not null,
	url text not null,
	creation_date timestamp not null default now(),
	last_modified_date timestamp not null default now(),
	last_modified_user bigint not null ,
	deleted bool not null default false,
	constraint chpl_uptime_monitor_pk primary key (id)
);
drop trigger if exists chpl_uptime_monitor_audit on openchpl.chpl_uptime_monitor;
create trigger chpl_uptime_monitor_audit after insert or update or delete on openchpl.chpl_uptime_monitor for each row execute procedure audit.if_modified_func();
drop trigger if exists chpl_uptime_monitor_timestamp on openchpl.chpl_uptime_monitor;
create trigger chpl_uptime_monitor_timestamp before update on openchpl.chpl_uptime_monitor for each row execute procedure openchpl.update_last_modified_date_column();

create table if not exists openchpl.chpl_uptime_monitor_test (
	id bigserial not null,
	chpl_uptime_monitor_id bigint not null,
	datadog_test_key text not null,
	check_time timestamp not null,
	passed bool not null,
	creation_date timestamp not null default now(),
	last_modified_date timestamp not null default now(),
	last_modified_user bigint not null ,
	deleted bool not null default false,
	constraint chpl_uptime_monitor_test_pk primary key (id),
	constraint chpl_uptime_monitor_fk foreign key (chpl_uptime_monitor_id)
	    references openchpl.chpl_uptime_monitor (id)
        match simple on update no action on delete restrict
);
drop trigger if exists chpl_uptime_monitor_test_audit on openchpl.chpl_uptime_monitor_test;
create trigger chpl_uptime_monitor_test_audit after insert or update or delete on openchpl.chpl_uptime_monitor_test for each row execute procedure audit.if_modified_func();
drop trigger if exists chpl_uptime_monitor_test_timestamp on openchpl.chpl_uptime_monitor_test;
create trigger chpl_uptime_monitor_test_timestamp before update on openchpl.chpl_uptime_monitor_test for each row execute procedure openchpl.update_last_modified_date_column();

;
-- ./changes/ocd-4212.sql
-- OCD-4212 Remove ATL Users and Permission

UPDATE openchpl.user_permission
SET deleted = true
WHERE name = 'ATL';

UPDATE openchpl.user_testing_lab_map
SET deleted = true;

UPDATE openchpl.user 
SET deleted = TRUE
WHERE user_permission_id = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ATL');

-- OCD-4225 Remove ONC_STAFF Users and permission
UPDATE openchpl.user_permission
SET deleted = true
WHERE name = 'ONC_STAFF';

UPDATE openchpl.user 
SET deleted = TRUE
WHERE user_permission_id = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ONC_STAFF');
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('23.8.0', '2023-06-12', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
