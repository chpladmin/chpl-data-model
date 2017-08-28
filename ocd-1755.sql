update openchpl.certification_result_additional_software
set deleted = true, last_modified_date = now(), last_modified_user = -1
where certification_result_additional_software_id in 
	(select cras.certification_result_additional_software_id
	from openchpl.certified_product cp
	join openchpl.certification_result cr on cr.certified_product_id = cp.certified_product_id
	join openchpl.certification_criterion cc on cc.certification_criterion_id = cr.certification_criterion_id
	join openchpl.certification_result_additional_software cras on cras.certification_result_id = cr.certification_result_id and cras.deleted = false
	where cr.success = false);

update openchpl.certification_result_g1_macra
set deleted = true, last_modified_date = now(), last_modified_user = -1
where id in 
	(select crmacra.id
	from openchpl.certified_product cp
	join openchpl.certification_result cr on cr.certified_product_id = cp.certified_product_id
	join openchpl.certification_criterion cc on cc.certification_criterion_id = cr.certification_criterion_id
	join openchpl.certification_result_g1_macra crmacra on crmacra.certification_result_id = cr.certification_result_id and crmacra.deleted = false
	where cr.success = false);
	
update openchpl.certification_result_g2_macra
set deleted = true, last_modified_date = now(), last_modified_user = -1
where id in 
	(select crmacra.id
	from openchpl.certified_product cp
	join openchpl.certification_result cr on cr.certified_product_id = cp.certified_product_id
	join openchpl.certification_criterion cc on cc.certification_criterion_id = cr.certification_criterion_id
	join openchpl.certification_result_g2_macra crmacra on crmacra.certification_result_id = cr.certification_result_id and crmacra.deleted = false
	where cr.success = false);	

update openchpl.certification_result_test_data
set deleted = true, last_modified_date = now(), last_modified_user = -1
where certification_result_test_data_id in 
	(select crtd.certification_result_test_data_id
	from openchpl.certified_product cp
	join openchpl.certification_result cr on cr.certified_product_id = cp.certified_product_id
	join openchpl.certification_criterion cc on cc.certification_criterion_id = cr.certification_criterion_id
	join openchpl.certification_result_test_data crtd on crtd.certification_result_id = cr.certification_result_id and crtd.deleted = false
	where cr.success = false);	

update openchpl.certification_result_test_functionality
set deleted = true, last_modified_date = now(), last_modified_user = -1
where certification_result_test_functionality_id in 
	(select crtf.certification_result_test_functionality_id
	from openchpl.certified_product cp
	join openchpl.certification_result cr on cr.certified_product_id = cp.certified_product_id
	join openchpl.certification_criterion cc on cc.certification_criterion_id = cr.certification_criterion_id
	join openchpl.certification_result_test_functionality crtf on crtf.certification_result_id = cr.certification_result_id and crtf.deleted = false
	where cr.success = false);	
	
update openchpl.certification_result_test_procedure
set deleted = true, last_modified_date = now(), last_modified_user = -1
where certification_result_test_procedure_id in 
	(select crtp.certification_result_test_procedure_id
	from openchpl.certified_product cp
	join openchpl.certification_result cr on cr.certified_product_id = cp.certified_product_id
	join openchpl.certification_criterion cc on cc.certification_criterion_id = cr.certification_criterion_id
	join openchpl.certification_result_test_procedure crtp on crtp.certification_result_id = cr.certification_result_id and crtp.deleted = false
	where cr.success = false);	

update openchpl.certification_result_test_standard
set deleted = true, last_modified_date = now(), last_modified_user = -1
where certification_result_test_standard_id in 
	(select crts.certification_result_test_standard_id
	from openchpl.certified_product cp
	join openchpl.certification_result cr on cr.certified_product_id = cp.certified_product_id
	join openchpl.certification_criterion cc on cc.certification_criterion_id = cr.certification_criterion_id
	join openchpl.certification_result_test_standard crts on crts.certification_result_id = cr.certification_result_id and crts.deleted = false
	where cr.success = false);	

update openchpl.certification_result_test_task
set deleted = true, last_modified_date = now(), last_modified_user = -1
where certification_result_test_task_id in 
	(select crtt.certification_result_test_task_id
	from openchpl.certified_product cp
	join openchpl.certification_result cr on cr.certified_product_id = cp.certified_product_id
	join openchpl.certification_criterion cc on cc.certification_criterion_id = cr.certification_criterion_id
	join openchpl.certification_result_test_task crtt on crtt.certification_result_id = cr.certification_result_id and crtt.deleted = false
	where cr.success = false);
	
update openchpl.certification_result_test_tool
set deleted = true, last_modified_date = now(), last_modified_user = -1
where certification_result_test_tool_id in 
	(select crtt.certification_result_test_tool_id
	from openchpl.certified_product cp
	join openchpl.certification_result cr on cr.certified_product_id = cp.certified_product_id
	join openchpl.certification_criterion cc on cc.certification_criterion_id = cr.certification_criterion_id
	join openchpl.certification_result_test_tool crtt on crtt.certification_result_id = cr.certification_result_id and crtt.deleted = false
	where cr.success = false);
	
update openchpl.certification_result_ucd_process
set deleted = true, last_modified_date = now(), last_modified_user = -1
where certification_result_ucd_process_id in 
	(select crucd.certification_result_ucd_process_id
	from openchpl.certified_product_details cp
	join openchpl.certification_result cr on cr.certified_product_id = cp.certified_product_id
	join openchpl.certification_criterion cc on cc.certification_criterion_id = cr.certification_criterion_id
	join openchpl.certification_result_ucd_process crucd on crucd.certification_result_id = cr.certification_result_id and crucd.deleted = false
	where cr.success = false);