alter table openchpl.user drop column if exists last_logged_in_date;

alter table openchpl.user add column last_logged_in_date timestamp;