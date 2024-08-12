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
CREATE CONSTRAINT TRIGGER subscription_observation_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.subscription_observation DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();