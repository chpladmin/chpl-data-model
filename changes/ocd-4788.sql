-------------
-- DROP 'title' from contact objects
-------------

-- some views depended upon 'title' and some other views depended upon those views, so... just drop all the views for now to make things easier
DROP VIEW IF EXISTS openchpl.questionable_activity_combined;
DROP VIEW IF EXISTS openchpl.inactive_developers_and_products;
DROP VIEW IF EXISTS openchpl.certified_product_search;
DROP VIEW IF EXISTS openchpl.certified_product_details;
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

ALTER TABLE openchpl.contact DROP COLUMN IF EXISTS title;
ALTER TABLE openchpl.change_request_developer_demographics DROP COLUMN IF EXISTS title;


-------------
-- DROP 'friendly_name' from contact objects
-------------
ALTER TABLE openchpl.contact DROP COLUMN IF EXISTS friendly_name;

-------------
-- DROP *_statistics tables that are no longer used
-------------
DROP TABLE IF EXISTS openchpl.listing_count_statistics;
DROP TABLE IF EXISTS openchpl.incumbent_developers_statistics;
DROP TABLE IF EXISTS openchpl.criterion_product_statistics;
DROP TABLE IF EXISTS openchpl.participant_age_statistics;
DROP TABLE IF EXISTS openchpl.participant_education_statistics;
DROP TABLE IF EXISTS openchpl.participant_experience_statistics;
DROP TABLE IF EXISTS openchpl.participant_gender_statistics;
DROP TABLE IF EXISTS openchpl.sed_participants_statistics_count;






