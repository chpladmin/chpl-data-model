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
    ((select id from openchpl.notification_recipient where email = 'amore@ainq.com' and deleted = false), (select id from openchpl.notification_type where "name" = 'ONC Daily Surveillance Broken Rules'), -2)
    ,((select id from openchpl.notification_recipient where email = 'amore@ainq.com' and deleted = false), (select id from openchpl.notification_type where "name" = 'ONC Weekly Surveillance Broken Rules'), -2)
    ,((select id from openchpl.notification_recipient where email = 'amore@ainq.com' and deleted = false), (select id from openchpl.notification_type where "name" = 'ONC Weekly ICS Family Errors'), -2)
	,((select id from openchpl.notification_recipient where email = 'amore@ainq.com' and deleted = false), (select id from openchpl.notification_type where "name" = 'Questionable Activity'), -2)
	,((select id from openchpl.notification_recipient where email = 'amore@ainq.com' and deleted = false), (select id from openchpl.notification_type where "name" = 'Summary Statistics'), -2)
;

/*
 * create acb subscriptionss
 */
insert into openchpl.notification_type_recipient_map (recipient_id, notification_type_id, acb_id, last_modified_user) values
    ((select id from openchpl.notification_recipient where email = 'amore@ainq.com' and deleted = false), (select id from openchpl.notification_type where "name" = 'ONC-ACB Daily Surveillance Broken Rules'), (select certification_body_id from openchpl.certification_body where "name" = 'InfoGard'), -2)
    ,((select id from openchpl.notification_recipient where email = 'amore@ainq.com' and deleted = false), (select id from openchpl.notification_type where "name" = 'ONC-ACB Weekly Surveillance Broken Rules'), (select certification_body_id from openchpl.certification_body where "name" = 'InfoGard'), -2)
    ,((select id from openchpl.notification_recipient where email = 'amore@ainq.com' and deleted = false), (select id from openchpl.notification_type where "name" = 'ONC-ACB Weekly ICS Family Errors'), (select certification_body_id from openchpl.certification_body where "name" = 'InfoGard'), -2)
    ,((select id from openchpl.notification_recipient where email = 'amore@ainq.com' and deleted = false), (select id from openchpl.notification_type where "name" = 'ONC-ACB Daily Surveillance Broken Rules'), (select certification_body_id from openchpl.certification_body where "name" = 'Drummond Group'), -2)
    ,((select id from openchpl.notification_recipient where email = 'amore@ainq.com' and deleted = false), (select id from openchpl.notification_type where "name" = 'ONC-ACB Weekly Surveillance Broken Rules'), (select certification_body_id from openchpl.certification_body where "name" = 'Drummond Group'), -2)
    ,((select id from openchpl.notification_recipient where email = 'amore@ainq.com' and deleted = false), (select id from openchpl.notification_type where "name" = 'ONC-ACB Weekly ICS Family Errors'), (select certification_body_id from openchpl.certification_body where "name" = 'Drummond Group'), -2)
    ,((select id from openchpl.notification_recipient where email = 'amore@ainq.com' and deleted = false), (select id from openchpl.notification_type where "name" = 'ONC-ACB Daily Surveillance Broken Rules'), (select certification_body_id from openchpl.certification_body where "name" = 'ICSA Labs'), -2)
    ,((select id from openchpl.notification_recipient where email = 'amore@ainq.com' and deleted = false), (select id from openchpl.notification_type where "name" = 'ONC-ACB Weekly Surveillance Broken Rules'), (select certification_body_id from openchpl.certification_body where "name" = 'ICSA Labs'), -2)
    ,((select id from openchpl.notification_recipient where email = 'amore@ainq.com' and deleted = false), (select id from openchpl.notification_type where "name" = 'ONC-ACB Weekly ICS Family Errors'), (select certification_body_id from openchpl.certification_body where "name" = 'ICSA Labs'), -2)
;
