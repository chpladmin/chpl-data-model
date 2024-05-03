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

-- TODO add these subjects to existing listing subscriptions