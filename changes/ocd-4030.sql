INSERT INTO openchpl.user_permission (name, description, authority, last_modified_user)
SELECT 'STARTUP', 'This permission allows a user to use APIs needed for system startup', 'ROLE_STARTUP', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.user_permission
    WHERE name = 'STARTUP'
);

