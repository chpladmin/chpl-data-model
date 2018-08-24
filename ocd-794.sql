alter table openchpl.contact drop column if exists full_name;
alter table openchpl.contact drop column if exists friendly_name;
alter table openchpl.contact add column full_name varchar(500);
alter table openchpl.contact add column friendly_name varchar(250);

update openchpl.contact set full_name = trim (first_name || ' ' || last_name) where first_name is not null;
update openchpl.contact set friendly_name = trim(first_name) where first_name is not null and char_length(first_name) > 0;
update openchpl.contact set full_name = trim(last_name) where first_name is null;

alter table openchpl.contact alter column full_name set not null;
