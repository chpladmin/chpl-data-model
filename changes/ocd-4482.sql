create table if not exists openchpl.code_set_date (
    id bigserial not null,
    required_day date,
    creation_date timestamp not null default now(),
    last_modified_date timestamp not null default now(),
    last_modified_user bigint,
	last_modified_sso_user uuid,
    deleted bool not null default false,
    constraint code_set_date_pk primary key (id)
);
CREATE or replace TRIGGER code_set_date_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.code_set_date FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE or replace TRIGGER code_set_date_timestamp BEFORE UPDATE on openchpl.code_set_date FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS code_set_date_last_modified_user_constraint ON openchpl.code_set_date;
CREATE CONSTRAINT TRIGGER code_set_date_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.code_set_date DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();


create table if not exists openchpl.code_set_date_criteria_map (
    id bigserial not null,
    code_set_date_id int not null,
    certification_criterion_id int not null,
    creation_date timestamp not null default now(),
    last_modified_date timestamp not null default now(),
    last_modified_user bigint,
	last_modified_sso_user uuid,
    deleted bool not null default false,
    constraint code_set_date_criteria_map_pk primary key (id),
    constraint code_set_date_fk foreign key (code_set_date_id)
        references openchpl.code_set_date (id)
        match simple on update no action on delete restrict,
    constraint certification_criterion_fk foreign key (certification_criterion_id)
        references openchpl.certification_criterion (certification_criterion_id)
	match simple on update no action on delete restrict
);
CREATE or replace TRIGGER code_set_date_criteria_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.code_set_date_criteria_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE or replace TRIGGER code_set_date_criteria_map_timestamp BEFORE UPDATE on openchpl.code_set_date_criteria_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS code_set_date_criteria_map_last_modified_user_constraint ON openchpl.code_set_date_criteria_map;
CREATE CONSTRAINT TRIGGER code_set_date_criteria_map_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.code_set_date_criteria_map DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();

create table if not exists openchpl.certification_result_code_set_date (
    id bigserial not null,
    code_set_date_id int not null,
    certification_result_id int not null,
    creation_date timestamp not null default now(),
    last_modified_date timestamp not null default now(),
    last_modified_user bigint,
	last_modified_sso_user uuid,
    deleted bool not null default false,
    constraint certification_result_code_set_date_pk primary key (id),
    constraint code_set_date_fk foreign key (code_set_date_id)
        references openchpl.code_set_date (id)
        match simple on update no action on delete restrict,
    constraint certification_result_fk foreign key (certification_result_id)
        references openchpl.certification_result (certification_result_id)
        match simple on update no action on delete restrict
);
CREATE or replace TRIGGER certification_result_code_set_date_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certification_result_code_set_date FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE or replace TRIGGER certification_result_code_set_date_timestamp BEFORE UPDATE on openchpl.certification_result_code_set_date FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS certification_result_code_set_date_last_modified_user_constraint ON openchpl.certification_result_code_set_date;
CREATE CONSTRAINT TRIGGER certification_result_code_set_date_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.certification_result_code_set_date DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();

alter table openchpl.certification_criterion_attribute add column if not exists code_set_date boolean default false;

update openchpl.certification_criterion_attribute cca
set code_set_date = true
where criterion_id in (5, 6, 12, 15, 16, 18, 19, 20, 21, 28, 43, 45, 46, 165, 167);
