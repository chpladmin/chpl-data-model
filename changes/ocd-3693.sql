CREATE TABLE IF NOT EXISTS openchpl.cures_statistics_by_acb (
	id bigserial NOT NULL,
	certification_body_id bigint NOT NULL,
	original_criterion_id bigint,
	cures_criterion_id bigint,
	original_criterion_upgraded_count bigint,
	cures_criterion_created_count bigint,
	statistic_date timestamp NOT NULL DEFAULT NOW(),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT cures_statistics_by_acb_pk PRIMARY KEY (id),
	CONSTRAINT certification_body_id_fk FOREIGN KEY (certification_body_id)
      REFERENCES openchpl.certification_body (certification_body_id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT original_criterion_id_fk FOREIGN KEY (original_criterion_id)
      REFERENCES openchpl.certification_criterion (certification_criterion_id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT cures_criterion_id_fk FOREIGN KEY (cures_criterion_id)
      REFERENCES openchpl.certification_criterion (certification_criterion_id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);
