INSERT INTO openchpl.subscription_subject (subscription_object_type_id, subject, last_modified_user)
SELECT 1, 'RWT Plans URL Changed', -1
WHERE NOT EXISTS (
	SELECT id FROM openchpl.subscription_subject WHERE subject = 'RWT Plans URL Changed'
);

INSERT INTO openchpl.subscription_subject (subscription_object_type_id, subject, last_modified_user)
SELECT 1, 'RWT Results URL Changed', -1
WHERE NOT EXISTS (
	SELECT id FROM openchpl.subscription_subject WHERE subject = 'RWT Results URL Changed'
);

INSERT INTO openchpl.subscription_subject (subscription_object_type_id, subject, last_modified_user)
SELECT 1, 'Service Base URL List Changed', -1
WHERE NOT EXISTS (
	SELECT id FROM openchpl.subscription_subject WHERE subject = 'Service Base URL List Changed'
);

-- Add these subjects to existing listing subscriptions
DROP FUNCTION IF EXISTS openchpl.create_missing_subscriptions_for_new_subjects();
CREATE FUNCTION openchpl.create_missing_subscriptions_for_new_subjects()
  RETURNS void AS $$
	DECLARE
		unique_subscription_rec record;
		subject_id bigint;
	BEGIN
		FOR unique_subscription_rec IN
			SELECT DISTINCT subscriber_id, subscribed_object_id, creation_date FROM openchpl.subscription
		LOOP
		
			-- RWT Plans URL Subjects
			SELECT id INTO subject_id FROM openchpl.subscription_subject WHERE subject = 'RWT Plans URL Changed';
			
			IF (SELECT COUNT(*) FROM openchpl.subscription WHERE subscriber_id = unique_subscription_rec.subscriber_id AND subscription_subject_id = subject_id AND subscribed_object_id = unique_subscription_rec.subscribed_object_id AND subscription_consolidation_method_id = 1 AND deleted = false)>0 THEN
				-- subscriptions already exists, print notice
				RAISE NOTICE 'Subscription for subscriber %, subject %, object % already exists', unique_subscription_rec.subscriber_id, subject_id, unique_subscription_rec.subscribed_object_id;
			ELSE
				-- insert the subscription
				INSERT INTO openchpl.subscription (subscriber_id, subscription_subject_id, subscribed_object_id, subscription_consolidation_method_id, creation_date, last_modified_user)
				VALUES (unique_subscription_rec.subscriber_id, subject_id, unique_subscription_rec.subscribed_object_id, 1, unique_subscription_rec.creation_date, -1);
				RAISE NOTICE 'Added subscription for subscriber %, subject %, object % already exists', unique_subscription_rec.subscriber_id, subject_id, unique_subscription_rec.subscribed_object_id;
			END IF;
		
			-- RWT Results URL subjects
			SELECT id INTO subject_id FROM openchpl.subscription_subject WHERE subject = 'RWT Results URL Changed';
			
			IF (SELECT COUNT(*) FROM openchpl.subscription WHERE subscriber_id = unique_subscription_rec.subscriber_id AND subscription_subject_id = subject_id AND subscribed_object_id = unique_subscription_rec.subscribed_object_id AND subscription_consolidation_method_id = 1 AND deleted = false)>0 THEN
				-- subscriptions already exists, print notice
				RAISE NOTICE 'Subscription for subscriber %, subject %, object % already exists', unique_subscription_rec.subscriber_id, subject_id, unique_subscription_rec.subscribed_object_id;
			ELSE
				-- insert the subscription
				INSERT INTO openchpl.subscription (subscriber_id, subscription_subject_id, subscribed_object_id, subscription_consolidation_method_id, creation_date, last_modified_user)
				VALUES (unique_subscription_rec.subscriber_id, subject_id, unique_subscription_rec.subscribed_object_id, 1, unique_subscription_rec.creation_date, -1);
				RAISE NOTICE 'Added subscription for subscriber %, subject %, object % already exists', unique_subscription_rec.subscriber_id, subject_id, unique_subscription_rec.subscribed_object_id;
			END IF;
			
			-- Service Base URL List subjects
			SELECT id INTO subject_id FROM openchpl.subscription_subject WHERE subject = 'Service Base URL List Changed';
			
			IF (SELECT COUNT(*) FROM openchpl.subscription WHERE subscriber_id = unique_subscription_rec.subscriber_id AND subscription_subject_id = subject_id AND subscribed_object_id = unique_subscription_rec.subscribed_object_id AND subscription_consolidation_method_id = 1 AND deleted = false)>0 THEN
				-- subscriptions already exists, print notice
				RAISE NOTICE 'Subscription for subscriber %, subject %, object % already exists', unique_subscription_rec.subscriber_id, subject_id, unique_subscription_rec.subscribed_object_id;
			ELSE
				-- insert the subscription
				INSERT INTO openchpl.subscription (subscriber_id, subscription_subject_id, subscribed_object_id, subscription_consolidation_method_id, creation_date, last_modified_user)
				VALUES (unique_subscription_rec.subscriber_id, subject_id, unique_subscription_rec.subscribed_object_id, 1, unique_subscription_rec.creation_date, -1);
				RAISE NOTICE 'Added subscription for subscriber %, subject %, object % already exists', unique_subscription_rec.subscriber_id, subject_id, unique_subscription_rec.subscribed_object_id;
			END IF;
			

		END LOOP;
		RETURN;
	END;
$$ language plpgsql
volatile;

SELECT openchpl.create_missing_subscriptions_for_new_subjects();
DROP FUNCTION openchpl.create_missing_subscriptions_for_new_subjects();

