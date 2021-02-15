alter table openchpl.certified_product drop column if exists svap_notice_url cascade;
alter table openchpl.certified_product add column svap_notice_url text;
