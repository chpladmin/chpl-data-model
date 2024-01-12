create table if not exists openchpl.updated_listing_status_report (
    id bigserial not null,
    certified_product_id bigint not null,
    report_day date not null,
    criteria_require_update_count int,
    days_updated_early int,
    creation_date timestamp not null default now(),
    last_modified_date timestamp not null default now(),
    last_modified_user bigint,
    last_modified_sso_user bigint,
    deleted bool not null default false,
    constraint updated_listing_status_report_pk primary key (id),
    constraint certified_product_fk foreign key (certified_product_id)
	    references openchpl.certified_product (certified_product_id)
	    match simple on update no action on delete restrict
);
CREATE or replace TRIGGER updated_listing_status_report_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.updated_listing_status_report FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE or replace TRIGGER updated_listing_status_report_timestamp BEFORE UPDATE on openchpl.updated_listing_status_report FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

DROP TRIGGER IF EXISTS updated_listing_status_report_last_modified_user_constraint ON openchpl.updated_listing_status_report;
CREATE CONSTRAINT TRIGGER updated_listing_status_report_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.updated_listing_status_report DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();
