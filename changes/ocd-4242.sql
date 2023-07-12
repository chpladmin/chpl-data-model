create table if not exists openchpl.rule (
    id bigserial not null,
    name text not null,
    creation_date timestamp not null default now(),
    last_modified_date timestamp not null default now(),
    last_modified_user bigint not null ,
    deleted bool not null default false,
    constraint rule_pk primary key (id)
);

alter table openchpl.test_tool add column if not exists start_day date;

alter table openchpl.test_tool add column if not exists end_day date;

alter table openchpl.test_tool add column if not exists required_day date;

alter table openchpl.test_tool add column if not exists rule_id bigint;

alter table openchpl.test_tool drop constraint if exists rule_fk;
alter table openchpl.test_tool add constraint rule_fk foreign key (rule_id)
    references openchpl.rule (id)
    match simple on update no action on delete restrict;

alter table openchpl.test_tool add column if not exists value text;
update openchpl.test_tool
    set value = name;

alter table openchpl.test_tool add column if not exists regulatory_text_citation text;
