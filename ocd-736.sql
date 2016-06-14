insert into openchpl.certification_status (certification_status, last_modified_user) values ('Suspended', -1);
update openchpl.certification_status set certification_status = 'Terminated' where certification_status = 'Decertified';
