update openchpl.certification_result_test_standard
set test_standard_id = 54
where certification_result_test_standard_id =
	(select crts1.certification_result_test_standard_id
	from openchpl.certified_product cp
	inner join openchpl.certification_result cr
		on cp.certified_product_id = cr.certified_product_id
	inner join openchpl.certification_result_test_standard crts1
		on cr.certification_result_id = crts1.certification_result_id
	inner join openchpl.test_standard ts
		on crts1.test_standard_id = ts.test_standard_id
	where cp.certified_product_id = 10099
	and cr.certification_criterion_id = 47
	and ts.test_standard_id = 41);

update openchpl.certification_result_test_standard
set test_standard_id = 76
where certification_result_test_standard_id = 
	(select crts1.certification_result_test_standard_id
	from openchpl.certified_product cp
	inner join openchpl.certification_result cr
		on cp.certified_product_id = cr.certified_product_id
	inner join openchpl.certification_result_test_standard crts1
		on cr.certification_result_id = crts1.certification_result_id
	inner join openchpl.test_standard ts 
		on crts1.test_standard_id = ts.test_standard_id
	where cp.certified_product_id = 10532
	and cr.certification_criterion_id = 175
	and ts.test_standard_id = 45);
