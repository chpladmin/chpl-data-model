alter table openchpl.certified_product drop column if exists svap_notice_url cascade;
alter table openchpl.certified_product add column svap_notice_url text;

insert into openchpl.url_type (name, last_modified_user) select
'SVAP Notice URL', -1
where not exists (select name from openchpl.url_type where name = 'SVAP Notice URL');
