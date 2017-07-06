DROP VIEW IF EXISTS openchpl.developers_with_attestations;
CREATE OR REPLACE VIEW openchpl.developers_with_attestations AS
SELECT
v.vendor_id as vendor_id,
v.name as vendor_name,
s.name as status_name,
sum(case when certification_status.certification_status = 'Active' then 1 else 0 end) as countActiveListings,
sum(case when certification_status.certification_status = 'Retired' then 1 else 0 end) as countRetiredListings,
sum(case when certification_status.certification_status = 'Pending' then 1 else 0 end) as countPendingListings,
sum(case when certification_status.certification_status = 'Withdrawn by Developer' then 1 else 0 end) as countWithdrawnByDeveloperListings,
sum(case when certification_status.certification_status = 'Withdrawn by ONC-ACB' then 1 else 0 end) as countWithdrawnByOncAcbListings,
sum(case when certification_status.certification_status = 'Suspended by ONC-ACB' then 1 else 0 end) as countSuspendedByOncAcbListings,
sum(case when certification_status.certification_status = 'Suspended by ONC' then 1 else 0 end) as countSuspendedByOncListings,
sum(case when certification_status.certification_status = 'Terminated by ONC' then 1 else 0 end) as countTerminatedByOncListings,
sum(case when certification_status.certification_status = 'Withdrawn by Developer Under Surveillance/Review' then 1 else 0 end) as countWithdrawnByDeveloperUnderSurveillanceListings,

--only include urls that are not empty strings and come from
-- a listing with one of the active... or suspended... statuses
string_agg(DISTINCT 
	case when 
		listings.transparency_attestation_url::text != '' 
		and 
			(certification_status.certification_status = 'Active' 
			or
			certification_status.certification_status = 'Suspended by ONC'
			or 
			certification_status.certification_status = 'Suspended by ONC-ACB')
		then listings.transparency_attestation_url::text else null end, '☺') 
	as "transparency_attestation_urls",
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

------------
-- OCD-1408
------------

DROP TABLE IF EXISTS openchpl.pending_surveillance_validation;
DROP TYPE IF EXISTS openchpl.validation_message_type;

CREATE TYPE openchpl.validation_message_type as enum('Error', 'Warning');
CREATE TABLE openchpl.pending_surveillance_validation (
	id bigserial NOT NULL,
	pending_surveillance_id bigint NOT NULL,
	message_type openchpl.validation_message_type NOT NULL,
	message text NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT pending_surveillance_validation_pk PRIMARY KEY (id),
	CONSTRAINT pending_surveillance_fk FOREIGN KEY (pending_surveillance_id) 
		REFERENCES openchpl.pending_surveillance (id) 
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE	
);

CREATE TRIGGER pending_surveillance_validation_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_surveillance_validation FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_surveillance_validation_timestamp BEFORE UPDATE on openchpl.pending_surveillance_validation FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

-- Note: The user calling this script must be in the same directory as v-next. 
--re-run grants
\i dev/openchpl_grant-all.sql