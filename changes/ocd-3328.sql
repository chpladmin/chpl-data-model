alter table openchpl.api_key_activity
drop column if exists api_call_method;

alter table openchpl.api_key_activity
add column api_call_method character varying(16);
