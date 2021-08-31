-- Deployment file for version 20.6.0
--     as of 2021-08-31
-- ./changes/ocd-3702.sql
alter table openchpl.certified_product rename transparency_attestation_url to mandatory_disclosures;
alter table openchpl.pending_certified_product rename vendor_transparency_attestation_url to vendor_mandatory_disclosures;
;
-- ./changes/ocd-3737.sql
DROP VIEW openchpl.certified_product_summary;

DROP VIEW openchpl.certified_product_details CASCADE;

ALTER TABLE openchpl.certified_product DROP COLUMN IF EXISTS rwt_eligibility_year;
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('20.6.0', '2021-08-31', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
