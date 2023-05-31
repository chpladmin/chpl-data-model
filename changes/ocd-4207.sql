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

