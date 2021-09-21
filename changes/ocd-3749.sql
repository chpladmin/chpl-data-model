ALTER TABLE openchpl.certification_criterion_attribute ADD COLUMN IF NOT EXISTS conformance_method BOOL NOT NULL DEFAULT FALSE;
ALTER TABLE openchpl.certification_criterion_attribute ADD COLUMN IF NOT EXISTS test_procedure BOOL NOT NULL DEFAULT FALSE;

update openchpl.certification_criterion_attribute set test_procedure = true where criterion_id >= 61 and criterion_id <= 119; -- all 2014 Criteria can have TP

update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id <= 60 or criterion_id >= 165; -- assumes all 2015 Criteria can have CM (assumption is important to removed criteria)

drop table if exists openchpl.conformance_method cascade;
CREATE TABLE openchpl.conformance_method (
	id bigserial NOT NULL,
	name varchar(255) NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT conformance_method_pk PRIMARY KEY (id)
);

drop table if exists openchpl.pending_certification_result_conformance_method;
CREATE TABLE openchpl.pending_certification_result_conformance_method (
	id bigserial NOT NULL,
	pending_certification_result_id bigint NOT NULL,
	conformance_method_id bigint,
	conformance_method_name text,
	version varchar(50) NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT pending_certification_result_conformance_method_pk PRIMARY KEY (id),
	CONSTRAINT pending_certification_result_fk FOREIGN KEY (pending_certification_result_id)
		REFERENCES openchpl.pending_certification_result (pending_certification_result_id) MATCH SIMPLE
		ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT conformance_method_fk FOREIGN KEY (conformance_method_id)
		REFERENCES openchpl.conformance_method (id) MATCH FULL
		ON DELETE RESTRICT ON UPDATE CASCADE
);

drop table if exists openchpl.certification_result_conformance_method;
CREATE TABLE openchpl.certification_result_conformance_method (
	id bigserial NOT NULL,
	certification_result_id bigint NOT NULL,
	conformance_method_id bigint NOT NULL,
	version varchar(50) NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT certification_result_conformance_method_pk PRIMARY KEY (id),
	CONSTRAINT certification_result_fk FOREIGN KEY (certification_result_id)
		REFERENCES openchpl.certification_result (certification_result_id) MATCH FULL
		ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT conformance_method_fk FOREIGN KEY (conformance_method_id)
		REFERENCES openchpl.conformance_method (id) MATCH FULL
		ON DELETE RESTRICT ON UPDATE CASCADE
);

drop table if exists openchpl.conformance_method_criteria_map;
CREATE TABLE openchpl.conformance_method_criteria_map (
	id bigserial NOT NULL,
	criteria_id bigint NOT NULL,
	conformance_method_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT conformance_method_criteria_map_pk PRIMARY KEY (id),
	CONSTRAINT conformance_method_criteria_fk FOREIGN KEY (criteria_id)
		REFERENCES openchpl.certification_criterion (certification_criterion_id)
		MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT conformance_method_fk FOREIGN KEY (conformance_method_id)
		REFERENCES openchpl.conformance_method (id)
		MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TRIGGER certification_result_conformance_method_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certification_result_conformance_method FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certification_result_conformance_method_timestamp BEFORE UPDATE on openchpl.certification_result_conformance_method FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER conformance_method_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.conformance_method FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER conformance_method_timestamp BEFORE UPDATE on openchpl.conformance_method FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER conformance_method_criteria_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.conformance_method_criteria_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER conformance_method_criteria_map_timestamp BEFORE UPDATE on openchpl.conformance_method_criteria_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_certification_result_conformance_method_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_certification_result_conformance_method FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_certification_result_conformance_method_timestamp BEFORE UPDATE on openchpl.pending_certification_result_conformance_method FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

insert into openchpl.conformance_method (name, last_modified_user) values
('Attestation', -1),
('ONC Test Procedure', -1),
('NCQA eCQM Test Method', -1),
('HIMSS-IIP Test Method', -1),
('ONC Test Method - Surescripts (Alternative)', -1);

-- Attestation
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(1)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(2)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(3)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(4)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(5)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(9)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(10)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(12)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(13)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(14)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(15)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(10)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(1)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(2)' and title like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(2)' and title not like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(3)' and title like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(3)' and title not like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(4)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(5)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(6)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(7)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(8)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(9)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(10)' and title like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(10)' and title not like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(11)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(12)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(13)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'Attestation'), -1;
-- ONC Test Procedure
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(1)' and title like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(1)' and title not like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(2)' and title like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(2)' and title not like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(3)' and title like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(3)' and title not like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(6)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(7)' and title like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(7)' and title not like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(8)' and title like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(8)' and title not like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(9)' and title like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(9)' and title not like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (c)(1)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (c)(2)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (c)(3)' and title like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (c)(3)' and title not like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (c)(4)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (e)(1)' and title like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (e)(1)' and title not like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (e)(2)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (e)(3)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (f)(1)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (f)(2)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (f)(3)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (f)(4)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (f)(5)' and title like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (f)(5)' and title not like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (f)(6)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (f)(7)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(1)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(2)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(3)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(4)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(5)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(6)' and title like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(6)' and title not like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(7)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(8)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(9)' and title like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(9)' and title not like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(10)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (h)(1)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (h)(2)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'ONC Test Procedure'), -1;
-- NCQA eCQM Test Method
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (c)(2)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'NCQA eCQM Test Method'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (c)(3)' and title not like '%(Cures Update)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'NCQA eCQM Test Method'), -1;
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (c)(4)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'NCQA eCQM Test Method'), -1;
-- HIMSS-IIP Test Method
insert into openchpl.conformance_method_criteria_map (criteria_id, conformance_method_id, last_modified_user) select (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (f)(1)'), (select cm.id from openchpl.conformance_method cm where cm.name = 'HIMSS-IIP Test Method'), -1;
-- ONC Test Method - Surescripts (Alternative)
