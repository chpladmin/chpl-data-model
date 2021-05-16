DROP TABLE IF EXISTS openchpl.criterion_listing_statistic;
DROP TABLE IF EXISTS openchpl.privacy_and_security_listing_statistic;
DROP TABLE IF EXISTS openchpl.listing_cures_status_statistic;
DROP TABLE IF EXISTS openchpl.listing_to_cures_criterion;

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

--what makes a listing require P&S? It's 2015, Active status, and doesn't currently have d12/d13?
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

--criterion needed to make the current listing cures
--question: can there be multiple ways the listing can become cures?, for example could it remove a1 OR add d12 & d13?
CREATE TABLE openchpl.listing_to_cures_criterion (
	id bigserial NOT NULL,
	listing_id bigint NOT NULL,
	certification_criterion_id bigint NOT NULL,
	statistic_date date NOT NULL, -- the date to which this statistic applies
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_user bigint NOT NULL,
	deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT listing_to_cures_criterion_pk PRIMARY KEY (id),
	CONSTRAINT listing_fk FOREIGN KEY (listing_id)
		REFERENCES openchpl.certified_product (certified_product_id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT certification_criterion_fk FOREIGN KEY (certification_criterion_id)
		REFERENCES openchpl.certification_criterion (certification_criterion_id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE
);