insert into openchpl.certification_result (certified_product_id, certification_criterion_id, success, g1_success, g2_success, last_modified_user)
select cp.certified_product_id, crit.certification_criterion_id, false, false, false, -1
from openchpl.certified_product cp,
	(select cc.certification_criterion_id
	from openchpl.certification_criterion cc
		inner join openchpl.certification_criterion_attribute cca
			on cc.certification_criterion_id = cca.criterion_id
	where cc.certification_edition_id = 2
	and (cca.g1_success or cca.g2_success)) crit
where certification_edition_id = 2
and cp.deleted = false
and not exists (
	select certification_result_id
	from openchpl.certification_result cr
	where cr.certification_criterion_id = crit.certification_criterion_id
	and cr.certified_product_id = cp.certified_product_id
	and cr.deleted = false
);
