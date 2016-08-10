INSERT INTO openchpl.user_permission (user_permission_id, "name", description, authority, last_modified_user) VALUES
(6, 'CMS_STAFF' ,'This permission gives a user read access to CMS reports.','ROLE_CMS_STAFF' , -1);

SELECT pg_catalog.setval('openchpl.user_permission_user_permission_id_seq', 7, true);
