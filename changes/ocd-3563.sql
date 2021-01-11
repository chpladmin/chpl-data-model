DROP TABLE IF EXISTS openchpl.listing_validation_report;

CREATE TABLE openchpl.listing_validation_report (
  id                        bigserial NOT NULL,
  chpl_product_number       text NOT NULL,
  product_name              text NOT NULL,
  certification_status_name text NOT NULL,
  error_message             text NOT NULL,
  report_date               timestamp with time zone NOT NULL,
  creation_date             timestamp with time zone NOT NULL DEFAULT NOW(),
  last_modified_date        timestamp with time zone NOT NULL DEFAULT NOW(),
  last_modified_user        bigint NOT NULL,
  deleted                   boolean NOT NULL DEFAULT false,
  CONSTRAINT PK_listing_validation_report PRIMARY KEY ( id )
);

CREATE TRIGGER listing_validation_report_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.listing_validation_report FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER listing_validation_report_timestamp BEFORE UPDATE on openchpl.listing_validation_report FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();