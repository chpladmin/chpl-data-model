-- OCD-2273 - Migrate ICS Error report
DROP TABLE IF EXISTS openchpl.inheritance_errors_report;
CREATE TABLE openchpl.inheritance_errors_report
(
    id bigserial NOT NULL,
    chpl_product_number varchar(250) NOT NULL,
    developer varchar(300) NOT NULL,
    product varchar(300) NOT NULL,
    version varchar(250) NOT NULL,
    acb varchar(250) NOT NULL,
    url varchar(250) NOT NULL,
    reason text NOT NULL,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
    CONSTRAINT inheritance_errors_report_id_pk PRIMARY KEY (id)
);
CREATE TRIGGER inheritance_errors_report_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.inheritance_errors_report FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER inheritance_errors_report_timestamp BEFORE UPDATE on openchpl.inheritance_errors_report FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

-- OCD-2272: Surveillance broken rules
DROP TABLE IF EXISTS openchpl.broken_surveillance_rules;
CREATE TABLE openchpl.broken_surveillance_rules
(
    id bigserial NOT NULL,
    developer varchar(300) NOT NULL,
    product varchar(300) NOT NULL,
    version varchar(250) NOT NULL,
    chpl_product_number varchar(250) NOT NULL,
    url varchar(250) NOT NULL,
    acb varchar(250) NOT NULL,
    certification_status varchar(64) NOT NULL,
    date_of_last_status_change varchar(64) NOT NULL,
    surveillance_id varchar(64),
    date_surveillance_began varchar(64),
    date_surveillance_ended varchar(64),
    surveillance_type varchar(64),
    lengthy_suspension_rule varchar(64),
    cap_not_approved_rule varchar(64),
    cap_not_started_rule varchar(64),
    cap_not_completed_rule varchar(64),
    cap_not_closed_rule varchar(64),
    closed_cap_with_open_nonconformity_rule varchar(64),
    nonconformity boolean NOT NULL,
    nonconformity_status varchar(64),
    nonconformity_criteria varchar(64),
    date_of_determination_of_nonconformity varchar(64),
    corrective_action_plan_approved_date varchar(64),
    date_corrective_action_began varchar(64),
    date_corrective_action_must_be_completed varchar(64),
    date_corrective_action_was_completed varchar(64),
    number_of_days_from_determination_to_cap_approval bigint,
    number_of_days_from_determination_to_present bigint,
    number_of_days_from_cap_approval_to_cap_began bigint,
    number_of_days_from_cap_approval_to_present bigint,
    number_of_days_from_cap_began_to_cap_completed bigint,
    number_of_days_from_cap_began_to_present bigint,
    difference_from_cap_completed_and_cap_must_be_completed bigint,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
    CONSTRAINT broken_surveillance_rules_id_pk PRIMARY KEY (id)
);
CREATE TRIGGER broken_surveillance_rules_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.broken_surveillance_rules FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER broken_surveillance_rules_timestamp BEFORE UPDATE on openchpl.broken_surveillance_rules FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

update openchpl.notification_type set deleted = true where "name" = 'ONC-ACB Daily Surveillance Broken Rules';
update openchpl.notification_type set deleted = true where "name" = 'ONC-ACB Weekly Surveillance Broken Rules';
update openchpl.notification_type set deleted = true where "name" = 'ONC Daily Surveillance Broken Rules';
update openchpl.notification_type set deleted = true where "name" = 'ONC Weekly Surveillance Broken Rules';
update openchpl.notification_type set deleted = true where "name" = 'ONC-ACB Weekly ICS Family Errors';
update openchpl.notification_type set deleted = true where "name" = 'ONC Weekly ICS Family Errors';
update openchpl.notification_type set deleted = true where "name" = 'Summary Statistics';
update openchpl.notification_type set deleted = true where "name" = 'Cache Status Age Notification';

update openchpl.notification_type_permission set deleted = true where notification_type_id = (select id from openchpl.notification_type where "name" = 'ONC-ACB Daily Surveillance Broken Rules');
update openchpl.notification_type_permission set deleted = true where notification_type_id = (select id from openchpl.notification_type where "name" = 'ONC-ACB Weekly Surveillance Broken Rules');
update openchpl.notification_type_permission set deleted = true where notification_type_id = (select id from openchpl.notification_type where "name" = 'ONC Daily Surveillance Broken Rules');
update openchpl.notification_type_permission set deleted = true where notification_type_id = (select id from openchpl.notification_type where "name" = 'ONC Weekly Surveillance Broken Rules');
update openchpl.notification_type_permission set deleted = true where notification_type_id = (select id from openchpl.notification_type where "name" = 'ONC-ACB Weekly ICS Family Errors');
update openchpl.notification_type_permission set deleted = true where notification_type_id = (select id from openchpl.notification_type where "name" = 'ONC Weekly ICS Family Errors');
update openchpl.notification_type_permission set deleted = true where notification_type_id = (select id from openchpl.notification_type where "name" = 'Summary Statistics');
update openchpl.notification_type_permission set deleted = true where notification_type_id = (select id from openchpl.notification_type where "name" = 'Cache Status Age Notification');

-- OCD-2392 - add whitelisting to api keys

ALTER TABLE openchpl.api_key DROP COLUMN IF EXISTS whitelisted;
ALTER TABLE openchpl.api_key ADD COLUMN whitelisted boolean DEFAULT false;
UPDATE openchpl.api_key SET whitelisted = true WHERE api_key_id = 1;

--re-run grants
\i dev/openchpl_grant-all.sql
