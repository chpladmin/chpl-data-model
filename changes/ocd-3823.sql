-- drop audit triggers
DROP TRIGGER IF EXISTS deprecated_api_audit ON openchpl.deprecated_api;
DROP TRIGGER IF EXISTS deprecated_api_timestamp ON openchpl.deprecated_api;
DROP TRIGGER IF EXISTS deprecated_api_usage_audit ON openchpl.deprecated_api;
DROP TRIGGER IF EXISTS deprecated_api_usage_timestamp ON openchpl.deprecated_api;
DROP TRIGGER IF EXISTS deprecated_response_field_audit on openchpl.deprecated_response_field;
DROP TRIGGER IF EXISTS deprecated_response_field_timestamp on openchpl.deprecated_response_field;
DROP TRIGGER IF EXISTS deprecated_response_field_api_audit on openchpl.deprecated_response_field_api;
DROP TRIGGER IF EXISTS deprecated_response_field_api_timestamp on openchpl.deprecated_response_field_api;
DROP TRIGGER IF EXISTS deprecated_response_field_api_usage_audit on openchpl.deprecated_response_field_api_usage;
DROP TRIGGER IF EXISTS deprecated_response_field_api_usage_timestamp on openchpl.deprecated_response_field_api_usage;

-- fix deprecated_api
DROP INDEX IF EXISTS openchpl.deprecated_api_unique_method_and_api_operation_and_parameter;
ALTER TABLE openchpl.deprecated_api DROP CONSTRAINT IF EXISTS deprecated_api_method_and_api_operation_and_parameter_idx;
ALTER TABLE openchpl.deprecated_api ADD CONSTRAINT deprecated_api_method_and_api_operation_and_parameter_idx UNIQUE (http_method, api_operation, request_parameter);

-- fix deprecated_api_usage
ALTER TABLE openchpl.deprecated_api_usage
DROP COLUMN IF EXISTS notification_sent;

ALTER TABLE openchpl.deprecated_api_usage
ADD COLUMN notification_sent timestamp;

UPDATE openchpl.deprecated_api_usage
SET notification_sent = last_modified_date
WHERE deleted = true;

DROP INDEX IF EXISTS openchpl.deprecated_api_usage_unique_api_key_and_deprecated_api;
ALTER TABLE openchpl.deprecated_api_usage DROP CONSTRAINT IF EXISTS deprecated_api_usage_api_key_and_deprecated_api_idx;
ALTER TABLE openchpl.deprecated_api_usage ADD CONSTRAINT deprecated_api_usage_api_key_and_deprecated_api_idx UNIQUE (api_key_id, deprecated_api_id, notification_sent);

-- fix deprecated_response_field_api
DROP INDEX IF EXISTS openchpl.deprecated_response_field_api_unique_method_and_api_operation;
ALTER TABLE openchpl.deprecated_response_field_api DROP CONSTRAINT IF EXISTS deprecated_response_field_api_method_and_api_operation_idx;
ALTER TABLE openchpl.deprecated_response_field_api ADD CONSTRAINT deprecated_response_field_api_method_and_api_operation_idx UNIQUE (http_method, api_operation);

-- fix deprecated_response_field
DROP INDEX IF EXISTS openchpl.deprecated_response_field_unique_response_field;
ALTER TABLE openchpl.deprecated_response_field DROP CONSTRAINT IF EXISTS deprecated_response_field_response_field_idx;
ALTER TABLE openchpl.deprecated_response_field ADD CONSTRAINT deprecated_response_field_response_field_idx UNIQUE (deprecated_api_id, response_field);

-- fix deprecated_response_field_api_usage
ALTER TABLE openchpl.deprecated_response_field_api_usage
DROP COLUMN IF EXISTS notification_sent;

ALTER TABLE openchpl.deprecated_response_field_api_usage
ADD COLUMN notification_sent timestamp;

UPDATE openchpl.deprecated_response_field_api_usage
SET notification_sent = last_modified_date
WHERE deleted = true;

DROP INDEX IF EXISTS openchpl.deprecated_response_field_api_usage_unique_record;
ALTER TABLE openchpl.deprecated_response_field_api_usage DROP CONSTRAINT IF EXISTS deprecated_response_field_api_usage_idx;
ALTER TABLE openchpl.deprecated_response_field_api_usage ADD CONSTRAINT deprecated_response_field_api_usage_idx UNIQUE (api_key_id, deprecated_response_field_api_id, notification_sent);

-- add audit triggers back
CREATE TRIGGER deprecated_api_audit AFTER INSERT OR UPDATE OR DELETE ON openchpl.deprecated_api FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER deprecated_api_timestamp BEFORE UPDATE ON openchpl.deprecated_api FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER deprecated_api_usage_audit AFTER INSERT OR UPDATE OR DELETE ON openchpl.deprecated_api FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER deprecated_api_usage_timestamp BEFORE UPDATE ON openchpl.deprecated_api FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER deprecated_response_field_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.deprecated_response_field FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER deprecated_response_field_timestamp BEFORE UPDATE on openchpl.deprecated_response_field FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER deprecated_response_field_api_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.deprecated_response_field_api FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER deprecated_response_field_api_timestamp BEFORE UPDATE on openchpl.deprecated_response_field_api FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER deprecated_response_field_api_usage_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.deprecated_response_field_api_usage FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER deprecated_response_field_api_usage_timestamp BEFORE UPDATE on openchpl.deprecated_response_field_api_usage FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();