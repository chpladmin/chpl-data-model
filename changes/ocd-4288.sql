alter table openchpl.test_tool drop column if exists name;

alter table openchpl.test_tool drop column if exists description;

alter table openchpl.test_tool drop column if exists retired;

--------------------------------------------------------------------------

alter table openchpl.functionality_tested add column if not exists value text;

alter table openchpl.functionality_tested add column if not exists regulatory_text_citation text;

alter table openchpl.functionality_tested add column if not exists additional_information text;

alter table openchpl.functionality_tested add column if not exists start_day date;

alter table openchpl.functionality_tested add column if not exists end_day date;

alter table openchpl.functionality_tested add column if not exists required_day date;

alter table openchpl.functionality_tested add column if not exists rule_id bigint;

alter table openchpl.functionality_tested drop constraint if exists rule_fk;

alter table openchpl.functionality_tested add constraint rule_fk foreign key (rule_id)
    references openchpl.rule (id)
    match simple on update no action on delete restrict;

update openchpl.functionality_tested
set value = name,
regulatory_text_citation = number;

alter table openchpl.functionality_tested alter column value set not null;

alter table openchpl.functionality_tested alter column regulatory_text_citation set not null;
