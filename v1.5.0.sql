CREATE TABLE openchpl.test_participant_age(
	test_participant_age_id bigserial NOT NULL,
	age varchar(32),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT test_participant_age_pk PRIMARY KEY (test_participant_age_id)
);

alter TABLE openchpl.test_participant
    ADD COLUMN test_participant_age_id bigint,
    ADD CONSTRAINT test_participant_age_fk FOREIGN KEY (test_participant_age_id)
	REFERENCES openchpl.test_participant_age (test_participant_age_id) MATCH FULL
	ON DELETE RESTRICT ON UPDATE CASCADE;

alter TABLE openchpl.pending_test_participant
    ADD COLUMN test_participant_age_id bigint,
    ADD CONSTRAINT test_participant_age_fk FOREIGN KEY (test_participant_age_id)
	REFERENCES openchpl.test_participant_age (test_participant_age_id) MATCH FULL
	ON DELETE RESTRICT ON UPDATE CASCADE;

CREATE TRIGGER test_participant_age_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.test_participant_age FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER test_participant_age_timestamp BEFORE UPDATE on openchpl.test_participant_age FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

insert into openchpl.test_participant_age (age, last_modified_user) values
('0-9', -1),
('10-19', -1),
('20-29', -1),
('30-39', -1),
('40-49', -1),
('50-59', -1),
('60-69', -1),
('70-79', -1),
('80-89', -1),
('90-99', -1),
('100+', -1);

GRANT ALL ON ALL TABLES IN SCHEMA openchpl TO openchpl;
GRANT ALL ON ALL TABLES IN SCHEMA audit TO openchpl;
GRANT ALL ON ALL SEQUENCES IN SCHEMA openchpl TO openchpl;
GRANT ALL ON ALL SEQUENCES IN SCHEMA audit TO openchpl;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA openchpl TO openchpl;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA audit TO openchpl;
