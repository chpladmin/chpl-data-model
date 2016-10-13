INSERT INTO openchpl.user_permission(
            user_permission_id, name, description, authority, creation_date, 
            last_modified_date, last_modified_user, deleted)
    SELECT 7, 'ONC STAFF', 
    'This permission gives a user access to the CMS Download file and report navigation section. It denies editing of Users/Products/CPs/ACBs/etc. No user invitation ability.', 
    'ROLE ONC STAFF', localtimestamp, localtimestamp, -1, FALSE
	WHERE NOT EXISTS 
	(SELECT user_permission_id 
	FROM openchpl.user_permission 
	WHERE user_permission_id = 7);