--
-- OCD-1897 Tables, triggers, and population of tables
--
drop table if exists openchpl.certified_product_testing_lab_map;
create table openchpl.certified_product_testing_lab_map (
   id bigserial not null,
   certified_product_id bigint not null,
 testing_lab_id bigint not null,
   creation_date timestamp without time zone not null default now(),
   last_modified_date timestamp without time zone not null default now(),
   last_modified_user bigint not null,
   deleted boolean not null default false,
        constraint certified_product_testing_lab_map_pk primary key (id),
 constraint certified_product_fk foreign key (certified_product_id)
        references openchpl.certified_product (certified_product_id) match simple
        on update no action on delete no action,
 constraint testing_lab_fk foreign key (testing_lab_id)
        references openchpl.testing_lab (testing_lab_id) match simple
        on update no action on delete no action
);

insert into openchpl.certified_product_testing_lab_map (certified_product_id, testing_lab_id, last_modified_user) select certified_product_id, testing_lab_id, -1 from openchpl.certified_product as cp where cp.testing_lab_id is not null;

-- debug
insert into openchpl.certified_product_testing_lab_map (certified_product_id, testing_lab_id, last_modified_user) values (9111, 4, -1);
-- end debug

create trigger certified_product_testing_lab_map_audit after insert or update or delete on openchpl.certified_product_testing_lab_map for each row execute procedure audit.if_modified_func();
create trigger certified_product_testing_lab_map_timestamp before update on openchpl.certified_product_testing_lab_map for each row execute procedure openchpl.update_last_modified_date_column();

drop table if exists openchpl.pending_certified_product_testing_lab_map;
create table openchpl.pending_certified_product_testing_lab_map (
   id bigserial not null,
   pending_certified_product_id bigint not null,
 testing_lab_id bigint not null,
   creation_date timestamp without time zone not null default now(),
   last_modified_date timestamp without time zone not null default now(),
   last_modified_user bigint not null,
   deleted boolean not null default false,
        constraint pending_certified_product_testing_lab_map_pk primary key (id),
 constraint pending_certified_product_fk foreign key (pending_certified_product_id)
        references openchpl.pending_certified_product (pending_certified_product_id) match simple
        on update no action on delete no action,
 constraint testing_lab_fk foreign key (testing_lab_id)
        references openchpl.testing_lab (testing_lab_id) match simple
        on update no action on delete no action
);

create trigger pending_certified_product_testing_lab_map_audit after insert or update or delete on openchpl.pending_certified_product_testing_lab_map for each row execute procedure audit.if_modified_func();
create trigger pending_certified_product_testing_lab_map_timestamp before update on openchpl.pending_certified_product_testing_lab_map for each row execute procedure openchpl.update_last_modified_date_column();

--
-- OCD-1897 CHPL Product Number function & Views
--
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
            COALESCE(a.chpl_product_number, substring(b.year from 3 for 2)||'.'||(select openchpl.get_testing_lab_code(a.certified_product_id))||'.'||c.certification_body_code||'.'||h.vendor_code||'.'||a.product_code||'.'||a.version_code||'.'||a.ics_code||'.'||a.additional_software_code||'.'||a.certified_date_code) as "chpl_product_number"
                FROM openchpl.certified_product a
                    LEFT JOIN (SELECT certification_edition_id, year FROM openchpl.certification_edition) b on a.certification_edition_id = b.certification_edition_id
                    LEFT JOIN (SELECT certification_body_id, name as "certification_body_name", acb_code as "certification_body_code", deleted as "acb_is_deleted" FROM openchpl.certification_body) c on a.certification_body_id = c.certification_body_id
                    LEFT JOIN (SELECT product_version_id, version as "product_version", product_id from openchpl.product_version) f on a.product_version_id = f.product_version_id
                    LEFT JOIN (SELECT product_id, vendor_id, name as "product_name" FROM openchpl.product) g ON f.product_id = g.product_id
                    LEFT JOIN (SELECT vendor_id, name as "vendor_name", vendor_code, website as "vendor_website", address_id as "vendor_address", contact_id as "vendor_contact", vendor_status_id from openchpl.vendor) h on g.vendor_id = h.vendor_id
                WHERE a.certified_product_id = id;
end;
$$ language plpgsql
stable;

DROP VIEW IF EXISTS openchpl.certified_product_details CASCADE;
CREATE OR REPLACE VIEW openchpl.certified_product_details AS

SELECT
    a.certified_product_id,
    a.certification_edition_id,
    a.product_version_id,
    a.certification_body_id,
(select chpl_product_number from openchpl.get_chpl_product_number(a.certified_product_id)),
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
    p.transparency_attestation

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
    ;

DROP VIEW IF EXISTS openchpl.certified_product_search;
CREATE OR REPLACE VIEW openchpl.certified_product_search AS

SELECT
    cp.certified_product_id,
    string_agg(DISTINCT (select chpl_product_number from openchpl.get_chpl_product_number(cp.certified_product_id))||'☹'||child.certified_product_id::text, '☺') as "child",
    string_agg(DISTINCT (select chpl_product_number from openchpl.get_chpl_product_number(cp.certified_product_id))||'☹'||parent.certified_product_id::text, '☺') as "parent",
    string_agg(DISTINCT certs.cert_number::text, '☺') as "certs",
    string_agg(DISTINCT cqms.cqm_number::text, '☺') as "cqms",
(select chpl_product_number from openchpl.get_chpl_product_number(cp.certified_product_id)) as "chpl_product_number",
 cp.meaningful_use_users,
 cp.transparency_attestation_url,
    edition.year,
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
    LEFT JOIN (SELECT certified_product_id, chpl_product_number, child_listing_id, parent_listing_id FROM (SELECT certified_product_id, child_listing_id, parent_listing_id, chpl_product_number FROM openchpl.listing_to_listing_map INNER JOIN openchpl.certified_product on listing_to_listing_map.child_listing_id = certified_product.certified_product_id) children) child ON cp.certified_product_id = child.parent_listing_id
    LEFT JOIN (SELECT certified_product_id, chpl_product_number, child_listing_id, parent_listing_id FROM (SELECT certified_product_id, child_listing_id, parent_listing_id, chpl_product_number FROM openchpl.listing_to_listing_map INNER JOIN openchpl.certified_product on listing_to_listing_map.parent_listing_id = certified_product.certified_product_id) parents) parent ON cp.certified_product_id = parent.child_listing_id
    LEFT JOIN (SELECT certification_edition_id, year FROM openchpl.certification_edition) edition on cp.certification_edition_id = edition.certification_edition_id
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
GROUP BY cp.certified_product_id, cp.acb_certification_id, edition.year, acb.certification_body_code, vendor.vendor_code, cp.product_code, cp.version_code,cp.ics_code, cp.additional_software_code, cp.certified_date_code, cp.transparency_attestation_url,
acb.certification_body_name,prac.practice_type_name,version.product_version,product.product_name,vendor.vendor_name,certStatusEvent.certification_date,certStatus.certification_status_name, decert.decertification_date,
survs.count_surveillance_activities, nc_open.count_open_nonconformities, nc_closed.count_closed_nonconformities
;

DROP VIEW openchpl.certified_product_search_result;
CREATE OR REPLACE VIEW openchpl.certified_product_search_result
AS
 SELECT all_listings_simple.*,
   certs_for_listing.cert_number,
   COALESCE(cqms_for_listing.cms_id, 'NQF-'||cqms_for_listing.nqf_number) as "cqm_number"
  FROM
  (SELECT
      cp.certified_product_id,
                    (select chpl_product_number from openchpl.get_chpl_product_number(cp.certified_product_id)),
   lastCertStatusEvent.certification_status_name,
   cp.meaningful_use_users,
   cp.transparency_attestation_url,
   edition.year,
   acb.certification_body_name,
   cp.acb_certification_id,
   prac.practice_type_name,
   version.product_version,
   product.product_name,
   vendor.vendor_name,
   history_vendor_name as "prev_vendor",
   certStatusEvent.certification_date,
   decert.decertification_date,
   COALESCE(count_surveillance_activities, 0) as "count_surveillance_activities",
   COALESCE(count_open_nonconformities, 0) as "count_open_nonconformities",
   COALESCE(count_closed_nonconformities, 0) as "count_closed_nonconformities"
  FROM openchpl.certified_product cp

  --certification date
  INNER JOIN (SELECT MIN(event_date) as "certification_date", certified_product_id from openchpl.certification_status_event where certification_status_id = 1 group by (certified_product_id)) certStatusEvent on cp.certified_product_id = certStatusEvent.certified_product_id

  --year
  INNER JOIN (SELECT certification_edition_id, year FROM openchpl.certification_edition) edition on cp.certification_edition_id = edition.certification_edition_id

  --ACB
  INNER JOIN (SELECT certification_body_id, name as "certification_body_name", acb_code as "certification_body_code", deleted as "acb_is_deleted" FROM openchpl.certification_body) acb on cp.certification_body_id = acb.certification_body_id

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

  -- Practice type (2014 only)
  LEFT JOIN (SELECT practice_type_id, name as "practice_type_name" FROM openchpl.practice_type) prac on cp.practice_type_id = prac.practice_type_id

  --decertification date
  LEFT JOIN (SELECT MAX(event_date) as "decertification_date", certified_product_id from openchpl.certification_status_event where certification_status_id IN (3, 4, 8) group by (certified_product_id)) decert on cp.certified_product_id = decert.certified_product_id

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
                JOIN openchpl.nonconformity_status nc_status ON surv_nc.nonconformity_status_id = nc_status.id
                WHERE surv.deleted <> true AND nc_status.name = 'Open'
                GROUP BY certified_product_id) nc_open
            ON cp.certified_product_id = nc_open.certified_product_id
            LEFT JOIN
                (SELECT certified_product_id, count(*) as "count_closed_nonconformities"
                FROM openchpl.surveillance surv
                JOIN openchpl.surveillance_requirement surv_req ON surv.id = surv_req.surveillance_id AND surv_req.deleted <> true
                JOIN openchpl.surveillance_nonconformity surv_nc ON surv_req.id = surv_nc.surveillance_requirement_id AND surv_nc.deleted <> true
                JOIN openchpl.nonconformity_status nc_status ON surv_nc.nonconformity_status_id = nc_status.id
                WHERE surv.deleted <> true AND nc_status.name = 'Closed'
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

DROP VIEW openchpl.ehr_certification_ids_and_products;
CREATE OR REPLACE VIEW openchpl.ehr_certification_ids_and_products AS
SELECT
 row_number() OVER () AS id,
 ehr.ehr_certification_id_id as ehr_certification_id,
 ehr.certification_id as ehr_certification_id_text,
 ehr.creation_date as ehr_certification_id_creation_date,
 cp.certified_product_id,
 (select chpl_product_number from openchpl.get_chpl_product_number(cp.certified_product_id)),
 ed.year,
 (select testing_lab_code from openchpl.get_testing_lab_code(cp.certified_product_id)),
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
 LEFT JOIN (SELECT product_version_id, product_id from openchpl.product_version) pv on cp.product_version_id = pv.product_version_id
    LEFT JOIN (SELECT product_id, vendor_id FROM openchpl.product) prod ON pv.product_id = prod.product_id
 LEFT JOIN (SELECT vendor_id, vendor_code from openchpl.vendor) v ON prod.vendor_id = v.vendor_id
;
--re-run grants
\i dev/openchpl_grant-all.sql
