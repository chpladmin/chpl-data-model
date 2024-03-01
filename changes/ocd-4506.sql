delete from openchpl.certification_result_standard
where standard_id in (
	select id
	from openchpl.standard
	where regulatory_text_citation in ('170.204(a)(1)', '170.204(a)(2)'));

delete from openchpl.standard_criteria_map
where standard_id in (
	select id
	from openchpl.standard
	where regulatory_text_citation in ('170.204(a)(1)', '170.204(a)(2)'));

delete from openchpl.standard
where regulatory_text_citation in ('170.204(a)(1)', '170.204(a)(2)');

