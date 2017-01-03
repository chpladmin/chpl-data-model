insert into openchpl.certification_status (certification_status, last_modified_user) 
select
	'Withdrawn by Developer Under Surveillance/Review', -1
where not exists (
	select * from openchpl.certification_status where certification_status = 'Withdrawn by Developer Under Surveillance/Review'
);
