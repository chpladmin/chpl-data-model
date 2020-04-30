CREATE TRIGGER ff4j_audit_audit AFTER INSERT OR UPDATE OR DELETE on ff4j.audit FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER ff4j_custom_properties_audit AFTER INSERT OR UPDATE OR DELETE on ff4j.custom_properties FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER ff4j_features_audit AFTER INSERT OR UPDATE OR DELETE on ff4j.features FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER ff4j_properties_audit AFTER INSERT OR UPDATE OR DELETE on ff4j.properties FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER ff4j_roles_audit AFTER INSERT OR UPDATE OR DELETE on ff4j.roles FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();