alter table openchpl.certification_body drop column if exists retirement_date;
alter table openchpl.testing_lab drop column if exists retirement_date;
alter table openchpl.certification_body add column retirement_date timestamp;
alter table openchpl.testing_lab add column retirement_date timestamp;

update openchpl.certification_body set retirement_date = '2014-05-01' where name = 'CCHIT';
update openchpl.certification_body set retirement_date = '2013-04-04' where name = 'Surescripts LLC';
update openchpl.testing_lab set retirement_date = '2014-05-01' where name = 'CCHIT';
update openchpl.testing_lab set retirement_date = '2016-07-28' where name = 'National Technical Systems';
