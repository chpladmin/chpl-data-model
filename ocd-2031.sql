--
-- OCD-2031
    --
insert into openchpl.notification_type (name, description, requires_acb, last_modified_user) select 'Cache Status Age Notification', 'A notification that is sent to subscribers when the Listing Cache is too old.', false, -1 where not exists (select * from openchpl.notification_type where name = 'Cache Status Age Notification');
create or replace function openchpl.add_permission() returns void as $$
    begin
    if (select count(*) from openchpl.notification_type_permission where notification_type_id =
	(select id from openchpl.notification_type where name = 'Cache Status Age Notification')) = 0 then
insert into openchpl.notification_type_permission (notification_type_id, permission_id, last_modified_user)
select id, -2, -1 from openchpl.notification_type where name = 'Cache Status Age Notification';
    end if;
    end;
    $$ language plpgsql;
select openchpl.add_permission();
drop function openchpl.add_permission();
