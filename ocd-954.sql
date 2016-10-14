-- Add ONC Staff role to user_permission table to support API ROLE_ONC_STAFF
INSERT INTO openchpl.user_permission(user_permission_id, "name", description, authority, last_modified_user)
    SELECT 7, 'ONC_STAFF' ,'This permission gives a user access to the CMS Download file and report navigation section. It denies editing of Users/Products/CPs/ACBs/etc. No user invitation ability.', 'ROLE_ONC_STAFF' , -1
	WHERE NOT EXISTS 
	(SELECT user_permission_id 
	FROM openchpl.user_permission 
	WHERE user_permission_id = 7);
	