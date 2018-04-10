--
-- OCD-2031
--
insert into openchpl.notification_type (name, description, requires_acb, last_modified_user) select 'Cache Status Age Notification', 'A notification that is sent to subscribers when the Listing Cache is too old.', false, -1 where not exists (select * from openchpl.notification_type where name = 'Cache Status Age Notification');
