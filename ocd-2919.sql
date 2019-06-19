DROP TABLE IF EXISTS openchpl.quarterly_report_excluded_listing_map;

CREATE TABLE openchpl.quarterly_report_excluded_listing_map (
    id bigserial not null,
    quarterly_report_id bigint not null,
    listing_id bigint not null,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
    CONSTRAINT quarterly_report_excluded_listing_map_pk PRIMARY KEY (id),
    CONSTRAINT quarterly_report_fk FOREIGN KEY (quarterly_report_id)
		REFERENCES openchpl.quarterly_report (id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
    CONSTRAINT listing_fk FOREIGN KEY (listing_id)
		REFERENCES openchpl.certified_product (certified_product_id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE TRIGGER quarterly_report_excluded_listing_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.quarterly_report_excluded_listing_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER quarterly_report_excluded_listing_map_timestamp BEFORE UPDATE on openchpl.quarterly_report_excluded_listing_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();