DROP TABLE IF EXISTS openchpl.listing_validation_report;

CREATE TABLE openchpl.listing_validation_report (
  id                        bigserial NOT NULL,
  certified_product_id      bigint NOT NULL,
  chpl_product_number       text NOT NULL,
  certification_body_id     bigint NOT NULL,
  product                   text NOT NULL,
  version                   text NOT NULL,
  developer                 text NOT NULL,
  certification_body        text NOT NULL,
  certification_status_name text NOT NULL,
  listing_modified_date     timestamp NOT NULL,
  error_message             text NOT NULL,
  report_date               timestamp NOT NULL DEFAULT NOW(),
  creation_date             timestamp NOT NULL DEFAULT NOW(),
  last_modified_date        timestamp NOT NULL DEFAULT NOW(),
  last_modified_user        bigint NOT NULL,
  deleted                   boolean NOT NULL DEFAULT false,
  CONSTRAINT PK_listing_validation_report PRIMARY KEY ( id )
);

CREATE TRIGGER listing_validation_report_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.listing_validation_report FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER listing_validation_report_timestamp BEFORE UPDATE on openchpl.listing_validation_report FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
