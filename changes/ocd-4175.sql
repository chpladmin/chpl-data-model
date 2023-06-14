create table if not exists openchpl.datadog_monitor (
	id bigserial not null,
	developer_id bigint not null,
	datadog_monitor_key text not null,
	url text not null,
	creation_date timestamp not null default now(),
	last_modified_date timestamp not null default now(),
	last_modified_user bigint not null ,
	deleted bool not null default false,
	constraint datadog_monitor_pk primary key (id),
	constraint developer_fk foreign key (developer_id)
	    references openchpl.vendor (vendor_id)
        match simple on update no action on delete restrict
);
drop trigger if exists datadog_monitor_audit on openchpl.datadog_monitor;
create trigger datadog_monitor_audit after insert or update or delete on openchpl.datadog_monitor for each row execute procedure audit.if_modified_func();
drop trigger if exists datadog_monitor_timestamp on openchpl.datadog_monitor;
create trigger datadog_monitor_timestamp before update on openchpl.datadog_monitor for each row execute procedure openchpl.update_last_modified_date_column();

create table if not exists openchpl.datadog_monitor_test (
	id bigserial not null,
	datadog_monitor_id bigint not null,
	datadog_test_key text not null,
	check_time timestamp not null,
	passed bool not null,
	creation_date timestamp not null default now(),
	last_modified_date timestamp not null default now(),
	last_modified_user bigint not null ,
	deleted bool not null default false,
	constraint datadog_monitor_test_pk primary key (id),
	constraint datadog_monitor_fk foreign key (datadog_monitor_id)
	    references openchpl.datadog_monitor (id)
        match simple on update no action on delete restrict
);
drop trigger if exists datadog_monitor_test_audit on openchpl.datadog_monitor_test;
create trigger datadog_monitor_test_audit after insert or update or delete on openchpl.datadog_monitor_test for each row execute procedure audit.if_modified_func();
drop trigger if exists datadog_monitor_test_timestamp on openchpl.datadog_monitor_test;
create trigger datadog_monitor_test_timestamp before update on openchpl.datadog_monitor_test for each row execute procedure openchpl.update_last_modified_date_column();
