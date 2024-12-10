update openchpl.url_uptime_monitor_test
set deleted = true,
	last_modified_sso_user = '3438c418-50e1-70f0-4d80-804fb08dd7d5',
	last_modified_user = null
where url_uptime_monitor_id in (
	select id
	from openchpl.url_uptime_monitor
	where url = 'https://fhir.meditouchehr.com/api/fhir/r4/endpoint'
);

