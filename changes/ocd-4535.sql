insert into openchpl.certification_result_standard (certification_result_id, standard_id, last_modified_user)
select cr.certification_result_id, 50, -1
from openchpl.certification_result cr
where cr.certification_criterion_id = 179
and cr.deleted = false
and not exists (
	select * 
	from openchpl.certification_result_standard
	where certification_result_id = cr.certification_result_id 
	and standard_id = 50
	and deleted = false);