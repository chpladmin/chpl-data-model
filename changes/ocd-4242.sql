create table if not exists openchpl.rule (
    id bigserial not null,
    name text not null,
    creation_date timestamp not null default now(),
    last_modified_date timestamp not null default now(),
    last_modified_user bigint not null ,
    deleted bool not null default false,
    constraint rule_pk primary key (id)
);

insert into openchpl.rule (name, last_modified_user)
select '2011', -1
where not exists (select * from openchpl.rule where name = '2011');

insert into openchpl.rule (name, last_modified_user)
select '2014', -1
where not exists (select * from openchpl.rule where name = '2014');

insert into openchpl.rule (name, last_modified_user)
select '2015', -1
where not exists (select * from openchpl.rule where name = '2015');

insert into openchpl.rule (name, last_modified_user)
select 'Cures', -1
where not exists (select * from openchpl.rule where name = 'Cures');

insert into openchpl.rule (name, last_modified_user)
select 'HTI-1', -1
where not exists (select * from openchpl.rule where name = 'HTI-1');

insert into openchpl.rule (name, last_modified_user)
select 'HTI-2', -1
where not exists (select * from openchpl.rule where name = 'HTI-2');

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
