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

CREATE TABLE openchpl.listing_cures_status_statistic (
	id bigserial NOT NULL,
	cures_lisitngs_count bigint NOT NULL,
	total_listings_count bigint NOT NULL,
	statistic_date date NOT NULL, -- the date to which this statistic applies
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_user bigint NOT NULL,
	deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT listing_cures_status_statistic_pk PRIMARY KEY (id)
);

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