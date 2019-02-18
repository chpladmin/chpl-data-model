---------------------------------------
-- OCD-2679
-- Step 3
-- Drop the ACL backup tables
---------------------------------------

DROP TABLE IF EXISTS openchpl.acl_object_identity_backup;
DROP TABLE IF EXISTS openchpl.acl_class_backup;
DROP TABLE IF EXISTS openchpl.acl_entry_backup;