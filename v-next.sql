----------------------------------------------------
-- OCD-2609 Add ROLE_ONC
----------------------------------------------------
INSERT INTO openchpl.user_permission
    (name, description, authority, last_modified_user)
SELECT 'ONC', 'This permission gives ONC users administrative privileges.', 'ROLE_ONC', -1
WHERE
    NOT EXISTS (
        SELECT name FROM openchpl.user_permission WHERE name = 'ONC'
    );
----------------------------------------------------
-- OCD-2609 Convert all current ROLE_ADMIN users
-- (except our admin) to ROLE_ONC.
----------------------------------------------------
UPDATE openchpl.global_user_permission_map 
SET user_permission_id_user_permission = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ONC')
WHERE user_permission_id_user_permission = -2
AND user_id != -2; -- our admin

----------------------------------------------------
-- OCD-2615 Remove ROLE_ONC_STAFF
----------------------------------------------------
-- mark all ROLE_ONC_STAFF user permissions as deleted
UPDATE openchpl.global_user_permission_map
SET deleted = true, last_modified_user = -1
WHERE user_permission_id_user_permission = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ONC_STAFF');

UPDATE openchpl.invited_user_permission
SET deleted = true, last_modified_user = -1
WHERE user_permission_id = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ONC_STAFF');

-- insert a row for a ROLE_ONC role where there was a row for ROLE_ONC_STAFF
INSERT INTO openchpl.global_user_permission_map (user_id, user_permission_id_user_permission, last_modified_user)
SELECT user_id, (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ONC'), -1
	FROM openchpl.global_user_permission_map	
	WHERE user_permission_id_user_permission = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ONC_STAFF')
	AND user_id NOT IN 
		(SELECT DISTINCT user_id 
		FROM openchpl.global_user_permission_map 
		WHERE user_permission_id_user_permission = (SELECT user_permission_id FROM openchpl.user_permission WHERE name = 'ONC'));

UPDATE openchpl.user_permission SET deleted = true, last_modified_user = -1 WHERE name = 'ONC_STAFF';

--OCD-2635
-- Update pending test task and participant id values to be first 20 characters if they are too long
UPDATE openchpl.pending_test_participant
SET test_participant_unique_id = left(test_participant_unique_id, 20)
WHERE length(test_participant_unique_id) > 20;

UPDATE openchpl.pending_test_task
SET test_task_unique_id = left(test_task_unique_id, 20)
WHERE length(test_task_unique_id) > 20;

ALTER TABLE openchpl.pending_test_participant ALTER COLUMN test_participant_unique_id TYPE varchar(20);

ALTER TABLE openchpl.pending_test_task ALTER COLUMN test_task_unique_id TYPE varchar(20);


--re-add soft delete triggers
\i dev/openchpl_soft-delete.sql

insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values
    ('15.1.0', '2019-01-14', -1);

alter table openchpl.certification_body drop column if exists retirement_date;
alter table openchpl.testing_lab drop column if exists retirement_date;
alter table openchpl.certification_body add column retirement_date timestamp;
alter table openchpl.testing_lab add column retirement_date timestamp;

update openchpl.certification_body set retirement_date = '2014-05-01' where name = 'CCHIT';
update openchpl.certification_body set retirement_date = '2013-04-04' where name = 'Surescripts LLC';
update openchpl.testing_lab set retirement_date = '2014-05-01' where name = 'CCHIT';
