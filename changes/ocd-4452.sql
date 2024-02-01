DROP VIEW IF EXISTS openchpl.product_certification_statuses;
DROP VIEW IF EXISTS openchpl.developer_certification_statuses;
DROP VIEW IF EXISTS openchpl.certified_product_search_result;

-- this index is needed for the function that calculates current status event for a listing
CREATE INDEX IF NOT EXISTS cse_certified_product_id_idx ON openchpl.certification_status_event (certified_product_id);

-- we will trigger questionable activity if the certification status is set far into the future
INSERT INTO openchpl.questionable_activity_trigger (name, level, last_modified_user)
SELECT 'Future Certification Status', 'Listing', -1
WHERE NOT EXISTS (
	SELECT id from openchpl.questionable_activity_trigger where name = 'Future Certification Status'
); 
