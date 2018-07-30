-- OCD - 2351 - nonconformity chart statistics

DROP TABLE IF EXISTS openchpl.nonconformity_type_statistics;
CREATE TABLE openchpl.nonconformity_type_statistics
(
  	id bigserial NOT NULL,
  	nonconformity_type varchar(1024),
	nonconformity_count bigint NOT NULL,
  	creation_date timestamp without time zone NOT NULL DEFAULT now(),
  	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
  	last_modified_user bigint NOT NULL,
  	deleted boolean NOT NULL DEFAULT false,
  	CONSTRAINT nonconformity_type_statistics_pk PRIMARY KEY (id)
);
CREATE TRIGGER nonconformity_type_statistics_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.nonconformity_type_statistics FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER nonconformity_type_statistics_timestamp BEFORE UPDATE on openchpl.nonconformity_type_statistics FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

-- OCD-2275 - Migrate Summary Statistics
DROP TABLE IF EXISTS openchpl.summary_statistics;
CREATE TABLE openchpl.summary_statistics
(
    summary_statistics_id bigserial NOT NULL,
    end_date timestamp without time zone NOT NULL,
    summary_statistics json,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
    CONSTRAINT summary_statistics_pk PRIMARY KEY (summary_statistics_id)
);
CREATE TRIGGER summary_statistics_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.summary_statistics FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER summary_statistics_timestamp BEFORE UPDATE on openchpl.summary_statistics FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

DROP VIEW IF EXISTS openchpl.certified_product_summary;

CREATE OR REPLACE VIEW openchpl.certified_product_summary AS
 SELECT cp.certified_product_id,
    cp.certification_edition_id,
    cp.product_version_id,
    cp.testing_lab_id,
    cp.certification_body_id,
    cp.chpl_product_number,
    cp.report_file_location,
    cp.sed_report_file_location,
    cp.sed_intended_user_description,
    cp.sed_testing_end,
    cp.acb_certification_id,
    cp.practice_type_id,
    cp.product_classification_type_id,
    cp.product_additional_software,
    cp.other_acb,
    cp.transparency_attestation_url,
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
    cp.deleted,
    cp.meaningful_use_users,
    cp.pending_certified_product_id,
    ce.year,
    p.name AS product_name,
    v.name AS vendor_name,
    v.vendor_code,
    cs.certification_status,
    cb.acb_code,
    cb.name AS certification_body_name,
    cb.website AS certification_body_website
   FROM openchpl.certified_product cp
     JOIN openchpl.certification_edition ce ON cp.certification_edition_id = ce.certification_edition_id
     JOIN ( SELECT cse.certification_status_id,
            cse.certified_product_id,
            cse.event_date AS last_certification_status_change
           FROM openchpl.certification_status_event cse
             JOIN ( SELECT certification_status_event.certified_product_id,
                    max(certification_status_event.event_date) AS event_date
                   FROM openchpl.certification_status_event
                  WHERE certification_status_event.deleted <> true
                  GROUP BY certification_status_event.certified_product_id) cseinner ON cse.certified_product_id = cseinner.certified_product_id AND cse.event_date = cseinner.event_date
          WHERE cse.deleted <> true) max_cse ON max_cse.certified_product_id = cp.certified_product_id
     JOIN openchpl.certification_status cs ON cs.certification_status_id = max_cse.certification_status_id
     JOIN openchpl.product_version pv ON cp.product_version_id = pv.product_version_id
     JOIN openchpl.product p ON pv.product_id = p.product_id
     JOIN openchpl.vendor v ON p.vendor_id = v.vendor_id
     JOIN openchpl.certification_body cb ON cp.certification_body_id = cb.certification_body_id;


--re-run grants	
\i dev/openchpl_grant-all.sql