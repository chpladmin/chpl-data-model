alter table openchpl.certified_product drop column if exists svap_notice_url cascade;
alter table openchpl.certified_product add column svap_notice_url text;

insert into openchpl.url_type (name, last_modified_user) select
'Standards Version Advancement Process Notice', -1
where not exists (select name from openchpl.url_type where name = 'Standards Version Advancement Process Notice');

update openchpl.url_type set name = 'Documentation' where name = 'Documentation URL';
update openchpl.url_type set name = 'Mandatory Disclosure' where name = 'Mandatory Disclosure URL';
