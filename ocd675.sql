--NOTE you will also need to delete the pending certified products. this can be done all at once or per-ACB which is 
-- why it's not included in this script

--add ACB ACLs
INSERT INTO openchpl.acl_entry (acl_object_identity, ace_order, sid, mask, granting, audit_success, audit_failure) VALUES
(2, (select coalesce(max(ace_order), -1)+1 from acl_entry where acl_object_identity =2), -2, 16, true, false, false),
(3, (select coalesce(max(ace_order), -1)+1 from acl_entry where acl_object_identity =3), -2, 16, true, false, false),
(4, (select coalesce(max(ace_order), -1)+1 from acl_entry where acl_object_identity =4), -2, 16, true, false, false),
(5, (select coalesce(max(ace_order), -1)+1 from acl_entry where acl_object_identity =5), -2, 16, true, false, false),
(6, (select coalesce(max(ace_order), -1)+1 from acl_entry where acl_object_identity =6), -2, 16, true, false, false),
(7, (select coalesce(max(ace_order), -1)+1 from acl_entry where acl_object_identity =7), -2, 16, true, false, false),
(8, (select coalesce(max(ace_order), -1)+1 from acl_entry where acl_object_identity =8), -2, 16, true, false, false);

-- add ATL ACLs
INSERT INTO openchpl.acl_entry (acl_object_identity, ace_order, sid, mask, granting, audit_success, audit_failure) VALUES
(9, (select coalesce(max(ace_order), -1)+1 from acl_entry where acl_object_identity =9), -2, 16, true, false, false),
(10, (select coalesce(max(ace_order), -1)+1 from acl_entry where acl_object_identity =10), -2, 16, true, false, false),
(11, (select coalesce(max(ace_order), -1)+1 from acl_entry where acl_object_identity =11), -2, 16, true, false, false),
(12, (select coalesce(max(ace_order), -1)+1 from acl_entry where acl_object_identity =12), -2, 16, true, false, false),
(13, (select coalesce(max(ace_order), -1)+1 from acl_entry where acl_object_identity =13), -2, 16, true, false, false),
(14, (select coalesce(max(ace_order), -1)+1 from acl_entry where acl_object_identity =14), -2, 16, true, false, false);