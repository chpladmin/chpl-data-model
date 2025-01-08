update openchpl.url_uptime_monitor_test uumt
set deleted = true 
where uumt.passed = false 
and uumt.url_uptime_monitor_id = (
	select uum.id
	from openchpl.url_uptime_monitor uum
	where uum.url = 'https://fhir.eclinicalworks.com/ecwopendev/external/practiceList?pageId=1');
