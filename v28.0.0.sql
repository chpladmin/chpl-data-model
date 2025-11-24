-- Deployment file for version 28.0.0
--     as of 2025-11-24
-- ./changes/ocd-4957.sql
DROP VIEW IF EXISTS openchpl.questionable_activity_combined;
DROP VIEW IF EXISTS openchpl.questionable_url_details;
DROP VIEW IF EXISTS openchpl.inactive_developers_and_products;
DROP VIEW IF EXISTS openchpl.certified_product_search;
DROP VIEW IF EXISTS openchpl.cqm_result_details;
DROP VIEW IF EXISTS openchpl.certification_result_details;
DROP VIEW IF EXISTS openchpl.product_active_owner_history_map;
DROP VIEW IF EXISTS openchpl.certified_product_summary;
DROP VIEW IF EXISTS openchpl.ehr_certification_ids_and_products;
DROP VIEW IF EXISTS openchpl.surveillance_basic;
DROP VIEW IF EXISTS openchpl.developer_search;
DROP VIEW IF EXISTS openchpl.developer_certification_body_map;
DROP VIEW IF EXISTS openchpl.requirement_type;
DROP VIEW IF EXISTS openchpl.nonconformity_type;
DROP VIEW IF EXISTS openchpl.rwt_plans_by_developer;
DROP VIEW IF EXISTS openchpl.rwt_results_by_developer;
DROP VIEW IF EXISTS openchpl.subscription_search_result;
DROP VIEW IF EXISTS openchpl.subscription_observation_notification;
DROP VIEW IF EXISTS openchpl.most_recent_past_attestation_period;
DROP VIEW IF EXISTS openchpl.listing_search;
DROP VIEW IF EXISTS openchpl.certified_product_details;

ALTER TABLE openchpl.certification_criterion_attribute DROP COLUMN IF EXISTS gap;
ALTER TABLE openchpl.certification_result DROP COLUMN IF EXISTS gap;
;
-- ./changes/ocd-5053.sql
UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/view-download-and-transmit-3rd-party'
WHERE certification_criterion_id = 178;
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('28.0.0', '2025-11-24', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
