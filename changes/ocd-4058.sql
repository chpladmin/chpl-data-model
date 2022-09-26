-- delete the orphaned version
DELETE FROM openchpl.product_version
WHERE product_version_id = 8583;

-- delete version split + version creation activities
DELETE FROM openchpl.activity
WHERE activity_id = 89349;

DELETE FROM openchpl.activity
WHERE activity_id = 89348;
