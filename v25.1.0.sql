-- Deployment file for version 25.1.0
--     as of 2024-08-19
-- ./changes/ocd-4483.sql
DROP TRIGGER IF EXISTS subscription_observation_audit ON subscription_observation;
DROP TRIGGER IF EXISTS subscription_observation_timestamp ON subscription_observation;
DROP TRIGGER IF EXISTS subscription_observation_last_modified_user_constraint ON openchpl.subscription_observation;

ALTER TABLE openchpl.subscription_observation
ADD COLUMN IF NOT EXISTS notified_at timestamp;

-- If a subscription is not deleted then the only way it's observations could have been deleted would have
-- been because the user was notified about them. So for every deleted observation related to every 
-- non-deleted subscription, we can fill in the notified_at timestamp.
UPDATE openchpl.subscription_observation obs1 
SET notified_at = 
	(SELECT obs2.last_modified_date 
		FROM openchpl.subscription_observation obs2 
		JOIN openchpl.subscription sub ON obs2.subscription_id = sub.id AND sub.deleted = false
		WHERE obs1.id = obs2.id)
WHERE notified_at IS NULL;


CREATE OR REPLACE TRIGGER subscription_observation_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.subscription_observation FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE OR REPLACE TRIGGER subscription_observation_timestamp BEFORE UPDATE on openchpl.subscription_observation FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE CONSTRAINT TRIGGER subscription_observation_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.subscription_observation DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();;
-- ./changes/ocd-4615.sql
create table if not exists openchpl.forgot_password (
    id bigserial not null,
    token uuid not null,
    email text not null,
    creation_date timestamp not null default now(),
    last_modified_date timestamp not null default now(),
    last_modified_user bigint,
    last_modified_sso_user uuid,
    deleted bool not null default false,
	constraint forgot_password_pk primary key (id)
);

CREATE or replace TRIGGER forgot_password_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.forgot_password FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE or replace TRIGGER forgot_password_timestamp BEFORE UPDATE on openchpl.forgot_password FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS forgot_password_last_modified_user_constraint ON openchpl.forgot_password;
CREATE CONSTRAINT TRIGGER forgot_password_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.forgot_password DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('25.1.0', '2024-08-19', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
