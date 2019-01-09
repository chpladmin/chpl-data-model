select cp.certified_product_id, cb.name as "acb name", openchpl.get_chpl_product_number(cp.certified_product_id) as "confirmed chpl id", pcp.unique_id as "pending chpl id", pcptu.targeted_user_name as "pending targeted user name", pcptu.targeted_user_id
from
openchpl.certified_product cp inner join openchpl.pending_certified_product pcp on cp.pending_certified_product_id = pcp.pending_certified_product_id
left join openchpl.pending_certified_product_targeted_user pcptu on pcp.pending_certified_product_id = pcptu.pending_certified_product_id
left join openchpl.certified_product_targeted_user cptu on cp.certified_product_id = cptu.certified_product_id
left join openchpl.targeted_user tu on tu.targeted_user_id = cptu.targeted_user_id
left join openchpl.certification_body cb on cp.certification_body_id = cb.certification_body_id
where
(pcptu.targeted_user_name is not null or pcptu.targeted_user_id is not null)
and tu.name is null
order by cp.certified_product_id
--limit 100
;
