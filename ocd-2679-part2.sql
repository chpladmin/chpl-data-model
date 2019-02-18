-- Delete rows from acl_entry relacted to ACBs
DELETE FROM openchpl.acl_entry
WHERE acl_object_identity IN 
	(SELECT aoi."id" 
	FROM openchpl.acl_object_identity aoi
		INNER JOIN openchpl.acl_class ac
			ON aoi.object_id_class = ac."id"
	WHERE ac."class" = 'gov.healthit.chpl.dto.CertificationBodyDTO');

-- Delete rows from acl_object_identity related to ACBs
DELETE FROM openchpl.acl_object_identity
WHERE object_id_class IN 
	(SELECT "id" 
	 FROM openchpl.acl_class 
	 WHERE "class" = 'gov.healthit.chpl.dto.CertificationBodyDTO');

-- Delete rows from acl_class related ro ACBs
DELETE FROM openchpl.acl_class
WHERE "class" = 'gov.healthit.chpl.dto.CertificationBodyDTO';
