---------------------------------------
-- OCD-2683
-- Step 2
-- Drop the ACL backup tables
---------------------------------------

DROP TABLE IF EXISTS openchpl.acl_object_identity_backup_for_atl;
DROP TABLE IF EXISTS openchpl.acl_class_backup_for_atl;
DROP TABLE IF EXISTS openchpl.acl_entry_backup_for_atl;