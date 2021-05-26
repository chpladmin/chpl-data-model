DROP TABLE IF EXISTS openchpl.criterion_listing_statistic;
DROP TABLE IF EXISTS openchpl.criterion_upgraded_from_original_listing_statistic;
DROP TABLE IF EXISTS openchpl.cures_criterion_upgraded_without_original_listing_statistic;
DROP TABLE IF EXISTS openchpl.privacy_and_security_listing_statistic;
DROP TABLE IF EXISTS openchpl.listing_cures_status_statistic;
DROP TABLE IF EXISTS openchpl.listing_to_criterion_for_cures_achievement_statistic;

CREATE TABLE openchpl.criterion_listing_statistic (
	id bigserial NOT NULL,
	listing_count bigint NOT NULL,
	certification_criterion_id bigint NOT NULL,
	statistic_date date NOT NULL, -- the date to which this statistic applies
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_user bigint NOT NULL,
	deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT criterion_listing_statistic_pk PRIMARY KEY (id),
	CONSTRAINT certification_criterion_fk FOREIGN KEY (certification_criterion_id)
		REFERENCES openchpl.certification_criterion (certification_criterion_id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX idx_criterion_listing_stat_date on openchpl.criterion_listing_statistic (statistic_date);

CREATE TRIGGER criterion_listing_statistic_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.criterion_listing_statistic FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER criterion_listing_statistic_timestamp BEFORE UPDATE on openchpl.criterion_listing_statistic FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

CREATE TABLE openchpl.criterion_upgraded_from_original_listing_statistic (
	id bigserial NOT NULL,
	listing_count bigint NOT NULL,
	certification_criterion_id bigint NOT NULL,
	statistic_date date NOT NULL, -- the date to which this statistic applies
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_user bigint NOT NULL,
	deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT criterion_upgraded_from_original_listing_statistic_pk PRIMARY KEY (id),
	CONSTRAINT certification_criterion_fk FOREIGN KEY (certification_criterion_id)
		REFERENCES openchpl.certification_criterion (certification_criterion_id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX idx_criterion_upgraded_from_original_listing_stat_date on openchpl.criterion_upgraded_from_original_listing_statistic (statistic_date);

CREATE TRIGGER criterion_upgraded_from_original_listing_stat_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.criterion_upgraded_from_original_listing_statistic FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER criterion_upgraded_from_original_listing_stat_timestamp BEFORE UPDATE on openchpl.criterion_upgraded_from_original_listing_statistic FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

CREATE TABLE openchpl.cures_criterion_upgraded_without_original_listing_statistic (
	id bigserial NOT NULL,
	listing_count bigint NOT NULL,
	certification_criterion_id bigint NOT NULL,
	statistic_date date NOT NULL, -- the date to which this statistic applies
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_user bigint NOT NULL,
	deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT cures_criterion_upgraded_without_original_listing_statistic_pk PRIMARY KEY (id),
	CONSTRAINT certification_criterion_fk FOREIGN KEY (certification_criterion_id)
		REFERENCES openchpl.certification_criterion (certification_criterion_id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX idx_cures_criterion_upgraded_without_original_listing_stat_date on openchpl.cures_criterion_upgraded_without_original_listing_statistic (statistic_date);

CREATE TRIGGER cures_criterion_upgraded_without_orig_listing_stat_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.cures_criterion_upgraded_without_original_listing_statistic FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER cures_criterion_upgraded_without_orig_listing_stat_timestamp BEFORE UPDATE on openchpl.cures_criterion_upgraded_without_original_listing_statistic FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

CREATE TABLE openchpl.privacy_and_security_listing_statistic (
	id bigserial NOT NULL,
	listings_with_privacy_and_security_count bigint NOT NULL,
	listings_requiring_privacy_and_security_count bigint NOT NULL,
	statistic_date date NOT NULL, -- the date to which this statistic applies
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_user bigint NOT NULL,
	deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT privacy_and_security_listing_statistic_pk PRIMARY KEY (id)
);
CREATE INDEX idx_privacy_and_security_listing_stat_date on openchpl.privacy_and_security_listing_statistic (statistic_date);

CREATE TRIGGER privacy_and_security_listing_statistic_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.privacy_and_security_listing_statistic FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER privacy_and_security_listing_statistic_timestamp BEFORE UPDATE on openchpl.privacy_and_security_listing_statistic FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

CREATE TABLE openchpl.listing_cures_status_statistic (
	id bigserial NOT NULL,
	cures_listings_count bigint NOT NULL,
	total_listings_count bigint NOT NULL,
	statistic_date date NOT NULL, -- the date to which this statistic applies
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_user bigint NOT NULL,
	deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT listing_cures_status_statistic_pk PRIMARY KEY (id)
);
CREATE INDEX idx_listing_cures_status_stat_date on openchpl.listing_cures_status_statistic (statistic_date);

CREATE TRIGGER listing_cures_status_statistic_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.listing_cures_status_statistic FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER listing_cures_status_statistic_timestamp BEFORE UPDATE on openchpl.listing_cures_status_statistic FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

CREATE TABLE openchpl.listing_to_criterion_for_cures_achievement_statistic (
	id bigserial NOT NULL,
	listing_id bigint NOT NULL,
	certification_criterion_id bigint NOT NULL,
	statistic_date date NOT NULL, -- the date to which this statistic applies
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_user bigint NOT NULL,
	deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT listing_to_criterion_for_cures_achievement_statistic_pk PRIMARY KEY (id),
	CONSTRAINT listing_fk FOREIGN KEY (listing_id)
		REFERENCES openchpl.certified_product (certified_product_id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT certification_criterion_fk FOREIGN KEY (certification_criterion_id)
		REFERENCES openchpl.certification_criterion (certification_criterion_id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX idx_listing_to_criterion_for_cures_achievement_stat_date on openchpl.listing_to_criterion_for_cures_achievement_statistic (statistic_date);

CREATE TRIGGER listing_to_criterion_for_cures_achievement_statistic_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.listing_to_criterion_for_cures_achievement_statistic FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER listing_to_criterion_for_cures_achievement_statistic_timestamp BEFORE UPDATE on openchpl.listing_to_criterion_for_cures_achievement_statistic FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();