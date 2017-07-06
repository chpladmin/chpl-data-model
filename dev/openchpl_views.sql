CREATE OR REPLACE VIEW openchpl.certification_result_details AS

SELECT
    a.certification_result_id,
    a.certified_product_id,
    a.certification_criterion_id,
    a.success,
    a.deleted,
    a.gap,
    a.sed,
    a.g1_success,
    a.g2_success,
    a.api_documentation,
    a.privacy_security_framework,
    b.number,
    b.title,
    COALESCE(d.count_additional_software, 0) as "count_additional_software"
FROM openchpl.certification_result a

    LEFT JOIN (SELECT certification_criterion_id, number, title FROM openchpl.certification_criterion) b
	ON a.certification_criterion_id = b.certification_criterion_id
    LEFT JOIN (SELECT certification_result_id, count(*) as "count_additional_software"
	FROM
		(SELECT * FROM openchpl.certification_result_additional_software WHERE deleted <> true) c GROUP BY certification_result_id) d
	ON a.certification_result_id = d.certification_result_id;

-- ALTER VIEW openchpl.certification_result_details OWNER TO openchpl;

CREATE OR REPLACE VIEW openchpl.cqm_result_details AS

SELECT
    a.cqm_result_id,
    a.certified_product_id,
    a.success,
    a.cqm_criterion_id,
    a.deleted,
    b.number,
    b.cms_id,
    b.title,
    b.description,
    b.cqm_domain,
    b.nqf_number,
    b.cqm_criterion_type_id,
    c.cqm_version_id,
    c.version,
    COALESCE(b.cms_id, b.nqf_number) as cqm_id
FROM openchpl.cqm_result a
    LEFT JOIN openchpl.cqm_criterion b ON a.cqm_criterion_id = b.cqm_criterion_id
    LEFT JOIN openchpl.cqm_version c ON b.cqm_version_id = c.cqm_version_id;

-- ALTER VIEW openchpl.cqm_result_details OWNER TO openchpl;

CREATE OR REPLACE VIEW openchpl.certified_product_details AS

SELECT
    a.certified_product_id,
    a.certification_edition_id,
    a.product_version_id,
    a.testing_lab_id,
    a.certification_body_id,
    a.chpl_product_number,
    a.report_file_location,
    a.sed_report_file_location,
    a.sed_intended_user_description,
    a.sed_testing_end,
    a.acb_certification_id,
    a.practice_type_id,
    a.product_classification_type_id,
    a.other_acb,
	a.creation_date,
    a.deleted,
    a.product_code,
    a.version_code,
    a.ics_code,
    a.additional_software_code,
    a.certified_date_code,
    a.transparency_attestation_url,
    a.ics,
    a.sed,
    a.qms,
    a.accessibility_certified,
    a.product_additional_software,
    a.last_modified_date,
    a.meaningful_use_users,	
    b.year,
    c.certification_body_name,
    c.certification_body_code,
    c.acb_is_deleted,
    d.product_classification_name,
    e.practice_type_name,
    f.product_version,
    f.product_id,
    g.product_name,
    g.vendor_id,
    h.vendor_name,
    h.vendor_code,
    h.vendor_website,
	v.vendor_status_id,
	v.vendor_status_name,
	vendorStatus.last_vendor_status_change,
    t.address_id,
    t.street_line_1,
    t.street_line_2,
    t.city,
    t.state,
    t.zipcode,
    t.country,
    u.contact_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.title,
    i.certification_date,
	decert.decertification_date,
    COALESCE(k.count_certifications, 0) as "count_certifications",
    COALESCE(m.count_cqms, 0) as "count_cqms",
	COALESCE(surv.count_surveillance_activities, 0) as "count_surveillance_activities",
    COALESCE(surv_open.count_open_surveillance_activities, 0) as "count_open_surveillance_activities",
	COALESCE(surv_closed.count_closed_surveillance_activities, 0) as "count_closed_surveillance_activities",
    COALESCE(nc_open.count_open_nonconformities, 0) as "count_open_nonconformities",
	COALESCE(nc_closed.count_closed_nonconformities, 0) as "count_closed_nonconformities",
	r.certification_status_id,
	r.last_certification_status_change,
    n.certification_status_name,
    p.transparency_attestation,
    q.testing_lab_name,
    q.testing_lab_code

FROM openchpl.certified_product a
	LEFT JOIN (SELECT cse.certification_status_id as "certification_status_id", cse.certified_product_id as "certified_product_id",
			cse.event_date as "last_certification_status_change"
				FROM openchpl.certification_status_event cse
				INNER JOIN (
					SELECT certified_product_id, MAX(event_date) event_date
					FROM openchpl.certification_status_event
					GROUP BY certified_product_id
				) cseInner 
				ON cse.certified_product_id = cseInner.certified_product_id AND cse.event_date = cseInner.event_date) r
		ON r.certified_product_id = a.certified_product_id
    LEFT JOIN (SELECT certification_status_id, certification_status as "certification_status_name" FROM openchpl.certification_status) n on r.certification_status_id = n.certification_status_id
    LEFT JOIN (SELECT certification_edition_id, year FROM openchpl.certification_edition) b on a.certification_edition_id = b.certification_edition_id
    LEFT JOIN (SELECT certification_body_id, name as "certification_body_name", acb_code as "certification_body_code", deleted as "acb_is_deleted" FROM openchpl.certification_body) c on a.certification_body_id = c.certification_body_id
    LEFT JOIN (SELECT product_classification_type_id, name as "product_classification_name" FROM openchpl.product_classification_type) d on a.product_classification_type_id = d.product_classification_type_id
    LEFT JOIN (SELECT practice_type_id, name as "practice_type_name" from openchpl.practice_type) e on a.practice_type_id = e.practice_type_id
    LEFT JOIN (SELECT product_version_id, version as "product_version", product_id from openchpl.product_version) f on a.product_version_id = f.product_version_id
    LEFT JOIN (SELECT product_id, vendor_id, name as "product_name" FROM openchpl.product) g ON f.product_id = g.product_id
    LEFT JOIN (SELECT vendor_id, name as "vendor_name", vendor_code, website as "vendor_website", address_id as "vendor_address", contact_id as "vendor_contact", vendor_status_id from openchpl.vendor) h on g.vendor_id = h.vendor_id
    LEFT JOIN (SELECT vendor_id, certification_body_id, transparency_attestation from openchpl.acb_vendor_map) p on h.vendor_id = p.vendor_id and a.certification_body_id = p.certification_body_id
    LEFT JOIN (SELECT address_id, street_line_1, street_line_2, city, state, zipcode, country from openchpl.address) t on h.vendor_address = t.address_id
    LEFT JOIN (SELECT contact_id, first_name, last_name, email, phone_number, title from openchpl.contact) u on h.vendor_contact = u.contact_id
	LEFT JOIN (SELECT vsHistory.vendor_status_id as "vendor_status_id", vsHistory.vendor_id as "vendor_id",
			vsHistory.status_date as "last_vendor_status_change"
				FROM openchpl.vendor_status_history vsHistory
				INNER JOIN (
					SELECT vendor_id, MAX(status_date) status_date
					FROM openchpl.vendor_status_history
					WHERE deleted = false
					GROUP BY vendor_id
				) vsInner 
				ON vsHistory.vendor_id = vsInner.vendor_id AND vsHistory.status_date = vsInner.status_date) vendorStatus
		ON vendorStatus.vendor_id = h.vendor_id
	LEFT JOIN (SELECT vendor_status_id, name as "vendor_status_name" from openchpl.vendor_status) v on vendorStatus.vendor_status_id = v.vendor_status_id
	LEFT JOIN (SELECT MIN(event_date) as "certification_date", certified_product_id from openchpl.certification_status_event where certification_status_id = 1 group by (certified_product_id)) i on a.certified_product_id = i.certified_product_id
	LEFT JOIN (SELECT MAX(event_date) as "decertification_date", certified_product_id from openchpl.certification_status_event where certification_status_id IN (3, 4, 8) group by (certified_product_id)) decert on a.certified_product_id = decert.certified_product_id
    LEFT JOIN (SELECT certified_product_id, count(*) as "count_certifications" FROM (SELECT * FROM openchpl.certification_result WHERE success = true AND deleted <> true) j GROUP BY certified_product_id) k ON a.certified_product_id = k.certified_product_id
    LEFT JOIN (SELECT certified_product_id, count(*) as "count_cqms" FROM (SELECT DISTINCT ON (cqm_id, certified_product_id) * FROM openchpl.cqm_result_details WHERE success = true AND deleted <> true) l GROUP BY certified_product_id ORDER BY certified_product_id) m ON a.certified_product_id = m.certified_product_id
    LEFT JOIN (SELECT certified_product_id, count(*) as "count_surveillance_activities" FROM (SELECT * FROM openchpl.surveillance WHERE deleted <> true) n GROUP BY certified_product_id) surv ON a.certified_product_id = surv.certified_product_id
    LEFT JOIN (SELECT certified_product_id, count(*) as "count_open_surveillance_activities" FROM
	    (SELECT * FROM openchpl.surveillance 
		 WHERE openchpl.surveillance.deleted <> true 
		 AND start_date <= NOW() 
		 AND (end_date IS NULL OR end_date >= NOW())) n GROUP BY certified_product_id) surv_open
    ON a.certified_product_id = surv_open.certified_product_id
	LEFT JOIN (SELECT certified_product_id, count(*) as "count_closed_surveillance_activities" FROM
	    (SELECT * FROM openchpl.surveillance 
		 WHERE openchpl.surveillance.deleted <> true 
		 AND start_date <= NOW() 
		 AND end_date IS NOT NULL 
		 AND end_date <= NOW()) n GROUP BY certified_product_id) surv_closed
    ON a.certified_product_id = surv_closed.certified_product_id
	LEFT JOIN (SELECT certified_product_id, count(*) as "count_open_nonconformities" FROM
	    (SELECT * FROM openchpl.surveillance surv
			JOIN openchpl.surveillance_requirement surv_req
			ON surv.id = surv_req.surveillance_id AND surv_req.deleted <> true
			JOIN openchpl.surveillance_nonconformity surv_nc
			ON surv_req.id = surv_nc.surveillance_requirement_id AND surv_nc.deleted <> true
			JOIN openchpl.nonconformity_status nc_status
			ON surv_nc.nonconformity_status_id = nc_status.id
		 WHERE surv.deleted <> true 
		 AND nc_status.name = 'Open') n GROUP BY certified_product_id) nc_open
    ON a.certified_product_id = nc_open.certified_product_id
	LEFT JOIN (SELECT certified_product_id, count(*) as "count_closed_nonconformities" FROM
	    (SELECT * FROM openchpl.surveillance surv
			JOIN openchpl.surveillance_requirement surv_req
			ON surv.id = surv_req.surveillance_id AND surv_req.deleted <> true
			JOIN openchpl.surveillance_nonconformity surv_nc
			ON surv_req.id = surv_nc.surveillance_requirement_id AND surv_nc.deleted <> true
			JOIN openchpl.nonconformity_status nc_status
			ON surv_nc.nonconformity_status_id = nc_status.id
		 WHERE surv.deleted <> true 
		 AND nc_status.name = 'Closed') n GROUP BY certified_product_id) nc_closed
    ON a.certified_product_id = nc_closed.certified_product_id
    LEFT JOIN (SELECT testing_lab_id, name as "testing_lab_name", testing_lab_code from openchpl.testing_lab) q on a.testing_lab_id = q.testing_lab_id
    ;	
	
-- ALTER VIEW openchpl.certified_product_details OWNER TO openchpl;

DROP VIEW IF EXISTS openchpl.certified_product_search;
CREATE OR REPLACE VIEW openchpl.certified_product_search AS

SELECT
    cp.certified_product_id,
    string_agg(DISTINCT certs.cert_number::text, '☺') as "certs",
    string_agg(DISTINCT cqms.cqm_number::text, '☺') as "cqms",
    COALESCE(cp.chpl_product_number, substring(edition.year from 3 for 2)||'.'||atl.testing_lab_code||'.'||acb.certification_body_code||'.'||vendor.vendor_code||'.'||cp.product_code||'.'||cp.version_code||'.'||cp.ics_code||'.'||cp.additional_software_code||'.'||cp.certified_date_code) as "chpl_product_number",
	cp.meaningful_use_users,
	cp.transparency_attestation_url,
    edition.year,
    atl.testing_lab_name,
    acb.certification_body_name,
    cp.acb_certification_id,
    prac.practice_type_name,
    version.product_version,
    product.product_name,
    vendor.vendor_name,
    string_agg(DISTINCT history_vendor_name::text, '☺') as "owner_history",
    certStatusEvent.certification_date,
    certStatus.certification_status_name,
	decert.decertification_date,
	string_agg(DISTINCT certs_with_api_documentation.cert_number::text||'☹'||certs_with_api_documentation.api_documentation, '☺') as "api_documentation",
    COALESCE(survs.count_surveillance_activities, 0) as "surveillance_count",
    COALESCE(nc_open.count_open_nonconformities, 0) as "open_nonconformity_count",
    COALESCE(nc_closed.count_closed_nonconformities, 0) as "closed_nonconformity_count"
 FROM openchpl.certified_product cp
	LEFT JOIN (SELECT cse.certification_status_id as "certification_status_id", cse.certified_product_id as "certified_product_id",
			cse.event_date as "last_certification_status_change"
				FROM openchpl.certification_status_event cse
				INNER JOIN (
					SELECT certified_product_id, MAX(event_date) event_date
					FROM openchpl.certification_status_event
					GROUP BY certified_product_id
				) cseInner 
				ON cse.certified_product_id = cseInner.certified_product_id AND cse.event_date = cseInner.event_date) certStatusEvents
		ON certStatusEvents.certified_product_id = cp.certified_product_id
    LEFT JOIN (SELECT certification_status_id, certification_status as "certification_status_name" FROM openchpl.certification_status) certStatus on certStatusEvents.certification_status_id = certStatus.certification_status_id
    LEFT JOIN (SELECT certification_edition_id, year FROM openchpl.certification_edition) edition on cp.certification_edition_id = edition.certification_edition_id
    LEFT JOIN (SELECT testing_lab_id, name as "testing_lab_name", testing_lab_code from openchpl.testing_lab) atl on cp.testing_lab_id = atl.testing_lab_id
    LEFT JOIN (SELECT certification_body_id, name as "certification_body_name", acb_code as "certification_body_code", deleted as "acb_is_deleted" FROM openchpl.certification_body) acb on cp.certification_body_id = acb.certification_body_id
    LEFT JOIN (SELECT practice_type_id, name as "practice_type_name" FROM openchpl.practice_type) prac on cp.practice_type_id = prac.practice_type_id
    LEFT JOIN (SELECT product_version_id, version as "product_version", product_id from openchpl.product_version) version on cp.product_version_id = version.product_version_id
    LEFT JOIN (SELECT product_id, vendor_id, name as "product_name" FROM openchpl.product) product ON version.product_id = product.product_id
    LEFT JOIN (SELECT vendor_id, name as "vendor_name", vendor_code FROM openchpl.vendor) vendor on product.vendor_id = vendor.vendor_id
    LEFT JOIN (SELECT name as "history_vendor_name", product_owner_history_map.product_id as "history_product_id" FROM openchpl.vendor 
			JOIN openchpl.product_owner_history_map ON vendor.vendor_id = product_owner_history_map.vendor_id
			WHERE product_owner_history_map.deleted = false) owners
    ON owners.history_product_id = product.product_id
    LEFT JOIN (SELECT MIN(event_date) as "certification_date", certified_product_id from openchpl.certification_status_event where certification_status_id = 1 group by (certified_product_id)) certStatusEvent on cp.certified_product_id = certStatusEvent.certified_product_id
	LEFT JOIN (SELECT MAX(event_date) as "decertification_date", certified_product_id from openchpl.certification_status_event where certification_status_id IN (3, 4, 8) group by (certified_product_id)) decert on cp.certified_product_id = decert.certified_product_id
    LEFT JOIN (SELECT certified_product_id, count(*) as "count_surveillance_activities" 
		FROM openchpl.surveillance 
		WHERE openchpl.surveillance.deleted <> true  
		GROUP BY certified_product_id) survs
    ON cp.certified_product_id = survs.certified_product_id
	LEFT JOIN (SELECT certified_product_id, count(*) as "count_open_nonconformities" 
		FROM openchpl.surveillance surv
		JOIN openchpl.surveillance_requirement surv_req ON surv.id = surv_req.surveillance_id AND surv_req.deleted <> true
		JOIN openchpl.surveillance_nonconformity surv_nc ON surv_req.id = surv_nc.surveillance_requirement_id AND surv_nc.deleted <> true
		JOIN openchpl.nonconformity_status nc_status ON surv_nc.nonconformity_status_id = nc_status.id
		WHERE surv.deleted <> true 
		AND nc_status.name = 'Open'  
		GROUP BY certified_product_id) nc_open
    ON cp.certified_product_id = nc_open.certified_product_id
	LEFT JOIN (SELECT certified_product_id, count(*) as "count_closed_nonconformities" 
		FROM openchpl.surveillance surv
		JOIN openchpl.surveillance_requirement surv_req ON surv.id = surv_req.surveillance_id AND surv_req.deleted <> true
		JOIN openchpl.surveillance_nonconformity surv_nc ON surv_req.id = surv_nc.surveillance_requirement_id AND surv_nc.deleted <> true
		JOIN openchpl.nonconformity_status nc_status ON surv_nc.nonconformity_status_id = nc_status.id
		WHERE surv.deleted <> true 
		AND nc_status.name = 'Closed'  
		GROUP BY certified_product_id) nc_closed
    ON cp.certified_product_id = nc_closed.certified_product_id
    LEFT JOIN (SELECT number as "cert_number", certified_product_id FROM openchpl.certification_criterion 
		JOIN openchpl.certification_result ON certification_criterion.certification_criterion_id = certification_result.certification_criterion_id
		WHERE certification_result.success = true AND certification_result.deleted = false AND certification_criterion.deleted = false) certs
	ON certs.certified_product_id = cp.certified_product_id
	LEFT JOIN (SELECT number as "cert_number", api_documentation, certified_product_id FROM openchpl.certification_criterion 
		JOIN openchpl.certification_result ON certification_criterion.certification_criterion_id = certification_result.certification_criterion_id
		WHERE certification_result.success = true 
		AND certification_result.api_documentation IS NOT NULL 
		AND certification_result.deleted = false 
		AND certification_criterion.deleted = false) certs_with_api_documentation
	ON certs_with_api_documentation.certified_product_id = cp.certified_product_id 
    LEFT JOIN (SELECT COALESCE(cms_id, 'NQF-'||nqf_number) as "cqm_number", certified_product_id FROM openchpl.cqm_criterion 
		JOIN openchpl.cqm_result 
		ON cqm_criterion.cqm_criterion_id = cqm_result.cqm_criterion_id
		WHERE cqm_result.success = true AND cqm_result.deleted = false AND cqm_criterion.deleted = false) cqms
	ON cqms.certified_product_id = cp.certified_product_id
	
WHERE cp.deleted != true
GROUP BY cp.certified_product_id, cp.acb_certification_id, edition.year, atl.testing_lab_code, acb.certification_body_code, vendor.vendor_code, cp.product_code, cp.version_code,cp.ics_code, cp.additional_software_code, cp.certified_date_code, cp.transparency_attestation_url,
atl.testing_lab_name, acb.certification_body_name,prac.practice_type_name,version.product_version,product.product_name,vendor.vendor_name,certStatusEvent.certification_date,certStatus.certification_status_name, decert.decertification_date,
survs.count_surveillance_activities, nc_open.count_open_nonconformities, nc_closed.count_closed_nonconformities
;

CREATE OR REPLACE VIEW openchpl.developer_certification_statuses AS
SELECT v.vendor_id,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Active'::text) AS active,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Retired'::text) AS retired,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Withdrawn by Developer'::text) AS withdrawn_by_developer,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Withdrawn by ONC-ACB'::text) AS withdrawn_by_acb,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Suspended by ONC-ACB'::text) AS suspended_by_acb,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Suspended by ONC'::text) AS suspended_by_onc,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Terminated by ONC'::text) AS terminated_by_onc
FROM openchpl.vendor v
    LEFT JOIN openchpl.product p ON v.vendor_id = p.vendor_id
    LEFT JOIN openchpl.product_version pv ON p.product_id = pv.product_id
    LEFT JOIN openchpl.certified_product cp ON pv.product_version_id = cp.product_version_id
    LEFT JOIN openchpl.certification_status cs ON cp.certification_status_id = cs.certification_status_id
GROUP BY v.vendor_id;

--ALTER TABLE openchpl.developer_certification_statuses OWNER TO openchpl;

CREATE OR REPLACE VIEW openchpl.product_certification_statuses AS
SELECT p.product_id,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Active'::text) AS active,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Retired'::text) AS retired,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Withdrawn by Developer'::text) AS withdrawn_by_developer,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Withdrawn by ONC-ACB'::text) AS withdrawn_by_acb,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Suspended by ONC-ACB'::text) AS suspended_by_acb,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Suspended by ONC'::text) AS suspended_by_onc,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Terminated by ONC'::text) AS terminated_by_onc
FROM openchpl.product p
    LEFT JOIN openchpl.product_version pv ON p.product_id = pv.product_id
    LEFT JOIN openchpl.certified_product cp ON pv.product_version_id = cp.product_version_id
    LEFT JOIN openchpl.certification_status cs ON cp.certification_status_id = cs.certification_status_id
GROUP BY p.product_id;

--ALTER TABLE openchpl.product_certification_statuses OWNER TO openchpl;

-- View: openchpl.acb_developer_transparency_mappings

-- DROP VIEW openchpl.acb_developer_transparency_mappings;

CREATE OR REPLACE VIEW openchpl.acb_developer_transparency_mappings AS
SELECT row_number() OVER () AS id,
    certification_body.certification_body_id,
    certification_body."name" AS acb_name,
    acb_vendor_map.transparency_attestation,
    vendor."name" AS developer_name,
    vendor.vendor_id
FROM openchpl.vendor
    LEFT JOIN openchpl.acb_vendor_map ON acb_vendor_map.vendor_id = vendor.vendor_id
    LEFT JOIN openchpl.certification_body ON acb_vendor_map.certification_body_id = certification_body.certification_body_id
WHERE (certification_body.deleted = false OR certification_body.deleted IS NULL) AND vendor.deleted = false;

--ALTER TABLE openchpl.acb_developer_transparency_mappings OWNER TO openchpl;

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

CREATE OR REPLACE VIEW openchpl.ehr_certification_ids_and_products AS
SELECT 
	row_number() OVER () AS id,
	ehr.ehr_certification_id_id as ehr_certification_id,
	ehr.certification_id as ehr_certification_id_text,
	ehr.creation_date as ehr_certification_id_creation_date,
	cp.certified_product_id,
	cp.chpl_product_number,
	ed.year,
	atl.testing_lab_code,
	acb.certification_body_code,
	v.vendor_code,
	cp.product_code,
    cp.version_code,
    cp.ics_code,
    cp.additional_software_code,
    cp.certified_date_code
FROM openchpl.ehr_certification_id ehr
    LEFT JOIN openchpl.ehr_certification_id_product_map prodMap 
		ON ehr.ehr_certification_id_id = prodMap.ehr_certification_id_id
	LEFT JOIN openchpl.certified_product cp	
		ON prodMap.certified_product_id = cp.certified_product_id
    LEFT JOIN (SELECT certification_edition_id, year FROM openchpl.certification_edition) ed on cp.certification_edition_id = ed.certification_edition_id
    LEFT JOIN (SELECT certification_body_id, name as "certification_body_name", acb_code as "certification_body_code" FROM openchpl.certification_body) acb 
		ON cp.certification_body_id = acb.certification_body_id
	LEFT JOIN (SELECT testing_lab_id, testing_lab_code from openchpl.testing_lab) atl on cp.testing_lab_id = atl.testing_lab_id
	LEFT JOIN (SELECT product_version_id, product_id from openchpl.product_version) pv on cp.product_version_id = pv.product_version_id
    LEFT JOIN (SELECT product_id, vendor_id FROM openchpl.product) prod ON pv.product_id = prod.product_id
	LEFT JOIN (SELECT vendor_id, vendor_code from openchpl.vendor) v ON prod.vendor_id = v.vendor_id
;

CREATE OR REPLACE VIEW openchpl.product_active_owner_history_map AS
SELECT  id,
	product_id,
	vendor_id,
	transfer_date,
	creation_date,
	last_modified_date,
	last_modified_user,
	deleted
FROM openchpl.product_owner_history_map
WHERE deleted = false;
