create table if not exists openchpl.change_request_certification_body_map (
    id bigserial not null,
    change_request_id bigint not null,
    certification_body_id bigint not null,
    creation_date timestamp not null default now(),
	last_modified_date timestamp not null default now(),
	last_modified_user int8 not null ,
	deleted bool not null default false,
	constraint change_request_certification_body_map_pk primary key (id),
	constraint change_request_fk foreign key (change_request_id)
	    references openchpl.change_request (id)
        match simple on update no action on delete restrict,
    constraint certification_body_fk foreign key (certification_body_id)
	    references openchpl.certification_body (certification_body_id)
        match simple on update no action on delete restrict
);
drop trigger if exists change_request_certification_body_map_audit on openchpl.change_request_certification_body_map;
create trigger change_request_certification_body_map_audit after insert or update or delete on openchpl.change_request_certification_body_map for each row execute procedure audit.if_modified_func();
drop trigger if exists change_request_certification_body_map_timestamp on openchpl.change_request_certification_body_map;
create trigger change_request_certification_body_map_timestamp before update on openchpl.change_request_certification_body_map for each row execute procedure openchpl.update_last_modified_date_column();

insert into openchpl.change_request_certification_body_map (change_request_id, certification_body_id, last_modified_user)
select cr.id, dcbm.certification_body_id, cr.last_modified_user
from openchpl.change_request cr
	inner join openchpl.vendor v 
		on cr.developer_id = v.vendor_id 
	inner join openchpl.developer_certification_body_map dcbm 
		on v.vendor_id = dcbm.vendor_id
where not exists (
	select *
	from openchpl.change_request_certification_body_map crcbm
	where crcbm.change_request_id = cr.id
	and crcbm.certification_body_id = dcbm.certification_body_id 
);
