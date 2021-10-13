alter table openchpl.deprecated_api add column if not exists removal_date date;

update openchpl.deprecated_api set removal_date = '2022-04-15' where removal_date is null;

alter table openchpl.deprecated_api alter column removal_date set not null;
