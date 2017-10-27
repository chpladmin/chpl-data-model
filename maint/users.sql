/*
 * create contacts
 */
insert into openchpl.contact (first_name, last_name, email, phone_number, signature_date, last_modified_user) values
    ('Andrew', 'Larned', 'alarned@ainq.com', '301-560-6999', now(), -2)
    ,('Andrew', 'ACB', 'alarned@ainq.com', '301-560-6999', now(), -2)
    ,('Katy', 'Ekey','kekey@ainq.com', '4437450987', now(), -2)
    ,('Ashwini', 'More','amore@ainq.com', '301-560-6999', now(), -2)
    ,('Brian', 'Lindsey','blindsey@ainq.com', '4439871013', now(), -2)
    ,('Brian', 'ICSA','blindsey@ainq.com', '4439871013', now(), -2)
    ;

/*
 * create users
 */
insert into openchpl.user (user_name, password, account_expired, account_locked, credentials_expired, account_enabled, compliance_signature, last_modified_user, contact_id) values
    ('andlar', '$2a$10$D039AXXR3qZAoDtotSCj.OlysLVNy8/K6l4Jup4AuOdRrQ1haLwnq', false, false, false, true, now(), -2, (select contact_id from openchpl.contact where first_name = 'Andrew' and last_name = 'Larned' limit 1))
    ,('andlar-acb', '$2a$10$D039AXXR3qZAoDtotSCj.OlysLVNy8/K6l4Jup4AuOdRrQ1haLwnq', false, false, false, true, now(), -2, (select contact_id from openchpl.contact where first_name = 'Andrew' and last_name = 'ACB' limit 1))
    ,('kekey-icsa', '$2a$10$/PEoddTP3Eb7HyDElyIuUOhRT52sbIEV2pvPzuUUSoC0pnVbvEwNG', false, false, false, true, now(), -2, (select contact_id from openchpl.contact where first_name = 'Katy' and last_name = 'Ekey' limit 1))
    ,('amore-icsa', '$2a$10$f7uHfKvQGCrQNVm5twsLk.xllKQk54QAVtSk9sI2z4yTIsqbwyc1G', false, false, false, true, now(), -2, (select contact_id from openchpl.contact where first_name = 'Ashwini' and last_name = 'More' limit 1))
    ,('blindsey', '$2a$10$rryL2dT/QkwWzMcLFhw0GODNQp8cqaT5BXSEpJp.UYTBN5D6PapMu', false, false, false, true, now(), -2, (select contact_id from openchpl.contact where first_name = 'Brian' and last_name = 'Lindsey' limit 1))
    ,('blindsey-icsa', '$2a$10$rryL2dT/QkwWzMcLFhw0GODNQp8cqaT5BXSEpJp.UYTBN5D6PapMu', false, false, false, true, now(), -2, (select contact_id from openchpl.contact where first_name = 'Brian' and last_name = 'ICSA' limit 1))
    ;

/*
 * give users permission on themselves
 */
insert into openchpl.global_user_permission_map (user_id, user_permission_id_user_permission, last_modified_user) values
    ((select user_id from openchpl.user where user_name = 'andlar'), -2, -2)
    ,((select user_id from openchpl.user where user_name = 'andlar-acb'), 2, -2)
    ,((select user_id from openchpl.user where user_name = 'kekey-icsa'), 2, -2)
    ,((select user_id from openchpl.user where user_name = 'amore-icsa'), 2, -2)
    ,((select user_id from openchpl.user where user_name = 'blindsey'), -2, -2)
    ,((select user_id from openchpl.user where user_name = 'blindsey-icsa'), -2, -2)
    ;

/*
 * create sids
 */
insert into openchpl.acl_sid (principal, sid) values
    (true, 'andlar')
    ,(true, 'andlar-acb')
    ,(true, 'kekey-icsa')
    ,(true, 'amore-icsa')
    ,(true, 'blindsey')
    ,(true, 'blindsey-icsa')
    ;

/*
 * identify which sid belongs to which user
 */
insert into openchpl.acl_object_identity (object_id_class, object_id_identity, parent_object, owner_sid, entries_inheriting) values
    (1, (select user_id from openchpl.user where user_name = 'andlar'), null, -2, true)
    ,(1, (select user_id from openchpl.user where user_name = 'andlar-acb'), null, -2, true)
    ,(1, (select user_id from openchpl.user where user_name = 'kekey-icsa'), null, -2, true)
    ,(1, (select user_id from openchpl.user where user_name = 'amore-icsa'), null, -2, true)
    ,(1, (select user_id from openchpl.user where user_name = 'blindsey'), null, -2, true)
    ,(1, (select user_id from openchpl.user where user_name = 'blindsey-icsa'), null, -2, true)
    ;

/*
 * grant acl on each user to themselves
 */
insert into openchpl.acl_entry (acl_object_identity, ace_order, sid, mask, granting, audit_success, audit_failure) values
    ((select id from openchpl.acl_object_identity where object_id_class = 1 and object_id_identity = (select user_id from openchpl.user where user_name = 'andlar')), 0, (select id from openchpl.acl_sid where sid = 'andlar'), 16, true, false, false)
    ,((select id from openchpl.acl_object_identity where object_id_class = 1 and object_id_identity = (select user_id from openchpl.user where user_name = 'andlar-acb')), 0, (select id from openchpl.acl_sid where sid = 'andlar-acb'), 16, true, false, false)
    ,((select id from openchpl.acl_object_identity where object_id_class = 1 and object_id_identity = (select user_id from openchpl.user where user_name = 'kekey-icsa')), 0, (select id from openchpl.acl_sid where sid = 'kekey-icsa'), 16, true, false, false)
    ,((select id from openchpl.acl_object_identity where object_id_class = 1 and object_id_identity = (select user_id from openchpl.user where user_name = 'amore-icsa')), 0, (select id from openchpl.acl_sid where sid = 'amore-icsa'), 16, true, false, false)
    ,((select id from openchpl.acl_object_identity where object_id_class = 1 and object_id_identity = (select user_id from openchpl.user where user_name = 'blindsey')), 0, (select id from openchpl.acl_sid where sid = 'blindsey'), 16, true, false, false)
    ,((select id from openchpl.acl_object_identity where object_id_class = 1 and object_id_identity = (select user_id from openchpl.user where user_name = 'blindsey-icsa')), 0, (select id from openchpl.acl_sid where sid = 'blindsey-icsa'), 16, true, false, false)
    ;

/*
 * grant acl on acbs for each user that wants them
 * must have separate insert statement for each specific user/ACB, otherwise MAX function creates bad primary-key relationship
 */
insert into openchpl.acl_entry (acl_object_identity, ace_order, sid, mask, granting, audit_success, audit_failure) values
    ((select id from openchpl.acl_object_identity where object_id_class = 2 and object_id_identity = (select certification_body_id from openchpl.certification_body where name = 'Drummond Group')), (select max(ace_order) + 1 from openchpl.acl_entry where acl_object_identity = (select id from openchpl.acl_object_identity where object_id_class = 2 and object_id_identity = (select certification_body_id from openchpl.certification_body where name = 'Drummond Group'))), (select id from openchpl.acl_sid where sid = 'andlar-acb'), 16, true, false, false)
    ,((select id from openchpl.acl_object_identity where object_id_class = 2 and object_id_identity = (select certification_body_id from openchpl.certification_body where name = 'ICSA Labs')), (select max(ace_order) + 1 from openchpl.acl_entry where acl_object_identity = (select id from openchpl.acl_object_identity where object_id_class = 2 and object_id_identity = (select certification_body_id from openchpl.certification_body where name = 'ICSA Labs'))), (select id from openchpl.acl_sid where sid = 'andlar-acb'), 16, true, false, false)
    ,((select id from openchpl.acl_object_identity where object_id_class = 2 and object_id_identity = (select certification_body_id from openchpl.certification_body where name = 'InfoGard')), (select max(ace_order) + 1 from openchpl.acl_entry where acl_object_identity = (select id from openchpl.acl_object_identity where object_id_class = 2 and object_id_identity = (select certification_body_id from openchpl.certification_body where name = 'InfoGard'))), (select id from openchpl.acl_sid where sid = 'andlar-acb'), 16, true, false, false)
    ;
insert into openchpl.acl_entry (acl_object_identity, ace_order, sid, mask, granting, audit_success, audit_failure) values
    ((select id from openchpl.acl_object_identity where object_id_class = 2 and object_id_identity = (select certification_body_id from openchpl.certification_body where name = 'ICSA Labs')), (select max(ace_order) + 1 from openchpl.acl_entry where acl_object_identity = (select id from openchpl.acl_object_identity where object_id_class = 2 and object_id_identity = (select certification_body_id from openchpl.certification_body where name = 'ICSA Labs'))), (select id from openchpl.acl_sid where sid = 'kekey-icsa'), 16, true, false, false)
    ;
insert into openchpl.acl_entry (acl_object_identity, ace_order, sid, mask, granting, audit_success, audit_failure) values
    ((select id from openchpl.acl_object_identity where object_id_class = 2 and object_id_identity = (select certification_body_id from openchpl.certification_body where name = 'ICSA Labs')), (select max(ace_order) + 1 from openchpl.acl_entry where acl_object_identity = (select id from openchpl.acl_object_identity where object_id_class = 2 and object_id_identity = (select certification_body_id from openchpl.certification_body where name = 'ICSA Labs'))), (select id from openchpl.acl_sid where sid = 'amore-icsa'), 16, true, false, false)
    ;
insert into openchpl.acl_entry (acl_object_identity, ace_order, sid, mask, granting, audit_success, audit_failure) values
    ((select id from openchpl.acl_object_identity where object_id_class = 2 and object_id_identity = (select certification_body_id from openchpl.certification_body where name = 'ICSA Labs')), (select max(ace_order) + 1 from openchpl.acl_entry where acl_object_identity = (select id from openchpl.acl_object_identity where object_id_class = 2 and object_id_identity = (select certification_body_id from openchpl.certification_body where name = 'ICSA Labs'))), (select id from openchpl.acl_sid where sid = 'blindsey-icsa'), 16, true, false, false)
    ;
