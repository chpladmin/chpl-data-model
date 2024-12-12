update openchpl.url_uptime_monitor_test
set deleted = true,
	last_modified_sso_user = null,
	last_modified_user = -1
where passed = false
and url_uptime_monitor_id in (
	select id
	from openchpl.url_uptime_monitor
	where url = 'https://fhir.meditouchehr.com/api/fhir/r4/endpoint'
);

