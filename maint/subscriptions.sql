/*
 * delete old subscriptions
 */
update openchpl.notification_recipient set deleted = true;
update openchpl.notification_type_recipient_map set deleted = true;

/*
 * create emails
 */
insert into openchpl.notification_recipient (email, last_modified_user) values
    ('amore@ainq.com', -2)
;

/*
 * create non-acb subscriptionss
 */
insert into openchpl.notification_type_recipient_map (recipient_id, notification_type_id, last_modified_user) values
    ((select id from openchpl.notification_recipient where email = 'amore@ainq.com' and deleted = false), 3, -2)
    ,((select id from openchpl.notification_recipient where email = 'amore@ainq.com' and deleted = false), 4, -2)
    ,((select id from openchpl.notification_recipient where email = 'amore@ainq.com' and deleted = false), 6, -2)
;

/*
 * create acb subscriptionss
 */
insert into openchpl.notification_type_recipient_map (recipient_id, notification_type_id, acb_id, last_modified_user) values
    ((select id from openchpl.notification_recipient where email = 'amore@ainq.com' and deleted = false), 1, 3, -2)
    ,((select id from openchpl.notification_recipient where email = 'amore@ainq.com' and deleted = false), 2, 3, -2)
    ,((select id from openchpl.notification_recipient where email = 'amore@ainq.com' and deleted = false), 5, 3, -2)
    ,((select id from openchpl.notification_recipient where email = 'amore@ainq.com' and deleted = false), 1, 6, -2)
    ,((select id from openchpl.notification_recipient where email = 'amore@ainq.com' and deleted = false), 2, 6, -2)
    ,((select id from openchpl.notification_recipient where email = 'amore@ainq.com' and deleted = false), 5, 6, -2)
    ,((select id from openchpl.notification_recipient where email = 'amore@ainq.com' and deleted = false), 1, 1, -2)
    ,((select id from openchpl.notification_recipient where email = 'amore@ainq.com' and deleted = false), 2, 1, -2)
    ,((select id from openchpl.notification_recipient where email = 'amore@ainq.com' and deleted = false), 5, 1, -2)
;
