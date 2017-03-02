create or replace function openchpl.insert_sid_for_pending_cp (
        sid bigint
        )
    returns void as $$
    declare
    rec record;
    get_object text;

    begin
    get_object := 'select id from openchpl.acl_object_identity where object_id_class = 3';

    for rec in execute get_object
    loop
    execute 'insert into openchpl.acl_entry (acl_object_identity, ace_order, sid, mask, granting, audit_success, audit_failure) values ($1, (select max(ace_order) + 1 from openchpl.acl_entry where acl_object_identity = $1), $2, 16, true, false, false);' using rec.id, sid;
    end loop;
    end;
    $$ language plpgsql;

insert into openchpl.contact (first_name, last_name, email, phone_number, signature_date, last_modified_user) values
    ('Andrew', 'Larned', 'alarned@ainq.com', '301-560-6999', now(), -2),
    ('Andrew', 'ACB', 'alarned@ainq.com', '301-560-6999', now(), -2);

insert into openchpl.user (user_name, password, account_expired, account_locked, credentials_expired, account_enabled, compliance_signature, last_modified_user, contact_id) values
    ('andlar-test', '$2a$10$D039AXXR3qZAoDtotSCj.OlysLVNy8/K6l4Jup4AuOdRrQ1haLwnq', false, false, false, true, now(), -2, (select contact_id from openchpl.contact where first_name = 'Andrew' and last_name = 'Larned' limit 1)),
    ('andlar-test-acb', '$2a$10$D039AXXR3qZAoDtotSCj.OlysLVNy8/K6l4Jup4AuOdRrQ1haLwnq', false, false, false, true, now(), -2, (select contact_id from openchpl.contact where first_name = 'Andrew' and last_name = 'ACB' limit 1));

insert into openchpl.global_user_permission_map (user_id, user_permission_id_user_permission, last_modified_user) values
    ((select user_id from openchpl.user where user_name = 'andlar-test'), -2, -2),
    ((select user_id from openchpl.user where user_name = 'andlar-test-acb'), 2, -2);

insert into openchpl.acl_sid (principal, sid) values
    (true, 'andlar-test'),
    (true, 'andlar-test-acb');

insert into openchpl.acl_object_identity (object_id_class, object_id_identity, parent_object, owner_sid, entries_inheriting) values
    (1, (select user_id from openchpl.user where user_name = 'andlar-test'), null, -2, true),
    (1, (select user_id from openchpl.user where user_name = 'andlar-test-acb'), null, -2, true);

insert into openchpl.acl_entry (acl_object_identity, ace_order, sid, mask, granting, audit_success, audit_failure) values
    ((select id from openchpl.acl_object_identity where object_id_class = 1 and object_id_identity = (select user_id from openchpl.user where user_name = 'andlar-test')), 0, (select id from openchpl.acl_sid where sid = 'andlar-test'), 16, true, false, false),
    ((select id from openchpl.acl_object_identity where object_id_class = 1 and object_id_identity = (select user_id from openchpl.user where user_name = 'andlar-test-acb')), 0, (select id from openchpl.acl_sid where sid = 'andlar-test-acb'), 16, true, false, false),
    ((select id from openchpl.acl_object_identity where object_id_class = 2 and object_id_identity = (select certification_body_id from openchpl.certification_body where name = 'Drummond Group')), (select max(ace_order) + 1 from openchpl.acl_entry where acl_object_identity = (select id from openchpl.acl_object_identity where object_id_class = 2 and object_id_identity = (select certification_body_id from openchpl.certification_body where name = 'Drummond Group'))), (select id from openchpl.acl_sid where sid = 'andlar-test-acb'), 16, true, false, false),
    ((select id from openchpl.acl_object_identity where object_id_class = 2 and object_id_identity = (select certification_body_id from openchpl.certification_body where name = 'ICSA Labs')), (select max(ace_order) + 1 from openchpl.acl_entry where acl_object_identity = (select id from openchpl.acl_object_identity where object_id_class = 2 and object_id_identity = (select certification_body_id from openchpl.certification_body where name = 'ICSA Labs'))), (select id from openchpl.acl_sid where sid = 'andlar-test-acb'), 16, true, false, false),
    ((select id from openchpl.acl_object_identity where object_id_class = 2 and object_id_identity = (select certification_body_id from openchpl.certification_body where name = 'InfoGard')), (select max(ace_order) + 1 from openchpl.acl_entry where acl_object_identity = (select id from openchpl.acl_object_identity where object_id_class = 2 and object_id_identity = (select certification_body_id from openchpl.certification_body where name = 'InfoGard'))), (select id from openchpl.acl_sid where sid = 'andlar-test-acb'), 16, true, false, false);

select openchpl.insert_sid_for_pending_cp((select id from openchpl.acl_sid where sid = 'andlar-test-acb'));

drop function openchpl.insert_sid_for_pending_cp(bigint);
