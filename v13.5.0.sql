DROP TABLE IF EXISTS openchpl.participant_gender_statistics;

CREATE TABLE openchpl.participant_gender_statistics
(
  	id bigserial NOT NULL,
  	male_count bigint NOT NULL,
	female_count bigint NOT NULL,
	unknown_count bigint NOT NULL,
  	creation_date timestamp without time zone NOT NULL DEFAULT now(),
  	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
  	last_modified_user bigint NOT NULL,
  	deleted boolean NOT NULL DEFAULT false,
  CONSTRAINT participant_gender_statistics_pk PRIMARY KEY (id)
);

CREATE TRIGGER participant_gender_statistics_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.participant_gender_statistics FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER participant_gender_statistics_timestamp BEFORE UPDATE on openchpl.participant_gender_statistics FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

DROP TABLE IF EXISTS openchpl.participant_age_statistics;

CREATE TABLE openchpl.participant_age_statistics
(
  	id bigserial NOT NULL, 
  	age_count bigint NOT NULL,
	test_participant_age_id bigint NOT NULL REFERENCES openchpl.test_participant_age (test_participant_age_id),
  	creation_date timestamp without time zone NOT NULL DEFAULT now(),
  	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
  	last_modified_user bigint NOT NULL,
  	deleted boolean NOT NULL DEFAULT false,
  CONSTRAINT participant_age_statistics_pk PRIMARY KEY (id)
);

CREATE TRIGGER participant_age_statistics_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.participant_age_statistics FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER participant_age_statistics_timestamp BEFORE UPDATE on openchpl.participant_age_statistics FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

DROP TABLE IF EXISTS openchpl.participant_education_statistics;

CREATE TABLE openchpl.participant_education_statistics
(
  	id bigserial NOT NULL,
  	education_count bigint NOT NULL,
	education_type_id bigint NOT NULL REFERENCES openchpl.education_type (education_type_id),
  	creation_date timestamp without time zone NOT NULL DEFAULT now(),
  	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
  	last_modified_user bigint NOT NULL,
  	deleted boolean NOT NULL DEFAULT false,
  CONSTRAINT participant_education_statistics_pk PRIMARY KEY (id)
);

CREATE TRIGGER participant_education_statistics_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.participant_education_statistics FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER participant_education_statistics_timestamp BEFORE UPDATE on openchpl.participant_education_statistics FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();


DROP TABLE IF EXISTS openchpl.participant_experience_statistics;

CREATE TABLE openchpl.participant_experience_statistics
(
  	id bigserial NOT NULL,
	experience_type_id bigint NOT NULL,
  	participant_count bigint NOT NULL,
	experience_months bigint NOT NULL,
  	creation_date timestamp without time zone NOT NULL DEFAULT now(),
  	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
  	last_modified_user bigint NOT NULL,
  	deleted boolean NOT NULL DEFAULT false,
  CONSTRAINT participant_experience_statistics_pk PRIMARY KEY (id)
);

CREATE TRIGGER participant_experience_statistics_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.participant_experience_statistics FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER participant_experience_statistics_timestamp BEFORE UPDATE on openchpl.participant_experience_statistics FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

--re-run grants
\i dev/openchpl_grant-all.sql