create table if not exists openchpl.standard (
    id bigserial not null,
    rule_id int,
    value text not null,
    regulatory_text_citation text not null,
    additional_information text,
    start_day date,
    end_day date,
    required_day date,
    creation_date timestamp not null default now(),
    last_modified_date timestamp not null default now(),
    last_modified_user bigint not null ,
    deleted bool not null default false,
    constraint standard_pk primary key (id),
    constraint rule_fk foreign key (rule_id)
	    references openchpl.rule (id)
	    match simple on update no action on delete restrict
);
CREATE or replace TRIGGER standard_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.standard FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE or replace TRIGGER standard_timestamp BEFORE UPDATE on openchpl.standard FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();


create table if not exists openchpl.standard_criteria_map (
    id bigserial not null,
    standard_id int not null,
    certification_criterion_id int not null,
    creation_date timestamp not null default now(),
    last_modified_date timestamp not null default now(),
    last_modified_user bigint not null ,
    deleted bool not null default false,
    constraint standard_criteria_map_pk primary key (id),
    constraint standard_fk foreign key (standard_id)
        references openchpl.rule (id)
        match simple on update no action on delete restrict,
    constraint certification_criterion_fk foreign key (certification_criterion_id)
        references openchpl.certification_criterion (certification_criterion_id)
	match simple on update no action on delete restrict
);
CREATE or replace TRIGGER standard_criteria_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.standard_criteria_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE or replace TRIGGER standard_criteria_map_timestamp BEFORE UPDATE on openchpl.standard_criteria_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

create table if not exists openchpl.certification_result_standard (
    id bigserial not null,
    standard_id int not null,
    certification_result_id int not null,
    creation_date timestamp not null default now(),
    last_modified_date timestamp not null default now(),
    last_modified_user bigint not null ,
    deleted bool not null default false,
    constraint certification_result_standard_pk primary key (id),
    constraint standard_fk foreign key (standard_id)
        references openchpl.rule (id)
        match simple on update no action on delete restrict,
    constraint certification_result_fk foreign key (certification_result_id)
        references openchpl.certification_result (certification_result_id)
        match simple on update no action on delete restrict
);
CREATE or replace TRIGGER certification_result_standard_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certification_result_standard FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE or replace TRIGGER certification_result_standard_timestamp BEFORE UPDATE on openchpl.certification_result_standard FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
