-- no references to this view in the code
DROP VIEW IF EXISTS openchpl.listings_from_banned_developers;

-- dropping these views because they reference the vendor table
-- and i can't delete the column below with them present
DROP VIEW IF EXISTS openchpl.developer_search;
DROP VIEW IF EXISTS openchpl.certified_product_details;
DROP VIEW IF EXISTS openchpl.developer_certification_body_map;
DROP VIEW IF EXISTS openchpl.questionable_activity_combined;
DROP VIEW IF EXISTS openchpl.rwt_plans_by_developer;
DROP VIEW IF EXISTS openchpl.rwt_results_by_developer;
DROP VIEW IF EXISTS openchpl.certified_product_search;
DROP VIEW IF EXISTS openchpl.listing_search;

-- we originally stored only a single "current" status for developers
-- but a long time ago we changed to use a status history type of table 
-- and this PR also removes any remaining references to this column
ALTER TABLE openchpl.vendor DROP COLUMN IF EXISTS vendor_status_id;