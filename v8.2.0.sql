-- remove all acl_entry values for pending certified products
DELETE from openchpl.acl_entry 
WHERE acl_object_identity IN
	( SELECT acl_object_identity.id 
	  FROM openchpl.acl_object_identity, openchpl.acl_class 
	  WHERE acl_object_identity.object_id_class = acl_class.id 
	  AND acl_class.class = 'gov.healthit.chpl.dto.PendingCertifiedProductDTO' );
	  
-- remove all object identity values for pending certified products
DELETE from openchpl.acl_object_identity 
WHERE object_id_class IN
	( SELECT id FROM openchpl.acl_class WHERE acl_class.class = 'gov.healthit.chpl.dto.PendingCertifiedProductDTO' );

-- remove PendingCertifiedProductDTO class reference
DELETE FROM openchpl.acl_class WHERE class = 'gov.healthit.chpl.dto.PendingCertifiedProductDTO'; 

-- update the TestingLab acl class id to 3 so there is no gap in the data; foreign key updates should all be made with cascade
UPDATE openchpl.acl_class SET id = 3 WHERE class = 'gov.healthit.chpl.dto.TestingLabDTO'; 

--set the acl_class id generation sequence back to 4 since that would be the next value
SELECT pg_catalog.setval('openchpl.acl_class_id_seq', 4, true);

