-- remove deprecated response fields from /search/beta
-- remove deprecated response field usage from /search/beta
-- add /search/beta as deprecated endpoint

-- add necessary ids and other fields to db view
DROP VIEW IF EXISTS openchpl.listing_search;
CREATE VIEW openchpl.listing_search AS
SELECT cp.certified_product_id,
       child.children,
       parent.parents,
       certs.certification_criteria_met,
       cqms.cqms_met,
       openchpl.get_chpl_product_number(cp.certified_product_id) AS chpl_product_number,
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
       certs_with_api_documentation.criteria_with_api_documentation,
       certs_with_service_base_url_list.criteria_with_service_base_url,
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
      JOIN openchpl.certified_product ON listing_to_listing_map.parent_listing_id = certified_product.certified_product_id) children
   GROUP BY parent_listing_id) child ON cp.certified_product_id = child.parent_listing_id
LEFT JOIN
  (SELECT string_agg(DISTINCT parents.parent_listing_id::text||':'||parent_chpl_product_number, '|'::text) AS parents,
          parents.child_listing_id FROM
     (SELECT certified_product.certified_product_id, listing_to_listing_map.child_listing_id, listing_to_listing_map.parent_listing_id,
        (SELECT chpl_product_number
         FROM openchpl.get_chpl_product_number(parent_listing_id)) AS parent_chpl_product_number, certified_product.chpl_product_number
      FROM openchpl.listing_to_listing_map
      JOIN openchpl.certified_product ON listing_to_listing_map.child_listing_id = certified_product.certified_product_id) parents
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
  (SELECT string_agg(vendor_1.vendor_id||':'||vendor_1.name, '|') AS history_vendor_id_and_name,
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
                                                                         8::bigint])
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
						||certification_result.service_base_url_list, '☺') AS criteria_with_service_base_url,
	certification_result.certified_product_id
	FROM openchpl.certification_criterion
	JOIN openchpl.certification_result ON certification_criterion.certification_criterion_id = certification_result.certification_criterion_id
	WHERE certification_result.success = TRUE
    AND certification_result.service_base_url_list IS NOT NULL
    AND certification_result.deleted = FALSE
    AND certification_criterion.deleted = FALSE
	GROUP BY certified_product_id) certs_with_service_base_url_list ON certs_with_service_base_url_list.certified_product_id = cp.certified_product_id
LEFT JOIN
  (SELECT string_agg(DISTINCT cqm_criterion.cqm_criterion_id||':'||COALESCE(cqm_criterion.cms_id, ('NQF-'::text || cqm_criterion.nqf_number::text)::CHARACTER varying), '|') AS cqms_met,
          cqm_result.certified_product_id
   FROM openchpl.cqm_criterion
   JOIN openchpl.cqm_result ON cqm_criterion.cqm_criterion_id = cqm_result.cqm_criterion_id
   WHERE cqm_result.success = TRUE
     AND cqm_result.deleted = FALSE
     AND cqm_criterion.deleted = FALSE
   GROUP BY certified_product_id) cqms ON cqms.certified_product_id = cp.certified_product_id
WHERE cp.deleted <> TRUE;