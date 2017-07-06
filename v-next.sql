DROP VIEW IF EXISTS openchpl.developers_with_attestations;
CREATE OR REPLACE VIEW openchpl.developers_with_attestations AS
SELECT
v.vendor_id as vendor_id,
v.name as vendor_name,
s.name as status_name,
sum(case when certification_status.certification_status = 'Active' then 1 else 0 end) as countActiveListings,
sum(case when certification_status.certification_status = 'Retired' then 1 else 0 end) as countRetiredListings,
sum(case when certification_status.certification_status = 'Withdrawn by Developer' then 1 else 0 end) as countWithdrawnByDeveloperListings,
sum(case when certification_status.certification_status = 'Withdrawn by ONC-ACB' then 1 else 0 end) as countWithdrawnByOncAcbListings,
sum(case when certification_status.certification_status = 'Suspended by ONC-ACB' then 1 else 0 end) as countSuspendedByOncAcbListings,
sum(case when certification_status.certification_status = 'Suspended by ONC' then 1 else 0 end) as countSuspendedByOncListings,
sum(case when certification_status.certification_status = 'Terminated by ONC' then 1 else 0 end) as countTerminatedByOncListings,
sum(case when certification_status.certification_status = 'Withdrawn by Developer Under Surveillance/Review' then 1 else 0 end) as countWithdrawnByDeveloperUnderSurveillanceListings,
string_agg(DISTINCT listings.transparency_attestation_url::text, '☺') as "transparency_attestation_urls",
--using coalesce here because the attestation can be null and concatting null with anything just gives null
--so null/empty attestations are left out unless we replace null with empty string
string_agg(DISTINCT acb.name::text||':'||COALESCE(attestations.transparency_attestation::text, ''), '☺') as "attestations"
FROM openchpl.vendor v
LEFT OUTER JOIN openchpl.vendor_status s ON v.vendor_status_id = s.vendor_status_id
LEFT OUTER JOIN openchpl.certified_product_details listings ON listings.vendor_id = v.vendor_id AND listings.deleted != true
LEFT OUTER JOIN openchpl.certification_status ON listings.certification_status_id = certification_status.certification_status_id
LEFT OUTER JOIN openchpl.acb_vendor_map attestations ON attestations.vendor_id = v.vendor_id AND attestations.deleted != true
LEFT OUTER JOIN openchpl.certification_body acb ON attestations.certification_body_id = acb.certification_body_id AND acb.deleted != true

WHERE v.deleted != true
GROUP BY v.vendor_id, v.name, s.name;

-- Note: The user calling this script must be in the same directory as v-next. 
--re-run grants
\i dev/openchpl_grant-all.sql