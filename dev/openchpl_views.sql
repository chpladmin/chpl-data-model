DROP VIEW IF EXISTS openchpl.product_certification_statuses;
DROP VIEW IF EXISTS openchpl.developer_certification_statuses;
DROP VIEW IF EXISTS openchpl.certified_product_search_result;
DROP VIEW IF EXISTS openchpl.questionable_activity_combined;
DROP VIEW IF EXISTS openchpl.listing_search;
DROP VIEW IF EXISTS openchpl.certified_product_search;
DROP VIEW IF EXISTS openchpl.certified_product_details;
DROP VIEW IF EXISTS openchpl.cqm_result_details;
DROP VIEW IF EXISTS openchpl.certification_result_details;
DROP VIEW IF EXISTS openchpl.product_active_owner_history_map;
DROP VIEW IF EXISTS openchpl.certified_product_summary;
DROP VIEW IF EXISTS openchpl.ehr_certification_ids_and_products;
DROP VIEW IF EXISTS openchpl.listings_from_banned_developers;
DROP VIEW IF EXISTS openchpl.surveillance_basic;
DROP VIEW IF EXISTS openchpl.developer_certification_body_map;
DROP VIEW IF EXISTS openchpl.aggregated_nonconformity_statistics;
DROP VIEW IF EXISTS openchpl.requirement_type;
DROP VIEW IF EXISTS openchpl.nonconformity_type;

create or replace function openchpl.get_testing_lab_code(input_id bigint) returns
    table (
        testing_lab_code varchar
        ) as $$
    begin
    return query
        select
            case
            when (select count(*) from openchpl.certified_product_testing_lab_map as a
            where a.certified_product_id = input_id
                and a.deleted = false) = 1
                    then (select b.testing_lab_code from openchpl.testing_lab b, openchpl.certified_product_testing_lab_map c
                        where b.testing_lab_id = c.testing_lab_id
                     and c.certified_product_id = input_id
                            and c.deleted = false)
            when (select count(*) from openchpl.certified_product_testing_lab_map as a
            where a.certified_product_id = input_id
                and a.deleted = false) = 0
            then null
                else '99'
            end;
end;
$$ language plpgsql
stable;

create or replace function openchpl.get_chpl_product_number(id bigint) returns
    table (
        chpl_product_number varchar
        ) as $$
    begin
    return query
select
    COALESCE(a.chpl_product_number, COALESCE(substring(b.year from 3 for 2), '15')||'.'||(select openchpl.get_testing_lab_code(a.certified_product_id))||'.'||c.certification_body_code||'.'||h.vendor_code||'.'||a.product_code||'.'||a.version_code||'.'||a.ics_code||'.'||a.additional_software_code||'.'||a.certified_date_code) as "chpl_product_number"
FROM openchpl.certified_product a
    LEFT JOIN (SELECT certification_edition_id, year FROM openchpl.certification_edition) b on a.certification_edition_id = b.certification_edition_id
    LEFT JOIN (SELECT certification_body_id, name as "certification_body_name", acb_code as "certification_body_code" FROM openchpl.certification_body) c on a.certification_body_id = c.certification_body_id
    LEFT JOIN (SELECT product_version_id, version as "product_version", product_id from openchpl.product_version) f on a.product_version_id = f.product_version_id
    LEFT JOIN (SELECT product_id, vendor_id, name as "product_name" FROM openchpl.product) g ON f.product_id = g.product_id
    LEFT JOIN (SELECT vendor_id, name as "vendor_name", vendor_code, website as "vendor_website", address_id as "vendor_address", contact_id as "vendor_contact", vendor_status_id from openchpl.vendor) h on g.vendor_id = h.vendor_id
WHERE a.certified_product_id = id;
    end;
    $$ language plpgsql
stable;

CREATE OR REPLACE FUNCTION openchpl.get_chpl_product_number_as_text(
    id bigint
    )
RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE
AS $BODY$
declare
    cpn text;
BEGIN
    SELECT chpl_product_number into cpn
    FROM openchpl.get_chpl_product_number(id);
    RETURN cpn;
END;
$BODY$;

CREATE VIEW openchpl.certification_result_details AS
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
    a.attestation_answer,
    a.api_documentation,
    a.export_documentation,
    a.documentation_url,
    a.use_cases,
    a.service_base_url_list,
	a.risk_management_summary_information,
    a.privacy_security_framework,
    b.number,
    b.title
FROM openchpl.certification_result a
    LEFT JOIN (SELECT certification_criterion_id, number, title FROM openchpl.certification_criterion) b
    ON a.certification_criterion_id = b.certification_criterion_id;

CREATE VIEW openchpl.cqm_result_details AS
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

CREATE VIEW openchpl.certified_product_details AS
 SELECT a.certified_product_id,
    a.certification_edition_id,
    a.product_version_id,
    a.certification_body_id,
    ( SELECT get_chpl_product_number.chpl_product_number
           FROM openchpl.get_chpl_product_number(a.certified_product_id) get_chpl_product_number(chpl_product_number)) AS chpl_product_number,
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
    a.mandatory_disclosures,
    a.ics,
    a.sed,
    a.qms,
    a.accessibility_certified,
    a.product_additional_software,
    a.last_modified_date,
    a.rwt_plans_url,
    a.rwt_plans_check_date,
    a.rwt_results_url,
    a.rwt_results_check_date,
    a.svap_notice_url,
    piuResult.promoting_interoperability_user_count,
    piuResult.promoting_interoperability_user_count_date,
    b.year,
    c.certification_body_name,
    c.certification_body_code,
    c.acb_is_retired,
    d.product_classification_name,
    e.practice_type_name,
    f.product_version,
    f.product_id,
    g.product_name,
    g.vendor_id,
    h.vendor_name,
    h.vendor_code,
    h.vendor_website,
    h.self_developer,
    v.vendor_status_id,
    v.vendor_status_name,
    vendorstatus.last_vendor_status_change,
    t.address_id,
    t.street_line_1,
    t.street_line_2,
    t.city,
    t.state,
    t.zipcode,
    t.country,
    u.contact_id,
    u.full_name,
    u.email,
    u.phone_number,
    u.title,
    i.certification_date,
    decert.decertification_date,
    COALESCE(k.count_certifications, 0::bigint) AS count_certifications,
    COALESCE(m.count_cqms, 0::bigint) AS count_cqms,
    COALESCE(surv.count_surveillance_activities, 0::bigint) AS count_surveillance_activities,
    COALESCE(surv_open.count_open_surveillance_activities, 0::bigint) AS count_open_surveillance_activities,
    COALESCE(surv_closed.count_closed_surveillance_activities, 0::bigint) AS count_closed_surveillance_activities,
    COALESCE(nc_open.count_open_nonconformities, 0::bigint) AS count_open_nonconformities,
    COALESCE(nc_closed.count_closed_nonconformities, 0::bigint) AS count_closed_nonconformities,
    r.certification_status_id,
    r.last_certification_status_change,
    n.certification_status_name,
    cures_update.cures_update
   FROM openchpl.certified_product a
     LEFT JOIN (
         SELECT cse.certification_status_id,
            cse.certified_product_id,
            cse.last_certification_status_change
         FROM (
             SELECT cse_inner.certification_status_id,
                 cse_inner.certified_product_id,
                 cse_inner.event_date AS last_certification_status_change,
                 ROW_NUMBER() OVER (
                     PARTITION BY cse_inner.certified_product_id
                     ORDER BY cse_inner.event_date DESC) rownum
             FROM openchpl.certification_status_event cse_inner
             WHERE cse_inner.deleted = false
             ) cse   
         WHERE cse.rownum = 1
         ) r 
     ON r.certified_product_id = a.certified_product_id
     LEFT JOIN (
         SELECT cue.cures_update,
            cue.certified_product_id
         FROM (
             SELECT cue_inner.cures_update,
                 cue_inner.certified_product_id,
                 ROW_NUMBER() OVER (
                     PARTITION BY cue_inner.certified_product_id
                     ORDER BY cue_inner.event_date DESC) rownum
             FROM openchpl.cures_update_event cue_inner
             WHERE cue_inner.deleted = false
             ) cue
         WHERE cue.rownum = 1
         ) cures_update
     ON cures_update.certified_product_id = a.certified_product_id
     LEFT JOIN ( SELECT certification_status.certification_status_id,
            certification_status.certification_status AS certification_status_name
           FROM openchpl.certification_status) n ON r.certification_status_id = n.certification_status_id
     LEFT JOIN ( SELECT piu_ranked.user_count as promoting_interoperability_user_count,
			piu_ranked.certified_product_id,
			piu_ranked.user_count_date as promoting_interoperability_user_count_date
		FROM (	SELECT piu.user_count,
				piu.certified_product_id,
				piu.user_count_date,
				row_number() over (partition by piu.certified_product_id order by piu.user_count_date desc) as piu_rank
			FROM openchpl.promoting_interoperability_user piu
			WHERE piu.deleted <> true) piu_ranked
		WHERE piu_ranked.piu_rank = 1) piuResult 
	ON piuResult.certified_product_id = a.certified_product_id
     LEFT JOIN ( SELECT certification_edition.certification_edition_id,
            certification_edition.year
           FROM openchpl.certification_edition) b ON a.certification_edition_id = b.certification_edition_id
     LEFT JOIN ( SELECT certification_body.certification_body_id,
            certification_body.name AS certification_body_name,
            certification_body.acb_code AS certification_body_code,
            certification_body.retired AS acb_is_retired
           FROM openchpl.certification_body) c ON a.certification_body_id = c.certification_body_id
     LEFT JOIN ( SELECT product_classification_type.product_classification_type_id,
            product_classification_type.name AS product_classification_name
           FROM openchpl.product_classification_type) d ON a.product_classification_type_id = d.product_classification_type_id
     LEFT JOIN ( SELECT practice_type.practice_type_id,
            practice_type.name AS practice_type_name
           FROM openchpl.practice_type) e ON a.practice_type_id = e.practice_type_id
     LEFT JOIN ( SELECT product_version.product_version_id,
            product_version.version AS product_version,
            product_version.product_id
           FROM openchpl.product_version) f ON a.product_version_id = f.product_version_id
     LEFT JOIN ( SELECT product.product_id,
            product.vendor_id,
            product.name AS product_name
           FROM openchpl.product) g ON f.product_id = g.product_id
     LEFT JOIN ( SELECT vendor.vendor_id,
            vendor.name AS vendor_name,
            vendor.vendor_code,
            vendor.website AS vendor_website,
            vendor.self_developer AS self_developer,
            vendor.address_id AS vendor_address,
            vendor.contact_id AS vendor_contact,
            vendor.vendor_status_id
           FROM openchpl.vendor) h ON g.vendor_id = h.vendor_id
     LEFT JOIN ( SELECT address.address_id,
            address.street_line_1,
            address.street_line_2,
            address.city,
            address.state,
            address.zipcode,
            address.country
           FROM openchpl.address) t ON h.vendor_address = t.address_id
     LEFT JOIN ( SELECT contact.contact_id,
            contact.full_name,
            contact.email,
            contact.phone_number,
            contact.title
           FROM openchpl.contact) u ON h.vendor_contact = u.contact_id
     LEFT JOIN ( SELECT vshistory.vendor_status_id,
            vshistory.vendor_id,
            vshistory.status_date AS last_vendor_status_change
           FROM openchpl.vendor_status_history vshistory
             JOIN ( SELECT vendor_status_history.vendor_id,
                    max(vendor_status_history.status_date) AS status_date
                   FROM openchpl.vendor_status_history
                  WHERE vendor_status_history.deleted = false
                  GROUP BY vendor_status_history.vendor_id) vsinner 
				ON vshistory.vendor_id = vsinner.vendor_id 
				AND vshistory.status_date = vsinner.status_date
				AND vshistory.deleted = false) vendorstatus ON vendorstatus.vendor_id = h.vendor_id
     LEFT JOIN ( SELECT vendor_status.vendor_status_id,
            vendor_status.name AS vendor_status_name
           FROM openchpl.vendor_status) v ON vendorstatus.vendor_status_id = v.vendor_status_id
     LEFT JOIN ( SELECT min(certification_status_event.event_date) AS certification_date,
            certification_status_event.certified_product_id
           FROM openchpl.certification_status_event
          WHERE certification_status_event.certification_status_id = 1 AND certification_status_event.deleted <> true
          GROUP BY certification_status_event.certified_product_id) i ON a.certified_product_id = i.certified_product_id
     LEFT JOIN ( SELECT max(certification_status_event.event_date) AS decertification_date,
            certification_status_event.certified_product_id
           FROM openchpl.certification_status_event
          WHERE (certification_status_event.certification_status_id = ANY (ARRAY[3::bigint, 4::bigint, 8::bigint, 9::bigint])) AND certification_status_event.deleted <> true
          GROUP BY certification_status_event.certified_product_id) decert ON a.certified_product_id = decert.certified_product_id
     LEFT JOIN ( SELECT j.certified_product_id,
            count(*) AS count_certifications
           FROM ( SELECT certification_result.certification_result_id,
                    certification_result.certification_criterion_id,
                    certification_result.certified_product_id,
                    certification_result.success,
                    certification_result.gap,
                    certification_result.sed,
                    certification_result.g1_success,
                    certification_result.g2_success,
                    certification_result.attestation_answer,
                    certification_result.api_documentation,
                    certification_result.export_documentation,
                    certification_result.documentation_url,
                    certification_result.use_cases,
                    certification_result.service_base_url_list,
                    certification_result.privacy_security_framework,
                    certification_result.creation_date,
                    certification_result.last_modified_date,
                    certification_result.last_modified_user,
                    certification_result.last_modified_sso_user,
                    certification_result.deleted
                   FROM openchpl.certification_result
                  WHERE certification_result.success = true AND certification_result.deleted <> true) j
          GROUP BY j.certified_product_id) k ON a.certified_product_id = k.certified_product_id
     LEFT JOIN ( SELECT l.certified_product_id,
            count(*) AS count_cqms
           FROM ( SELECT DISTINCT a_1.certified_product_id,
                    COALESCE(b_1.cms_id, b_1.nqf_number) AS cqm_id
                   FROM openchpl.cqm_result a_1
                     LEFT JOIN openchpl.cqm_criterion b_1 ON a_1.cqm_criterion_id = b_1.cqm_criterion_id
                  WHERE a_1.success = true AND a_1.deleted <> true AND b_1.deleted <> true) l
          GROUP BY l.certified_product_id
          ORDER BY l.certified_product_id) m ON a.certified_product_id = m.certified_product_id
     LEFT JOIN ( SELECT n_1.certified_product_id,
            count(*) AS count_surveillance_activities
           FROM ( SELECT surveillance.id,
                    surveillance.certified_product_id,
                    surveillance.friendly_id,
                    surveillance.start_date,
                    surveillance.end_date,
                    surveillance.type_id,
                    surveillance.randomized_sites_used,
                    surveillance.creation_date,
                    surveillance.last_modified_date,
                    surveillance.last_modified_user,
                    surveillance.last_modified_sso_user,
                    surveillance.deleted
                   FROM openchpl.surveillance
                  WHERE surveillance.deleted <> true) n_1
          GROUP BY n_1.certified_product_id) surv ON a.certified_product_id = surv.certified_product_id
     LEFT JOIN ( SELECT n_1.certified_product_id,
            count(*) AS count_open_surveillance_activities
           FROM ( SELECT surveillance.id,
                    surveillance.certified_product_id,
                    surveillance.friendly_id,
                    surveillance.start_date,
                    surveillance.end_date,
                    surveillance.type_id,
                    surveillance.randomized_sites_used,
                    surveillance.creation_date,
                    surveillance.last_modified_date,
                    surveillance.last_modified_user,
                    surveillance.last_modified_sso_user,
                    surveillance.deleted
                   FROM openchpl.surveillance
                  WHERE surveillance.deleted <> true AND surveillance.start_date <= now() AND (surveillance.end_date IS NULL OR surveillance.end_date >= now())) n_1
          GROUP BY n_1.certified_product_id) surv_open ON a.certified_product_id = surv_open.certified_product_id
     LEFT JOIN ( SELECT n_1.certified_product_id,
            count(*) AS count_closed_surveillance_activities
           FROM ( SELECT surveillance.id,
                    surveillance.certified_product_id,
                    surveillance.friendly_id,
                    surveillance.start_date,
                    surveillance.end_date,
                    surveillance.type_id,
                    surveillance.randomized_sites_used,
                    surveillance.creation_date,
                    surveillance.last_modified_date,
                    surveillance.last_modified_user,
                    surveillance.last_modified_sso_user,
                    surveillance.deleted
                   FROM openchpl.surveillance
                  WHERE surveillance.deleted <> true AND surveillance.start_date <= now() AND surveillance.end_date IS NOT NULL AND surveillance.end_date <= now()) n_1
          GROUP BY n_1.certified_product_id) surv_closed ON a.certified_product_id = surv_closed.certified_product_id
     LEFT JOIN ( SELECT n_1.certified_product_id,
            count(*) AS count_open_nonconformities
           FROM ( SELECT surv_1.certified_product_id
                   FROM openchpl.surveillance surv_1
                     JOIN openchpl.surveillance_requirement surv_req ON surv_1.id = surv_req.surveillance_id AND surv_req.deleted <> true
                     JOIN openchpl.surveillance_nonconformity surv_nc ON surv_req.id = surv_nc.surveillance_requirement_id AND surv_nc.deleted <> true
                  WHERE surv_1.deleted <> true AND surv_nc.non_conformity_close_date is null) n_1
          GROUP BY n_1.certified_product_id) nc_open ON a.certified_product_id = nc_open.certified_product_id
     LEFT JOIN ( SELECT n_1.certified_product_id,
            count(*) AS count_closed_nonconformities
           FROM ( SELECT surv_1.certified_product_id
                   FROM openchpl.surveillance surv_1
                     JOIN openchpl.surveillance_requirement surv_req ON surv_1.id = surv_req.surveillance_id AND surv_req.deleted <> true
                     JOIN openchpl.surveillance_nonconformity surv_nc ON surv_req.id = surv_nc.surveillance_requirement_id AND surv_nc.deleted <> true
                  WHERE surv_1.deleted <> true AND surv_nc.non_conformity_close_date is not null) n_1
          GROUP BY n_1.certified_product_id) nc_closed ON a.certified_product_id = nc_closed.certified_product_id;
-- ALTER VIEW openchpl.certified_product_details OWNER TO openchpl;

CREATE VIEW openchpl.surveillance_basic AS
SELECT 
	surv.*,
	(SELECT get_chpl_product_number.chpl_product_number
           FROM openchpl.get_chpl_product_number(surv.certified_product_id) get_chpl_product_number(chpl_product_number)) AS chpl_product_number,
	COALESCE(nc_open.count_open_nonconformities, 0::bigint) AS open_nonconformity_count,
    COALESCE(nc_closed.count_closed_nonconformities, 0::bigint) AS closed_nonconformity_count
FROM openchpl.surveillance surv
LEFT JOIN
  (SELECT surv.id AS surv_id,
          count(*) AS count_open_nonconformities
   FROM openchpl.surveillance surv
   JOIN openchpl.surveillance_requirement surv_req ON surv.id = surv_req.surveillance_id
   AND surv_req.deleted <> TRUE
   JOIN openchpl.surveillance_nonconformity surv_nc ON surv_req.id = surv_nc.surveillance_requirement_id
   AND surv_nc.deleted <> TRUE
   WHERE surv.deleted <> TRUE
     AND surv_nc.non_conformity_close_date is null
   GROUP BY surv.id) nc_open ON surv.id = nc_open.surv_id
LEFT JOIN
  (SELECT surv.id AS surv_id,
          count(*) AS count_closed_nonconformities
   FROM openchpl.surveillance surv
   JOIN openchpl.surveillance_requirement surv_req ON surv.id = surv_req.surveillance_id
   AND surv_req.deleted <> TRUE
   JOIN openchpl.surveillance_nonconformity surv_nc ON surv_req.id = surv_nc.surveillance_requirement_id
   AND surv_nc.deleted <> TRUE
   WHERE surv.deleted <> TRUE
     AND surv_nc.non_conformity_close_date is not null
   GROUP BY surv.id) nc_closed ON surv.id = nc_closed.surv_id
WHERE surv.deleted = false;

CREATE VIEW openchpl.listing_search AS
SELECT cp.certified_product_id,
       child.children,
       parent.parents,
       certs.certification_criteria_met,
       cqms.cqms_met,
       openchpl.get_chpl_product_number(cp.certified_product_id) AS chpl_product_number,
	   cpnHistory.previous_chpl_product_numbers,
       piuResult.promoting_interoperability_user_count,
	   piuResult.promoting_interoperability_user_count_date,
       cp.mandatory_disclosures,
	   edition.certification_edition_id,
       edition.year,
	   acb.certification_body_id,
       acb.certification_body_name,
       cp.acb_certification_id,
	   prac.practice_type_id,
       prac.practice_type_name,
	   version.product_version_id as version_id,
       version.product_version as version_name,
	   product.product_id,
       product.product_name,
	   vendor.vendor_id as developer_id,
       vendor.vendor_name as developer_name,
	   vendor_status.vendor_status_id as developer_status_id,
       vendor_status.vendor_status_name as developer_status_name,
       owners.history_vendor_id_and_name AS product_owner_history,
       certstatusevent.certification_date,
	   certstatus.certification_status_id,
       certstatus.certification_status_name,
       curesupdate.cures_update,
       decert.decertification_date,
	   cp.rwt_plans_url,
	   cp.rwt_results_url,
	   cp.svap_notice_url,
       certs_with_api_documentation.criteria_with_api_documentation,
       certs_with_service_base_url_list.criteria_with_service_base_url_list,
	   certs_with_svap.criteria_with_svap,
       COALESCE(survs.count_surveillance_activities, 0::bigint) AS surveillance_count,
       COALESCE(surv_open.count_open_surveillance_activities, 0::bigint) as open_surveillance_count,
       COALESCE(surv_closed.count_closed_surveillance_activities, 0::bigint) as closed_surveillance_count,
       COALESCE(nc_open.count_open_nonconformities, 0::bigint) AS open_nonconformity_count,
       COALESCE(nc_closed.count_closed_nonconformities, 0::bigint) AS closed_nonconformity_count,
       surv_dates.surv_date_ranges,
	   status_events.status_events
FROM openchpl.certified_product cp
LEFT JOIN
   (SELECT cse.certification_status_id,
        cse.certified_product_id,
        cse.last_certification_status_change
    FROM (
        SELECT cse_inner.certification_status_id,
            cse_inner.certified_product_id,
            cse_inner.event_date AS last_certification_status_change,
            ROW_NUMBER() OVER (
                PARTITION BY cse_inner.certified_product_id
                ORDER BY cse_inner.event_date DESC) rownum
        FROM openchpl.certification_status_event cse_inner
        WHERE cse_inner.deleted = false
        ) cse   
    WHERE cse.rownum = 1
    ) certstatusevents 
ON certstatusevents.certified_product_id = cp.certified_product_id
LEFT JOIN (
    SELECT cue.cures_update,
       cue.certified_product_id
    FROM (
        SELECT cue_inner.cures_update,
            cue_inner.certified_product_id,
            ROW_NUMBER() OVER (
                PARTITION BY cue_inner.certified_product_id
                ORDER BY cue_inner.event_date DESC) rownum
        FROM openchpl.cures_update_event cue_inner
        WHERE cue_inner.deleted = false
        ) cue
    WHERE cue.rownum = 1
    ) curesupdate
ON curesupdate.certified_product_id = cp.certified_product_id
LEFT JOIN
  (SELECT certification_status.certification_status_id,
          certification_status.certification_status AS certification_status_name
   FROM openchpl.certification_status) certstatus ON certstatusevents.certification_status_id = certstatus.certification_status_id
LEFT JOIN ( 
	SELECT piu_ranked.user_count as promoting_interoperability_user_count,
		piu_ranked.certified_product_id,
		piu_ranked.user_count_date as promoting_interoperability_user_count_date
	FROM (	SELECT piu.user_count,
			piu.certified_product_id,
			piu.user_count_date,
			row_number() over (partition by piu.certified_product_id order by piu.user_count_date desc) as piu_rank
		FROM openchpl.promoting_interoperability_user piu
		WHERE piu.deleted <> true) piu_ranked
	WHERE piu_ranked.piu_rank = 1) piuResult
	ON piuResult.certified_product_id = cp.certified_product_id
LEFT JOIN
  (SELECT string_agg(DISTINCT children.child_listing_id::text||':'||child_chpl_product_number, '|'::text) AS children,
          parent_listing_id FROM
     (SELECT certified_product.certified_product_id, listing_to_listing_map.parent_listing_id, listing_to_listing_map.child_listing_id,
        (SELECT chpl_product_number
         FROM openchpl.get_chpl_product_number(child_listing_id)) AS child_chpl_product_number
      FROM openchpl.listing_to_listing_map
      JOIN openchpl.certified_product ON listing_to_listing_map.deleted = false 
		AND listing_to_listing_map.parent_listing_id = certified_product.certified_product_id) children
   GROUP BY parent_listing_id) child ON cp.certified_product_id = child.parent_listing_id
LEFT JOIN
  (SELECT string_agg(DISTINCT parents.parent_listing_id::text||':'||parent_chpl_product_number, '|'::text) AS parents,
          parents.child_listing_id FROM
     (SELECT certified_product.certified_product_id, listing_to_listing_map.child_listing_id, listing_to_listing_map.parent_listing_id,
        (SELECT chpl_product_number
         FROM openchpl.get_chpl_product_number(parent_listing_id)) AS parent_chpl_product_number, certified_product.chpl_product_number
      FROM openchpl.listing_to_listing_map
      JOIN openchpl.certified_product ON listing_to_listing_map.deleted = false 
		AND listing_to_listing_map.child_listing_id = certified_product.certified_product_id) parents
   GROUP BY child_listing_id) parent ON cp.certified_product_id = parent.child_listing_id
LEFT JOIN
  (SELECT certification_edition.certification_edition_id,
          certification_edition.year
   FROM openchpl.certification_edition) edition ON cp.certification_edition_id = edition.certification_edition_id
LEFT JOIN
  (SELECT certification_body.certification_body_id,
          certification_body.name AS certification_body_name,
          certification_body.acb_code AS certification_body_code
   FROM openchpl.certification_body) acb ON cp.certification_body_id = acb.certification_body_id
LEFT JOIN
  (SELECT practice_type.practice_type_id,
          practice_type.name AS practice_type_name
   FROM openchpl.practice_type) prac ON cp.practice_type_id = prac.practice_type_id
LEFT JOIN
  (SELECT product_version.product_version_id,
          product_version.version AS product_version,
          product_version.product_id
   FROM openchpl.product_version) VERSION ON cp.product_version_id = version.product_version_id
LEFT JOIN
  (SELECT product_1.product_id,
          product_1.vendor_id,
          product_1.name AS product_name
   FROM openchpl.product product_1) product ON version.product_id = product.product_id
LEFT JOIN
  (SELECT vendor_1.vendor_id,
          vendor_1.name AS vendor_name,
          vendor_1.vendor_code,
          vendor_1.vendor_status_id
   FROM openchpl.vendor vendor_1) vendor ON product.vendor_id = vendor.vendor_id
     LEFT JOIN ( SELECT vshistory.vendor_status_id,
            vshistory.vendor_id,
            vshistory.status_date AS last_vendor_status_change
           FROM openchpl.vendor_status_history vshistory
           JOIN (SELECT vendor_status_history.vendor_id,
                    max(vendor_status_history.status_date) AS status_date
                   FROM openchpl.vendor_status_history
                  WHERE vendor_status_history.deleted = false
                  GROUP BY vendor_status_history.vendor_id) vsinner ON vshistory.deleted = false AND vshistory.vendor_id = vsinner.vendor_id AND vshistory.status_date = vsinner.status_date) vendor_status_history ON vendor_status_history.vendor_id = vendor.vendor_id
     LEFT JOIN ( SELECT vendor_status.vendor_status_id,
            vendor_status.name AS vendor_status_name
           FROM openchpl.vendor_status) vendor_status ON vendor_status_history.vendor_status_id = vendor_status.vendor_status_id
LEFT JOIN
  (SELECT string_agg(vendor_1.vendor_id||'☹'||vendor_1.name, '☺') AS history_vendor_id_and_name,
          product_owner_history_map.product_id AS history_product_id
   FROM openchpl.vendor vendor_1
   JOIN openchpl.product_owner_history_map ON vendor_1.vendor_id = product_owner_history_map.vendor_id
   WHERE product_owner_history_map.deleted = FALSE
   GROUP BY history_product_id) owners ON owners.history_product_id = product.product_id
LEFT JOIN
  (SELECT min(certification_status_event.event_date) AS certification_date,
          certification_status_event.certified_product_id
   FROM openchpl.certification_status_event
   WHERE certification_status_event.certification_status_id = 1
     AND certification_status_event.deleted = FALSE
   GROUP BY certification_status_event.certified_product_id) certstatusevent ON cp.certified_product_id = certstatusevent.certified_product_id
LEFT JOIN
  (SELECT max(certification_status_event.event_date) AS decertification_date,
          certification_status_event.certified_product_id
   FROM openchpl.certification_status_event
   WHERE certification_status_event.certification_status_id = ANY (ARRAY[3::bigint,
                                                                         4::bigint,
                                                                         8::bigint,
																		 9::bigint])
     AND certification_status_event.deleted = FALSE
   GROUP BY certification_status_event.certified_product_id) decert ON cp.certified_product_id = decert.certified_product_id
LEFT JOIN
  (SELECT surveillance.certified_product_id,
          count(*) AS count_surveillance_activities
   FROM openchpl.surveillance
   WHERE surveillance.deleted <> TRUE
   GROUP BY surveillance.certified_product_id) survs ON cp.certified_product_id = survs.certified_product_id
LEFT JOIN
  (SELECT surv.certified_product_id,
          count(*) AS count_open_surveillance_activities
   FROM openchpl.surveillance surv
   WHERE surv.deleted <> TRUE
     AND surv.start_date <= now() AND (surv.end_date IS NULL OR surv.end_date > now())
   GROUP BY surv.certified_product_id) surv_open ON cp.certified_product_id = surv_open.certified_product_id
LEFT JOIN
  (SELECT surv.certified_product_id,
          count(*) AS count_closed_surveillance_activities
   FROM openchpl.surveillance surv
   WHERE surv.deleted <> TRUE
     AND surv.start_date <= now() AND surv.end_date IS NOT NULL AND surv.end_date <= now()
   GROUP BY surv.certified_product_id) surv_closed ON cp.certified_product_id = surv_closed.certified_product_id
LEFT JOIN
  (SELECT surv.certified_product_id,
          count(*) AS count_open_nonconformities
   FROM openchpl.surveillance surv
   JOIN openchpl.surveillance_requirement surv_req ON surv.id = surv_req.surveillance_id
   AND surv_req.deleted <> TRUE
   JOIN openchpl.surveillance_nonconformity surv_nc ON surv_req.id = surv_nc.surveillance_requirement_id
   AND surv_nc.deleted <> TRUE
   WHERE surv.deleted <> TRUE
     AND surv_nc.non_conformity_close_date is null
   GROUP BY surv.certified_product_id) nc_open ON cp.certified_product_id = nc_open.certified_product_id
LEFT JOIN
  (SELECT surv.certified_product_id,
          count(*) AS count_closed_nonconformities
   FROM openchpl.surveillance surv
   JOIN openchpl.surveillance_requirement surv_req ON surv.id = surv_req.surveillance_id
   AND surv_req.deleted <> TRUE
   JOIN openchpl.surveillance_nonconformity surv_nc ON surv_req.id = surv_nc.surveillance_requirement_id
   AND surv_nc.deleted <> TRUE
   WHERE surv.deleted <> TRUE
     AND surv_nc.non_conformity_close_date is not null
   GROUP BY surv.certified_product_id) nc_closed ON cp.certified_product_id = nc_closed.certified_product_id
LEFT JOIN
  (SELECT surv.certified_product_id,
          STRING_AGG(
		(EXTRACT(EPOCH FROM surv.start_date)*1000)::text
		||':'||
		COALESCE((EXTRACT(EPOCH FROM surv.end_date)*1000)::text, ''), '|') AS surv_date_ranges
   FROM openchpl.surveillance surv
   WHERE surv.deleted = FALSE
   GROUP BY surv.certified_product_id) AS surv_dates ON surv_dates.certified_product_id = cp.certified_product_id
LEFT JOIN
	(select cse.certified_product_id, string_agg(cs.certification_status_id||':'||cs.certification_status||':'||date(cse.event_date), '|') as status_events
	from openchpl.certification_status_event cse
	join openchpl.certification_status cs on cs.certification_status_id = cse.certification_status_id
	where cse.deleted = false
	group by cse.certified_product_id) as status_events ON status_events.certified_product_id = cp.certified_product_id
LEFT JOIN
  (SELECT certification_result.certified_product_id,
          string_agg(DISTINCT certification_criterion.certification_criterion_id::text||':'
						||certification_criterion.number||':'
						||certification_criterion.title, '|') AS certification_criteria_met
   FROM openchpl.certification_criterion
   JOIN openchpl.certification_result ON certification_criterion.certification_criterion_id = certification_result.certification_criterion_id
   WHERE certification_result.success = TRUE
     AND certification_result.deleted = FALSE
     AND certification_criterion.deleted = FALSE
   GROUP BY certified_product_id) AS certs ON certs.certified_product_id = cp.certified_product_id
LEFT JOIN
  (SELECT string_agg(DISTINCT certification_criterion.certification_criterion_id::text||':'
						||certification_criterion.number||':'
						||certification_criterion.title||'☹'
						||certification_result.api_documentation, '☺') AS criteria_with_api_documentation, 
	certification_result.certified_product_id
	FROM openchpl.certification_criterion
	JOIN openchpl.certification_result ON certification_criterion.certification_criterion_id = certification_result.certification_criterion_id
	WHERE certification_result.success = TRUE
    AND certification_result.api_documentation IS NOT NULL
    AND certification_result.deleted = FALSE
    AND certification_criterion.deleted = FALSE
	GROUP BY certified_product_id) certs_with_api_documentation ON certs_with_api_documentation.certified_product_id = cp.certified_product_id
LEFT JOIN
  (SELECT string_agg(DISTINCT certification_criterion.certification_criterion_id::text||':'
						||certification_criterion.number||':'
						||certification_criterion.title||'☹'
						||certification_result.service_base_url_list, '☺') AS criteria_with_service_base_url_list,
	certification_result.certified_product_id
	FROM openchpl.certification_criterion
	JOIN openchpl.certification_result ON certification_criterion.certification_criterion_id = certification_result.certification_criterion_id
	WHERE certification_result.success = TRUE
    AND certification_result.service_base_url_list IS NOT NULL
    AND certification_result.deleted = FALSE
    AND certification_criterion.deleted = FALSE
	GROUP BY certified_product_id) certs_with_service_base_url_list ON certs_with_service_base_url_list.certified_product_id = cp.certified_product_id
LEFT JOIN
  (SELECT string_agg(DISTINCT certification_criterion.certification_criterion_id::text||':'
						||certification_criterion.number||':'
						||certification_criterion.title||'☹'
						||certification_result_svap.svap_id::text, '☺') AS criteria_with_svap, 
	certification_result.certified_product_id
	FROM openchpl.certification_criterion
	JOIN openchpl.certification_result ON certification_criterion.certification_criterion_id = certification_result.certification_criterion_id
	JOIN openchpl.certification_result_svap ON certification_result.certification_result_id = certification_result_svap.certification_result_id
	WHERE certification_result.success = TRUE
    AND certification_result.deleted = FALSE
    AND certification_criterion.deleted = FALSE
	AND certification_result_svap.deleted = FALSE
	GROUP BY certified_product_id) certs_with_svap ON certs_with_svap.certified_product_id = cp.certified_product_id	
LEFT JOIN
  (SELECT string_agg(DISTINCT cqm_criterion.cqm_criterion_id||':'||COALESCE(cqm_criterion.cms_id, cqm_criterion.nqf_number), '|') AS cqms_met,
          cqm_result.certified_product_id
   FROM openchpl.cqm_criterion
   JOIN openchpl.cqm_result ON cqm_criterion.cqm_criterion_id = cqm_result.cqm_criterion_id
   WHERE cqm_result.success = TRUE
     AND cqm_result.deleted = FALSE
     AND cqm_criterion.deleted = FALSE
   GROUP BY certified_product_id) cqms ON cqms.certified_product_id = cp.certified_product_id
LEFT JOIN
  (SELECT string_agg(DISTINCT hist.chpl_product_number, '|') AS previous_chpl_product_numbers, hist.certified_product_id
   FROM openchpl.certified_product_chpl_product_number_history hist
   WHERE hist.deleted = false
   GROUP BY hist.certified_product_id) cpnHistory ON cpnHistory.certified_product_id = cp.certified_product_id
WHERE cp.deleted <> TRUE;

-- deprecated
CREATE VIEW openchpl.certified_product_search AS
SELECT cp.certified_product_id,
       child.child,
       parent.parent,
       certs.cert_number AS certs,
       cqms.cqm_number AS cqms,
       openchpl.get_chpl_product_number(cp.certified_product_id) AS chpl_product_number,
       piuResult.promoting_interoperability_user_count,
	   piuResult.promoting_interoperability_user_count_date,
       cp.mandatory_disclosures,
       edition.year,
       acb.certification_body_name,
       cp.acb_certification_id,
       prac.practice_type_name,
       version.product_version,
       product.product_name,
	   vendor.vendor_id,
       vendor.vendor_name,
       vendor_status.vendor_status_name,
       owners.history_vendor_name AS owner_history,
       certstatusevent.certification_date,
       certstatus.certification_status_name,
       curesupdate.cures_update,
       decert.decertification_date,
	   cp.rwt_plans_url,
	   cp.rwt_results_url,
       certs_with_api_documentation.cert_number AS api_documentation,
       certs_with_service_base_url_list.cert_number AS service_base_url_list,
       COALESCE(survs.count_surveillance_activities, 0::bigint) AS surveillance_count,
       COALESCE(surv_open.count_open_surveillance_activities, 0::bigint) as open_surveillance_count,
       COALESCE(surv_closed.count_closed_surveillance_activities, 0::bigint) as closed_surveillance_count,
       COALESCE(nc_open.count_open_nonconformities, 0::bigint) AS open_nonconformity_count,
       COALESCE(nc_closed.count_closed_nonconformities, 0::bigint) AS closed_nonconformity_count,
       surv_dates.surv_dates,
	   status_events.status_events
FROM openchpl.certified_product cp
LEFT JOIN
   (SELECT cse.certification_status_id,
        cse.certified_product_id,
        cse.last_certification_status_change
    FROM (
        SELECT cse_inner.certification_status_id,
            cse_inner.certified_product_id,
            cse_inner.event_date AS last_certification_status_change,
            ROW_NUMBER() OVER (
                PARTITION BY cse_inner.certified_product_id
                ORDER BY cse_inner.event_date DESC) rownum
        FROM openchpl.certification_status_event cse_inner
        WHERE cse_inner.deleted = false
        ) cse   
    WHERE cse.rownum = 1
    ) certstatusevents 
ON certstatusevents.certified_product_id = cp.certified_product_id
LEFT JOIN (
    SELECT cue.cures_update,
       cue.certified_product_id
    FROM (
        SELECT cue_inner.cures_update,
            cue_inner.certified_product_id,
            ROW_NUMBER() OVER (
                PARTITION BY cue_inner.certified_product_id
                ORDER BY cue_inner.event_date DESC) rownum
        FROM openchpl.cures_update_event cue_inner
        WHERE cue_inner.deleted = false
        ) cue
    WHERE cue.rownum = 1
    ) curesupdate
ON curesupdate.certified_product_id = cp.certified_product_id
LEFT JOIN
  (SELECT certification_status.certification_status_id,
          certification_status.certification_status AS certification_status_name
   FROM openchpl.certification_status) certstatus ON certstatusevents.certification_status_id = certstatus.certification_status_id
LEFT JOIN ( 
	SELECT piu_ranked.user_count as promoting_interoperability_user_count,
		piu_ranked.certified_product_id,
		piu_ranked.user_count_date as promoting_interoperability_user_count_date
	FROM (	SELECT piu.user_count,
			piu.certified_product_id,
			piu.user_count_date,
			row_number() over (partition by piu.certified_product_id order by piu.user_count_date desc) as piu_rank
		FROM openchpl.promoting_interoperability_user piu
		WHERE piu.deleted <> true) piu_ranked
	WHERE piu_ranked.piu_rank = 1) piuResult
	ON piuResult.certified_product_id = cp.certified_product_id
LEFT JOIN
  (SELECT string_agg(DISTINCT child_chpl_product_number||'☹'||children.child_listing_id::text, '☹'::text) AS child,
          parent_listing_id FROM
     (SELECT certified_product.certified_product_id, listing_to_listing_map.parent_listing_id, listing_to_listing_map.child_listing_id,
        (SELECT chpl_product_number
         FROM openchpl.get_chpl_product_number(child_listing_id)) AS child_chpl_product_number
      FROM openchpl.listing_to_listing_map
      JOIN openchpl.certified_product ON listing_to_listing_map.deleted = false 
		AND listing_to_listing_map.parent_listing_id = certified_product.certified_product_id) children
   GROUP BY parent_listing_id) child ON cp.certified_product_id = child.parent_listing_id
LEFT JOIN
  (SELECT string_agg(DISTINCT parent_chpl_product_number||'☹'||parents.parent_listing_id::text, '☹'::text) AS parent,
          parents.child_listing_id FROM
     (SELECT certified_product.certified_product_id, listing_to_listing_map.child_listing_id, listing_to_listing_map.parent_listing_id,
        (SELECT chpl_product_number
         FROM openchpl.get_chpl_product_number(parent_listing_id)) AS parent_chpl_product_number, certified_product.chpl_product_number
      FROM openchpl.listing_to_listing_map
      JOIN openchpl.certified_product ON listing_to_listing_map.deleted = false 
		AND listing_to_listing_map.child_listing_id = certified_product.certified_product_id) parents
   GROUP BY child_listing_id) parent ON cp.certified_product_id = parent.child_listing_id
LEFT JOIN
  (SELECT certification_edition.certification_edition_id,
          certification_edition.year
   FROM openchpl.certification_edition) edition ON cp.certification_edition_id = edition.certification_edition_id
LEFT JOIN
  (SELECT certification_body.certification_body_id,
          certification_body.name AS certification_body_name,
          certification_body.acb_code AS certification_body_code
   FROM openchpl.certification_body) acb ON cp.certification_body_id = acb.certification_body_id
LEFT JOIN
  (SELECT practice_type.practice_type_id,
          practice_type.name AS practice_type_name
   FROM openchpl.practice_type) prac ON cp.practice_type_id = prac.practice_type_id
LEFT JOIN
  (SELECT product_version.product_version_id,
          product_version.version AS product_version,
          product_version.product_id
   FROM openchpl.product_version) VERSION ON cp.product_version_id = version.product_version_id
LEFT JOIN
  (SELECT product_1.product_id,
          product_1.vendor_id,
          product_1.name AS product_name
   FROM openchpl.product product_1) product ON version.product_id = product.product_id
LEFT JOIN
  (SELECT vendor_1.vendor_id,
          vendor_1.name AS vendor_name,
          vendor_1.vendor_code,
          vendor_1.vendor_status_id
   FROM openchpl.vendor vendor_1) vendor ON product.vendor_id = vendor.vendor_id
     LEFT JOIN ( SELECT vshistory.vendor_status_id,
            vshistory.vendor_id,
            vshistory.status_date AS last_vendor_status_change
           FROM openchpl.vendor_status_history vshistory
           JOIN (SELECT vendor_status_history.vendor_id,
                    max(vendor_status_history.status_date) AS status_date
                   FROM openchpl.vendor_status_history
                  WHERE vendor_status_history.deleted = false
                  GROUP BY vendor_status_history.vendor_id) vsinner ON vshistory.deleted = false AND vshistory.vendor_id = vsinner.vendor_id AND vshistory.status_date = vsinner.status_date) vendor_status_history ON vendor_status_history.vendor_id = vendor.vendor_id
     LEFT JOIN ( SELECT vendor_status.vendor_status_id,
            vendor_status.name AS vendor_status_name
           FROM openchpl.vendor_status) vendor_status ON vendor_status_history.vendor_status_id = vendor_status.vendor_status_id
LEFT JOIN
  (SELECT string_agg(vendor_1.name, '|') AS history_vendor_name,
          product_owner_history_map.product_id AS history_product_id
   FROM openchpl.vendor vendor_1
   JOIN openchpl.product_owner_history_map ON vendor_1.vendor_id = product_owner_history_map.vendor_id
   WHERE product_owner_history_map.deleted = FALSE
   GROUP BY history_product_id) owners ON owners.history_product_id = product.product_id
LEFT JOIN
  (SELECT min(certification_status_event.event_date) AS certification_date,
          certification_status_event.certified_product_id
   FROM openchpl.certification_status_event
   WHERE certification_status_event.certification_status_id = 1
     AND certification_status_event.deleted = FALSE
   GROUP BY certification_status_event.certified_product_id) certstatusevent ON cp.certified_product_id = certstatusevent.certified_product_id
LEFT JOIN
  (SELECT max(certification_status_event.event_date) AS decertification_date,
          certification_status_event.certified_product_id
   FROM openchpl.certification_status_event
   WHERE certification_status_event.certification_status_id = ANY (ARRAY[3::bigint,
                                                                         4::bigint,
                                                                         8::bigint,
																		 9::bigint])
     AND certification_status_event.deleted = FALSE
   GROUP BY certification_status_event.certified_product_id) decert ON cp.certified_product_id = decert.certified_product_id
LEFT JOIN
  (SELECT surveillance.certified_product_id,
          count(*) AS count_surveillance_activities
   FROM openchpl.surveillance
   WHERE surveillance.deleted <> TRUE
   GROUP BY surveillance.certified_product_id) survs ON cp.certified_product_id = survs.certified_product_id
LEFT JOIN
  (SELECT surv.certified_product_id,
          count(*) AS count_open_surveillance_activities
   FROM openchpl.surveillance surv
   WHERE surv.deleted <> TRUE
     AND surv.start_date <= now() AND (surv.end_date IS NULL OR surv.end_date > now())
   GROUP BY surv.certified_product_id) surv_open ON cp.certified_product_id = surv_open.certified_product_id
LEFT JOIN
  (SELECT surv.certified_product_id,
          count(*) AS count_closed_surveillance_activities
   FROM openchpl.surveillance surv
   WHERE surv.deleted <> TRUE
     AND surv.start_date <= now() AND surv.end_date IS NOT NULL AND surv.end_date <= now()
   GROUP BY surv.certified_product_id) surv_closed ON cp.certified_product_id = surv_closed.certified_product_id
LEFT JOIN
  (SELECT surv.certified_product_id,
          count(*) AS count_open_nonconformities
   FROM openchpl.surveillance surv
   JOIN openchpl.surveillance_requirement surv_req ON surv.id = surv_req.surveillance_id
   AND surv_req.deleted <> TRUE
   JOIN openchpl.surveillance_nonconformity surv_nc ON surv_req.id = surv_nc.surveillance_requirement_id
   AND surv_nc.deleted <> TRUE
   WHERE surv.deleted <> TRUE
     AND surv_nc.non_conformity_close_date is null
   GROUP BY surv.certified_product_id) nc_open ON cp.certified_product_id = nc_open.certified_product_id
LEFT JOIN
  (SELECT surv.certified_product_id,
          count(*) AS count_closed_nonconformities
   FROM openchpl.surveillance surv
   JOIN openchpl.surveillance_requirement surv_req ON surv.id = surv_req.surveillance_id
   AND surv_req.deleted <> TRUE
   JOIN openchpl.surveillance_nonconformity surv_nc ON surv_req.id = surv_nc.surveillance_requirement_id
   AND surv_nc.deleted <> TRUE
   WHERE surv.deleted <> TRUE
     AND surv_nc.non_conformity_close_date is not null
   GROUP BY surv.certified_product_id) nc_closed ON cp.certified_product_id = nc_closed.certified_product_id
LEFT JOIN
  (SELECT surv.certified_product_id,
          STRING_AGG(
		(EXTRACT(EPOCH FROM surv.start_date)*1000)::text
		||'&'||
		COALESCE((EXTRACT(EPOCH FROM surv.end_date)*1000)::text, ''), '☺') AS surv_dates
   FROM openchpl.surveillance surv
   WHERE surv.deleted = FALSE
   GROUP BY surv.certified_product_id) AS surv_dates ON surv_dates.certified_product_id = cp.certified_product_id
LEFT JOIN
	(select cse.certified_product_id, string_agg(date(cse.event_date)||':'||cs.certification_status, '&') as status_events
	from openchpl.certification_status_event cse
	join openchpl.certification_status cs on cs.certification_status_id = cse.certification_status_id
	where cse.deleted = false
	group by cse.certified_product_id) as status_events ON status_events.certified_product_id = cp.certified_product_id
LEFT JOIN
  (SELECT certification_result.certified_product_id,
          string_agg(DISTINCT certification_criterion.certification_criterion_id::text, '☺') AS cert_number
   FROM openchpl.certification_criterion
   JOIN openchpl.certification_result ON certification_criterion.certification_criterion_id = certification_result.certification_criterion_id
   WHERE certification_result.success = TRUE
     AND certification_result.deleted = FALSE
     AND certification_criterion.deleted = FALSE
   GROUP BY certified_product_id) AS certs ON certs.certified_product_id = cp.certified_product_id
LEFT JOIN
  (SELECT string_agg(DISTINCT certification_criterion.certification_criterion_id::text||'☹'||certification_result.api_documentation, '☺') AS cert_number, --certification_result.api_documentation,
 certification_result.certified_product_id
   FROM openchpl.certification_criterion
   JOIN openchpl.certification_result ON certification_criterion.certification_criterion_id = certification_result.certification_criterion_id
   WHERE certification_result.success = TRUE
     AND certification_result.api_documentation IS NOT NULL
     AND certification_result.deleted = FALSE
     AND certification_criterion.deleted = FALSE
   GROUP BY certified_product_id) certs_with_api_documentation ON certs_with_api_documentation.certified_product_id = cp.certified_product_id
LEFT JOIN
  (SELECT string_agg(DISTINCT certification_criterion.certification_criterion_id::text||'☹'||certification_result.service_base_url_list, '☺') AS cert_number, --certification_result.service_base_url_list,
 certification_result.certified_product_id
   FROM openchpl.certification_criterion
   JOIN openchpl.certification_result ON certification_criterion.certification_criterion_id = certification_result.certification_criterion_id
   WHERE certification_result.success = TRUE
     AND certification_result.service_base_url_list IS NOT NULL
     AND certification_result.deleted = FALSE
     AND certification_criterion.deleted = FALSE
   GROUP BY certified_product_id) certs_with_service_base_url_list ON certs_with_service_base_url_list.certified_product_id = cp.certified_product_id
LEFT JOIN
  (SELECT string_agg(DISTINCT COALESCE(cqm_criterion.cms_id, ('NQF-'::text || cqm_criterion.nqf_number::text)::CHARACTER varying), '☺') AS cqm_number,
          cqm_result.certified_product_id
   FROM openchpl.cqm_criterion
   JOIN openchpl.cqm_result ON cqm_criterion.cqm_criterion_id = cqm_result.cqm_criterion_id
   WHERE cqm_result.success = TRUE
     AND cqm_result.deleted = FALSE
     AND cqm_criterion.deleted = FALSE
   GROUP BY certified_product_id) cqms ON cqms.certified_product_id = cp.certified_product_id
WHERE cp.deleted <> TRUE;

-- deprecated
CREATE VIEW openchpl.certified_product_search_result as
SELECT all_listings_simple.*,
    certs_for_listing.cert_number,
    COALESCE(cqms_for_listing.cms_id, 'NQF-'||cqms_for_listing.nqf_number) as "cqm_number"
FROM
    (SELECT
	cp.certified_product_id,
        (select chpl_product_number from openchpl.get_chpl_product_number(cp.certified_product_id)),
	lastCertStatusEvent.certification_status_name,
	piuResult.promoting_interoperability_user_count,
	piuResult.promoting_interoperability_user_count_date,
	cp.mandatory_disclosures,
	edition.year,
	acb.certification_body_name,
	cp.acb_certification_id,
	prac.practice_type_name,
	version.product_version,
	product.product_name,
	vendor.vendor_name,
	history_vendor_name as "prev_vendor",
	certStatusEvent.certification_date,
        lastCuresUpdateEvent.cures_update,
	decert.decertification_date,
	COALESCE(count_surveillance_activities, 0) as "count_surveillance_activities",
	COALESCE(count_open_nonconformities, 0) as "count_open_nonconformities",
	COALESCE(count_closed_nonconformities, 0) as "count_closed_nonconformities"
    FROM openchpl.certified_product cp
    --certification date
	INNER JOIN (SELECT MIN(event_date) as "certification_date", certified_product_id from openchpl.certification_status_event where certification_status_id = 1 group by (certified_product_id)) certStatusEvent on cp.certified_product_id = certStatusEvent.certified_product_id
    --year
	LEFT JOIN (SELECT certification_edition_id, year FROM openchpl.certification_edition) edition on cp.certification_edition_id = edition.certification_edition_id
    --ACB
	INNER JOIN (SELECT certification_body_id, name as "certification_body_name", acb_code as "certification_body_code" FROM openchpl.certification_body) acb on cp.certification_body_id = acb.certification_body_id
    -- version
	INNER JOIN (SELECT product_version_id, version as "product_version", product_id from openchpl.product_version) version on cp.product_version_id = version.product_version_id
    --product
	INNER JOIN (SELECT product_id, vendor_id, name as "product_name" FROM openchpl.product) product ON version.product_id = product.product_id
    --developer
	INNER JOIN (SELECT vendor_id, name as "vendor_name", vendor_code FROM openchpl.vendor) vendor on product.vendor_id = vendor.vendor_id
    --certification status
	INNER JOIN (
	SELECT certStatus.certification_status as "certification_status_name", cse.certified_product_id as "certified_product_id"
	FROM openchpl.certification_status_event cse
	    INNER JOIN openchpl.certification_status certStatus ON cse.certification_status_id = certStatus.certification_status_id
	    INNER JOIN
	    (SELECT certified_product_id, extract(epoch from MAX(event_date)) event_date
	    FROM openchpl.certification_status_event
	    GROUP BY certified_product_id) maxCse
	    ON cse.certified_product_id = maxCse.certified_product_id
	--conversion to epoch/long comparison significantly faster than comparing the timestamp fields as-is
	    AND extract(epoch from cse.event_date) = maxCse.event_date
	    ) lastCertStatusEvent
	ON lastCertStatusEvent.certified_product_id = cp.certified_product_id
    --cures update status
	LEFT JOIN (
	SELECT cue.cures_update, cue.certified_product_id as "certified_product_id"
	FROM openchpl.cures_update_event cue
	    INNER JOIN
	    (SELECT certified_product_id, extract(epoch from MAX(event_date)) event_date
	    FROM openchpl.cures_update_event
	    GROUP BY certified_product_id) maxCue
	    ON cue.certified_product_id = maxCue.certified_product_id
	--conversion to epoch/long comparison significantly faster than comparing the timestamp fields as-is
	    AND extract(epoch from cue.event_date) = maxCue.event_date
	    ) lastCuresUpdateEvent
	ON lastCuresUpdateEvent.certified_product_id = cp.certified_product_id
	-- promoting interoperability users count
	LEFT JOIN (
		SELECT piu.user_count as promoting_interoperability_user_count, 
		piu.certified_product_id,
		piu.user_count_date as promoting_interoperability_user_count_date
		FROM openchpl.promoting_interoperability_user piu
			INNER JOIN
			(SELECT certified_product_id, extract(epoch from MAX(user_count_date)) user_count_date
			FROM openchpl.promoting_interoperability_user
			GROUP BY certified_product_id) maxPiu
			ON piu.certified_product_id = maxPiu.certified_product_id
		--conversion to epoch/long comparison significantly faster than comparing the timestamp fields as-is
			AND extract(epoch from piu.user_count_date) = maxPiu.user_count_date
			) piuResult
	ON piuResult.certified_product_id = cp.certified_product_id
    -- Practice type (2014 only)
	LEFT JOIN (SELECT practice_type_id, name as "practice_type_name" FROM openchpl.practice_type) prac on cp.practice_type_id = prac.practice_type_id
    --decertification date
	LEFT JOIN (SELECT MAX(event_date) as "decertification_date", certified_product_id from openchpl.certification_status_event where certification_status_id IN (3, 4, 8, 9) group by (certified_product_id)) decert on cp.certified_product_id = decert.certified_product_id
    -- developer history
	LEFT JOIN (SELECT name as "history_vendor_name", product_owner_history_map.product_id as "history_product_id"
	FROM openchpl.vendor
	    JOIN openchpl.product_owner_history_map ON vendor.vendor_id = product_owner_history_map.vendor_id
	WHERE product_owner_history_map.deleted = false) prev_vendor_owners
	ON prev_vendor_owners.history_product_id = product.product_id
    -- surveillance
	LEFT JOIN
        (SELECT certified_product_id, count(*) as "count_surveillance_activities"
        FROM openchpl.surveillance
        WHERE openchpl.surveillance.deleted <> true
        GROUP BY certified_product_id) survs
        ON cp.certified_product_id = survs.certified_product_id
        LEFT JOIN
        (SELECT certified_product_id, count(*) as "count_open_nonconformities"
        FROM openchpl.surveillance surv
            JOIN openchpl.surveillance_requirement surv_req ON surv.id = surv_req.surveillance_id AND surv_req.deleted <> true
            JOIN openchpl.surveillance_nonconformity surv_nc ON surv_req.id = surv_nc.surveillance_requirement_id AND surv_nc.deleted <> true
        WHERE surv.deleted <> true AND surv_nc.non_conformity_close_date is null
        GROUP BY certified_product_id) nc_open
        ON cp.certified_product_id = nc_open.certified_product_id
        LEFT JOIN
        (SELECT certified_product_id, count(*) as "count_closed_nonconformities"
        FROM openchpl.surveillance surv
            JOIN openchpl.surveillance_requirement surv_req ON surv.id = surv_req.surveillance_id AND surv_req.deleted <> true
            JOIN openchpl.surveillance_nonconformity surv_nc ON surv_req.id = surv_nc.surveillance_requirement_id AND surv_nc.deleted <> true
        WHERE surv.deleted <> true AND surv_nc.non_conformity_close_date is not null
        GROUP BY certified_product_id) nc_closed
        ON cp.certified_product_id = nc_closed.certified_product_id
	) all_listings_simple
--certs (adds so many rows to the result set it's faster to join it out here)
    LEFT OUTER JOIN
    (
    SELECT certification_criterion.number as "cert_number", certification_result.certified_product_id
    FROM openchpl.certification_result, openchpl.certification_criterion
    WHERE certification_criterion.certification_criterion_id = certification_result.certification_criterion_id
	AND certification_criterion.deleted = false
	AND certification_result.success = true
	AND certification_result.deleted = false
	) certs_for_listing
    ON certs_for_listing.certified_product_id = all_listings_simple.certified_product_id
--cqms (adds so many rows to the result set it's faster to join it out here)
    LEFT OUTER JOIN
    (
    SELECT cms_id, nqf_number, certified_product_id
    FROM openchpl.cqm_result, openchpl.cqm_criterion
    WHERE cqm_criterion.cqm_criterion_id = cqm_result.cqm_criterion_id
	AND cqm_criterion.deleted = false
	AND cqm_result.success = true
	AND cqm_result.deleted = false
	) cqms_for_listing
    ON cqms_for_listing.certified_product_id = all_listings_simple.certified_product_id;

CREATE VIEW openchpl.developer_certification_statuses AS
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
--certification status
    LEFT JOIN (
    SELECT cse.certification_status_id as "certification_status_id", cse.certified_product_id as "certified_product_id"
    FROM openchpl.certification_status_event cse
	INNER JOIN
	(SELECT certified_product_id, extract(epoch from MAX(event_date)) event_date
	FROM openchpl.certification_status_event
	GROUP BY certified_product_id) maxCse
	ON cse.certified_product_id = maxCse.certified_product_id
    --conversion to epoch/long comparison significantly faster than comparing the timestamp fields as-is
	AND extract(epoch from cse.event_date) = maxCse.event_date
	) lastCertStatusEvent
    ON lastCertStatusEvent.certified_product_id = cp.certified_product_id
    LEFT JOIN openchpl.certification_status cs ON lastCertStatusEvent.certification_status_id = cs.certification_status_id
GROUP BY v.vendor_id;

--ALTER TABLE openchpl.developer_certification_statuses OWNER TO openchpl;

CREATE VIEW openchpl.product_certification_statuses AS
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
--certification status
    LEFT JOIN (
    SELECT cse.certification_status_id as "certification_status_id", cse.certified_product_id as "certified_product_id"
    FROM openchpl.certification_status_event cse
	INNER JOIN
	(SELECT certified_product_id, extract(epoch from MAX(event_date)) event_date
	FROM openchpl.certification_status_event
	GROUP BY certified_product_id) maxCse
	ON cse.certified_product_id = maxCse.certified_product_id
    --conversion to epoch/long comparison significantly faster than comparing the timestamp fields as-is
	AND extract(epoch from cse.event_date) = maxCse.event_date
	) lastCertStatusEvent
    ON lastCertStatusEvent.certified_product_id = cp.certified_product_id

    LEFT JOIN openchpl.certification_status cs ON lastCertStatusEvent.certification_status_id = cs.certification_status_id
GROUP BY p.product_id;

CREATE VIEW openchpl.ehr_certification_ids_and_products AS
SELECT
    row_number() OVER () AS id,
    ehr.ehr_certification_id_id as ehr_certification_id,
    ehr.certification_id as ehr_certification_id_text,
    ehr.creation_date as ehr_certification_id_creation_date,
    cp.certified_product_id,
    (select chpl_product_number from openchpl.get_chpl_product_number(cp.certified_product_id))
FROM openchpl.ehr_certification_id ehr
    LEFT JOIN openchpl.ehr_certification_id_product_map prodMap
    ON ehr.ehr_certification_id_id = prodMap.ehr_certification_id_id
    LEFT JOIN openchpl.certified_product cp
    ON prodMap.certified_product_id = cp.certified_product_id
    ;

CREATE VIEW openchpl.product_active_owner_history_map AS
SELECT id,
    product_id,
    vendor_id,
    transfer_date,
    creation_date,
    last_modified_date,
    last_modified_user,
    last_modified_sso_user,
    deleted
FROM openchpl.product_owner_history_map
WHERE deleted = false;

CREATE VIEW openchpl.certified_product_summary AS
 SELECT cp.certified_product_id,
	(select chpl_product_number from openchpl.get_chpl_product_number(cp.certified_product_id)),
    cp.certification_edition_id,
    cp.product_version_id,
    cp.certification_body_id,
    cp.report_file_location,
    cp.sed_report_file_location,
    cp.sed_intended_user_description,
    cp.sed_testing_end,
    cp.acb_certification_id,
    cp.practice_type_id,
    cp.product_classification_type_id,
    cp.product_additional_software,
    cp.other_acb,
    cp.mandatory_disclosures,
    cp.ics,
    cp.sed,
    cp.qms,
    cp.accessibility_certified,
    cp.product_code,
    cp.version_code,
    cp.ics_code,
    cp.additional_software_code,
    cp.certified_date_code,
    cp.creation_date,
    cp.last_modified_date,
    cp.last_modified_user,
    cp.last_modified_sso_user,
    cp.deleted,
    cp.rwt_plans_url,
    cp.rwt_plans_check_date,
    cp.rwt_results_url,
    cp.rwt_results_check_date,
    cp.svap_notice_url,
    piuResult.promoting_interoperability_user_count,
    ce.year,
    p.name AS product_name,
    v.name AS vendor_name,
    v.vendor_code,
	contact.full_name,
	contact.email,
	contact.phone_number,
	pv.version,
    cs.certification_status,
    r.last_certification_status_change AS certification_date,
    lastCuresUpdateEvent.cures_update,
    cb.acb_code,
    cb.name AS certification_body_name,
    cb.website AS certification_body_website
   FROM openchpl.certified_product cp
     LEFT JOIN openchpl.certification_edition ce ON cp.certification_edition_id = ce.certification_edition_id
	 LEFT JOIN ( SELECT cse.certification_status_id,
            cse.certified_product_id,
            cse.last_certification_status_change
           FROM ( SELECT cse_inner.certification_status_id,
                    cse_inner.certified_product_id,
                    cse_inner.event_date AS last_certification_status_change,
                    row_number() OVER (PARTITION BY cse_inner.certified_product_id ORDER BY cse_inner.event_date DESC) AS rownum
                   FROM openchpl.certification_status_event cse_inner
                  WHERE cse_inner.deleted = false) cse
          WHERE cse.rownum = 1) r ON r.certified_product_id = cp.certified_product_id
     JOIN openchpl.certification_status cs ON cs.certification_status_id = r.certification_status_id
	 LEFT OUTER JOIN (
		SELECT cue.cures_update, cue.certified_product_id as "certified_product_id"
		FROM openchpl.cures_update_event cue
			INNER JOIN
			(SELECT certified_product_id, extract(epoch from MAX(event_date)) event_date
			FROM openchpl.cures_update_event
			GROUP BY certified_product_id) maxCue
			ON cue.certified_product_id = maxCue.certified_product_id
		--conversion to epoch/long comparison significantly faster than comparing the timestamp fields as-is
			AND extract(epoch from cue.event_date) = maxCue.event_date
			) lastCuresUpdateEvent
	 ON lastCuresUpdateEvent.certified_product_id = cp.certified_product_id
     JOIN openchpl.product_version pv ON cp.product_version_id = pv.product_version_id
     JOIN openchpl.product p ON pv.product_id = p.product_id
     JOIN openchpl.vendor v ON p.vendor_id = v.vendor_id
	 LEFT OUTER JOIN ( SELECT contact.contact_id,
            contact.full_name,
            contact.email,
            contact.phone_number,
            contact.title
           FROM openchpl.contact) contact ON v.contact_id = contact.contact_id
     JOIN openchpl.certification_body cb ON cp.certification_body_id = cb.certification_body_id
	 LEFT OUTER JOIN ( SELECT piu.user_count as promoting_interoperability_user_count,
            piu.certified_product_id,
            piu.user_count_date AS promoting_interoperability_user_count_date
           FROM openchpl.promoting_interoperability_user piu
             JOIN ( SELECT promoting_interoperability_user.certified_product_id,
                    max(promoting_interoperability_user.user_count_date) AS user_count_date
                   FROM openchpl.promoting_interoperability_user
                  WHERE promoting_interoperability_user.deleted <> true
                  GROUP BY promoting_interoperability_user.certified_product_id) piuInner ON piu.certified_product_id = piuInner.certified_product_id 
					AND piu.user_count_date = piuInner.user_count_date
          WHERE piu.deleted <> true) piuResult ON piuResult.certified_product_id = cp.certified_product_id;

CREATE VIEW openchpl.listings_from_banned_developers AS
SELECT
	listing.certified_product_id,
    listing.deleted,
    acb.certification_body_id AS acb_id,
	acb.name as acb_name,
    dev.vendor_id AS developer_id,
	dev.name AS developer_name,
    devStatusList.developer_status_id,
    devStatusList.developer_status_name,
    devStatusHistory.last_dev_status_change
FROM openchpl.certified_product listing
     LEFT JOIN openchpl.certification_body acb ON listing.certification_body_id = acb.certification_body_id
     LEFT JOIN openchpl.product_version ver ON listing.product_version_id = ver.product_version_id and ver.deleted = false
     LEFT JOIN openchpl.product prod ON ver.product_id = prod.product_id and prod.deleted = false
     LEFT JOIN openchpl.vendor dev ON prod.vendor_id = dev.vendor_id and dev.deleted = false
     LEFT JOIN ( SELECT vshistory.vendor_status_id,
            vshistory.vendor_id,
            vshistory.status_date AS last_dev_status_change
           FROM openchpl.vendor_status_history vshistory
             JOIN ( SELECT vendor_status_history.vendor_id,
                    max(vendor_status_history.status_date) AS status_date
                   FROM openchpl.vendor_status_history
                  WHERE vendor_status_history.deleted = false
                  GROUP BY vendor_status_history.vendor_id) vsinner 
				ON vshistory.vendor_id = vsinner.vendor_id 
				AND vshistory.status_date = vsinner.status_date
				AND vshistory.deleted = false) devStatusHistory ON devStatusHistory.vendor_id = dev.vendor_id
     LEFT JOIN ( SELECT vendor_status.vendor_status_id as developer_status_id,
            vendor_status.name AS developer_status_name
           FROM openchpl.vendor_status) devStatusList ON devStatusHistory.vendor_status_id = devStatusList.developer_status_id
WHERE listing.deleted = false
AND acb.retired = false
AND developer_status_name = 'Under certification ban by ONC';

CREATE OR REPLACE VIEW openchpl.developer_certification_body_map
AS
SELECT DISTINCT cp.certification_body_id, dev.vendor_id
FROM openchpl.certified_product cp
	JOIN openchpl.product_version prod_ver
		ON cp.product_version_id = prod_ver.product_version_id
   	JOIN openchpl.product prod
   		ON prod_ver.product_id = prod.product_id
    JOIN openchpl.vendor dev
    	ON prod.vendor_id = dev.vendor_id
    JOIN (SELECT cse.certification_status_id,
    		cse.certified_product_id,
            cse.last_certification_status_change
         FROM (SELECT cse_inner.certification_status_id,
         		cse_inner.certified_product_id,
                cse_inner.event_date AS last_certification_status_change,
                ROW_NUMBER() OVER (
                	PARTITION BY cse_inner.certified_product_id
                    ORDER BY cse_inner.event_date DESC) rownum
             FROM openchpl.certification_status_event cse_inner
             WHERE cse_inner.deleted = false) cse
         WHERE cse.rownum = 1
			AND cse.certification_status_id IN (1, 6, 7)) as listing_status
		ON cp.certified_product_id = listing_status.certified_product_id;

CREATE OR REPLACE VIEW openchpl.requirement_type
AS
SELECT certification_criterion_id as id, title, number, start_day, end_day, certification_edition_id, 1 as requirement_group_type_id
FROM openchpl.certification_criterion
WHERE (certification_edition_id IS NULL 
	OR certification_edition_id != (SELECT certification_edition_id FROM openchpl.certification_edition where year = '2011'))
UNION
SELECT id, name, null, null, null, null, requirement_group_type_id
FROM openchpl.additional_requirement_type
WHERE deleted = false;

CREATE OR REPLACE VIEW openchpl.nonconformity_type
AS
SELECT certification_criterion_id as id, certification_edition_id, number, title, start_day, end_day, 'CRITERION' as classification
FROM openchpl.certification_criterion
WHERE (certification_edition_id IS null
	OR certification_edition_id != (SELECT certification_edition_id FROM openchpl.certification_edition where year = '2011'))
UNION
SELECT id, null, null, name, null, null, 'REQUIREMENT'
FROM openchpl.additional_nonconformity_type
WHERE DELETED = false;

CREATE OR REPLACE VIEW openchpl.questionable_activity_combined
AS
	SELECT row_number() over() as id, all_questionable_activity.developer_id, all_questionable_activity.developer_name, 
	all_questionable_activity.product_id, all_questionable_activity.product_name,
	all_questionable_activity.version_id, all_questionable_activity.version_name, 
	all_questionable_activity.certified_product_id, all_questionable_activity.certification_criterion_id,
	all_questionable_activity.before_data, all_questionable_activity.after_data, 
	all_questionable_activity.activity_date, all_questionable_activity.reason, 
	all_questionable_activity.certification_status_change_reason,
	all_questionable_activity.activity_id, 
	all_questionable_activity.activity_user_id, 
	trigger.level as trigger_level, trigger.name as trigger_name,
	listing_search.chpl_product_number,
	listing_search.certification_body_id,
	listing_search.certification_body_name,
	listing_search.certification_status_id,
	listing_search.certification_status_name,
	COALESCE(c.email, u.user_name, c.full_name) as user_contact_info
	FROM (
			SELECT dev.vendor_id as developer_id, dev.name as developer_name, prod.product_id, prod.name as product_name,
				ver.product_version_id as version_id, ver.version as version_name,
				cp.certified_product_id, cc.certification_criterion_id, 
				before_data, after_data, activity_date, reason, 
				null as certification_status_change_reason, activity_id, 
				activity_user_id, questionable_activity_trigger_id
			FROM openchpl.questionable_activity_certification_result qacr
			JOIN openchpl.questionable_activity_trigger qa_trigger ON qacr.questionable_activity_trigger_id = qa_trigger.id
			JOIN openchpl.certification_result cr ON cr.certification_result_id = qacr.certification_result_id
			JOIN openchpl.certification_criterion cc ON cr.certification_criterion_id = cc.certification_criterion_id
			JOIN openchpl.certified_product cp ON cr.certified_product_id = cp.certified_product_id
			JOIN openchpl.product_version ver ON cp.product_version_id = ver.product_version_id
			JOIN openchpl.product prod ON prod.product_id = ver.product_id
			JOIN openchpl.vendor dev ON prod.vendor_id = dev.vendor_id
			WHERE qacr.deleted = false
		UNION
			SELECT dev.vendor_id as developer_id, dev.name as developer_name, prod.product_id, prod.name as product_name,
				ver.product_version_id as version_id, ver.version as version_name, cp.certified_product_id, 
				null, before_data, after_data, activity_date, reason, certification_status_change_reason, activity_id,
				activity_user_id, questionable_activity_trigger_id
			FROM openchpl.questionable_activity_listing qal
			JOIN openchpl.questionable_activity_trigger qa_trigger ON qal.questionable_activity_trigger_id = qa_trigger.id
			JOIN openchpl.certified_product cp ON qal.listing_id = cp.certified_product_id
			JOIN openchpl.product_version ver ON cp.product_version_id = ver.product_version_id
			JOIN openchpl.product prod ON prod.product_id = ver.product_id
			JOIN openchpl.vendor dev ON prod.vendor_id = dev.vendor_id
			WHERE qal.deleted = false
		UNION
			SELECT dev.vendor_id as developer_id, dev.name as developer_name, prod.product_id, 
				prod.name as product_name, ver.product_version_id, ver.version as version_name,
				null, null, before_data, after_data, activity_date, null, null, activity_id,
				activity_user_id, questionable_activity_trigger_id
			FROM openchpl.questionable_activity_version qav
			JOIN openchpl.questionable_activity_trigger qa_trigger ON qav.questionable_activity_trigger_id = qa_trigger.id
			JOIN openchpl.product_version ver ON ver.product_version_id = qav.version_id
			JOIN openchpl.product prod ON prod.product_id = ver.product_id
			JOIN openchpl.vendor dev ON dev.vendor_id = prod.vendor_id
			WHERE qav.deleted = false
		UNION
			SELECT dev.vendor_id as developer_id, dev.name as developer_name, prod.product_id, 
				prod.name as product_name, null, null, null, null, before_data, after_data, activity_date, 
				null, null, activity_id, activity_user_id, questionable_activity_trigger_id
			FROM openchpl.questionable_activity_product qap
			JOIN openchpl.questionable_activity_trigger qa_trigger ON qap.questionable_activity_trigger_id = qa_trigger.id
			JOIN openchpl.product prod ON prod.product_id = qap.product_id
			JOIN openchpl.vendor dev ON dev.vendor_id = prod.vendor_id
			WHERE qap.deleted = false
		UNION
			SELECT dev.vendor_id as developer_id, dev.name as developer_name, null, null, null, null, null, null, 
				before_data, after_data, activity_date, null, null, activity_id,
				activity_user_id, questionable_activity_trigger_id
			FROM openchpl.questionable_activity_developer qad
			JOIN openchpl.questionable_activity_trigger qa_trigger ON qad.questionable_activity_trigger_id = qa_trigger.id
			JOIN openchpl.vendor dev ON dev.vendor_id = qad.developer_id
			WHERE qad.deleted = false
	) all_questionable_activity
	JOIN openchpl.questionable_activity_trigger trigger ON all_questionable_activity.questionable_activity_trigger_id = trigger.id
	LEFT JOIN openchpl.listing_search ON all_questionable_activity.certified_product_id = listing_search.certified_product_id
	JOIN openchpl.user u on all_questionable_activity.activity_user_id = u.user_id
	JOIN openchpl.contact c on u.contact_id = c.contact_id;

	
