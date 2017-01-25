DROP TABLE IF EXISTS openchpl.pending_certification_result_g1_macra;
DROP TABLE IF EXISTS openchpl.pending_certification_result_g2_macra;
DROP TABLE IF EXISTS openchpl.certification_result_g1_macra;
DROP TABLE IF EXISTS openchpl.certification_result_g2_macra;
DROP TABLE IF EXISTS openchpl.macra_criteria_map;

--allowable values per criteria for g1/g2
CREATE TABLE openchpl.macra_criteria_map (
	id bigserial not null,
	criteria_id bigint not null,
	value varchar(100) not null,
	name varchar(255) not null,
	description varchar(512) not null,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT macra_criteria_map_pk PRIMARY KEY (id),	
	CONSTRAINT macra_criteria_fk FOREIGN KEY (criteria_id) 
		REFERENCES openchpl.certification_criterion (certification_criterion_id) 
		MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT macra_criteria_unique UNIQUE (criteria_id, value)
);

--the g1 macra attested to for certification results (maps back to certified product eventually)
CREATE TABLE openchpl.certification_result_g1_macra (
	id bigserial not null,
	macra_id bigint not null,
	certification_result_id bigint not null,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT certification_result_g1_macra_pk PRIMARY KEY (id),
	CONSTRAINT macra_g1_criteria_map_fk FOREIGN KEY (macra_id) 
		REFERENCES openchpl.macra_criteria_map (id) 
		MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE,	
	CONSTRAINT g1_macra_certification_result_fk FOREIGN KEY (certification_result_id) 
		REFERENCES openchpl.certification_result (certification_result_id) 
		MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);

--the g2 macra attested to for certification results (maps back to certified product eventually)
CREATE TABLE openchpl.certification_result_g2_macra (
	id bigserial not null,
	macra_id bigint not null,
	certification_result_id bigint not null,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT certification_result_g2_macra_pk PRIMARY KEY (id),
	CONSTRAINT macra_g2_criteria_map_fk FOREIGN KEY (macra_id) 
		REFERENCES openchpl.macra_criteria_map (id) 
		MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE,	
	CONSTRAINT g2_macra_certification_result_fk FOREIGN KEY (certification_result_id) 
		REFERENCES openchpl.certification_result (certification_result_id) 
		MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);

--the g1 macra attested to for pending certification result
CREATE TABLE openchpl.pending_certification_result_g1_macra (
	id bigserial not null,
	macra_id bigint, -- a macra that the udser entry could be mapped to
	macra_value varchar(255) not null, -- what the user entered
	pending_certification_result_id bigint not null,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT pending_certification_result_g1_macra_pk PRIMARY KEY (id),
	CONSTRAINT pending_g1_macra_criteria_map_fk FOREIGN KEY (macra_id) 
		REFERENCES openchpl.macra_criteria_map (id) 
		MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE,	
	CONSTRAINT g1_macra_pending_certification_result_fk FOREIGN KEY (pending_certification_result_id) 
		REFERENCES openchpl.pending_certification_result (pending_certification_result_id) 
		MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);

--the g2 macra attested to for pending certification result
CREATE TABLE openchpl.pending_certification_result_g2_macra (
	id bigserial not null,
	macra_id bigint, -- a macra that the udser entry could be mapped to
	macra_value varchar(255) not null, -- what the user entered
	pending_certification_result_id bigint not null,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT pending_certification_result_g2_macra_pk PRIMARY KEY (id),
	CONSTRAINT pending_g2_macra_criteria_map_fk FOREIGN KEY (macra_id) 
		REFERENCES openchpl.macra_criteria_map (id) 
		MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE,	
	CONSTRAINT g2_macra_pending_certification_result_fk FOREIGN KEY (pending_certification_result_id) 
		REFERENCES openchpl.pending_certification_result (pending_certification_result_id) 
		MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);

GRANT ALL ON TABLE openchpl.macra_criteria_map TO openchpl;
GRANT ALL ON TABLE openchpl.certification_result_g1_macra TO openchpl;
GRANT ALL ON TABLE openchpl.certification_result_g2_macra TO openchpl;
GRANT ALL ON TABLE openchpl.pending_certification_result_g1_macra TO openchpl;
GRANT ALL ON TABLE openchpl.pending_certification_result_g2_macra TO openchpl;
GRANT ALL ON SEQUENCE openchpl.macra_criteria_map_id_seq TO openchpl;
GRANT ALL ON SEQUENCE openchpl.certification_result_g1_macra_id_seq TO openchpl;
GRANT ALL ON SEQUENCE openchpl.certification_result_g2_macra_id_seq TO openchpl;
GRANT ALL ON SEQUENCE openchpl.pending_certification_result_g1_macra_id_seq TO openchpl;
GRANT ALL ON SEQUENCE openchpl.pending_certification_result_g2_macra_id_seq TO openchpl;

CREATE TRIGGER macra_criteria_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.macra_criteria_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER macra_criteria_map_timestamp BEFORE UPDATE on openchpl.macra_criteria_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER certification_result_g1_macra_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certification_result_g1_macra FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certification_result_g1_macra_timestamp BEFORE UPDATE on openchpl.certification_result_g1_macra FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER certification_result_g2_macra_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certification_result_g2_macra FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certification_result_g2_macra_timestamp BEFORE UPDATE on openchpl.certification_result_g2_macra FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_certification_result_g1_macra_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_certification_result_g1_macra FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_certification_result_g1_macra_timestamp BEFORE UPDATE on openchpl.pending_certification_result_g1_macra FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_certification_result_g2_macra_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_certification_result_g2_macra FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_certification_result_g2_macra_timestamp BEFORE UPDATE on openchpl.pending_certification_result_g2_macra FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();


INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(1)'), 'EP', 'Eligible Provider: Computerized Provider Order Entry', 'Required Test 10: Stage 2 Objective 3 Measure 1 and Stage 3 Objective 4 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(2)'), 'EP', 'Eligible Provider: Computerized Provider Order Entry', 'Required Test 11: Stage 2 Objective 3 Measure 2 and Stage 3 Objective 4 Measure 2', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(3)'), 'EP', 'Eligible Provider: Computerized Provider Order Entry', 'Required Test 12: Stage 2 Objective 3 Measure 3 and Stage 3 Objective 4 Measure 3', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(10)'), 'EP Individual', 
'Eligible Provider Individual: Electronic Prescribing', 'Required Test 1: Stage 2 Objective 4 and Stage 3 Objective 2', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(10)'), 'EP Individual (TIN/NPI)', 
'Eligible Clinician Individual (TIN/NPI): Electronic Prescribing', 'Required Test 1: Stage 2 Objective 4 and Stage 3 Objective 2', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(10)'), 'EC Group', 
'Eligible Clinician Group: Electronic Prescribing', 'Required Test 1: Stage 2 Objective 4 and Stage 3 Objective 2', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(10)'), 'EH/CAH', 
'Eligible Hospital/Critical Access Hospital: Electronic Prescribing', 'Required Test 1: Stage 2 Objective 4 and Stage 3 Objective 2', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(13)'), 'EP Individual', 
'Eligible Provider Individual: Patient-Specific Education', 'Required Test 3: Stage 2 Objective 6 and Stage 3 Objective 5 Measure 2', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(13)'), 'EP Individual (TIN/NPI)', 
'Eligible Clinician Individual (TIN/NPI): Patient-Specific Education', 'Required Test 3: Stage 2 Objective 6 and Stage 3 Objective 5 Measure 2', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(13)'), 'EC Group', 
'Eligible Clinician Group: Patient-Specific Education', 'Required Test 3: Stage 2 Objective 6 and Stage 3 Objective 5 Measure 2', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(13)'), 'EH/CAH', 
'Eligible Hospital/Critical Access Hospital: Patient-Specific Education', 'Required Test 3: Stage 2 Objective 6 and Stage 3 Objective 5 Measure 2', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(1)'), 'RT7 EP Individual',
'RT7 Eligible Provider Individual: Request/Accept Patient Care Record', 'Required Test 7: Stage 3 Objective 7 Measure 2', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(1)'), 'RT7 EC Individual (TIN/NPI)',
'RT7 Eligible Clinician Individual (TIN/NPI): Request/Accept Patient Care Record','Required Test 7: Stage 3 Objective 7 Measure 2', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(1)'), 'RT7 EC Group',
'RT7 Eligible Clinician Group: Request/Accept Patient Care Record','Required Test 7: Stage 3 Objective 7 Measure 2', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(1)'), 'RT7 EH/CAH',
'RT7 Eligible Hospital/Critical Access Hospital: Request/Accept Patient Care Record','Required Test 7: Stage 3 Objective 7 Measure 2', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(1)'), 'RT8 EP Individual',
'RT8 Eligible Provider Individual: Patient Care Record Exchange','Required Test 8: Stage 2 Objective 5 and Stage 3 Objective 7 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(1)'), 'RT8 EC Individual (TIN/NPI)',
'RT8 Eligible Clinician Individual (TIN/NPI): Patient Care Record Exchange','Required Test 8: Stage 2 Objective 5 and Stage 3 Objective 7 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(1)'), 'RT8 EC Group',
'RT8 Eligible Clinician Group: Patient Care Record Exchange','Required Test 8: Stage 2 Objective 5 and Stage 3 Objective 7 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(1)'), 'RT8 EH/CAH',
'RT8 Eligible Hospital/Critical Access Hospital:  Patient Care Record Exchange','Required Test 8: Stage 2 Objective 5 and Stage 3 Objective 7 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(2)'), 'EP Individual','Eligible Provider Individual: Medication/Clinical Information Reconciliation','Required Test 5: Stage 2 Objective 7 and Stage 3 Objective 7 Measure 3', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(2)'), 'EC Individual (TIN/NPI)','Eligible Clinician Individual (TIN/NPI): Medication/Clinical Information Reconciliation','Required Test 5: Stage 2 Objective 7 and Stage 3 Objective 7 Measure 3', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(2)'), 'EC Group','Eligible Clinician Group: Medication/Clinical Information Reconciliation','Required Test 5: Stage 2 Objective 7 and Stage 3 Objective 7 Measure 3', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(2)'), 'EH/CAH','Eligible Hospital/Critical Access Hospital: Medication/Clinical Information Reconciliation','Required Test 5: Stage 2 Objective 7 and Stage 3 Objective 7 Measure 3', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(3)'), 'EP Individual','Eligible Provider Individual: Electronic Prescribing','Required Test 1: Stage 2 Objective 4 and Stage 3 Objective 2', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(3)'), 'EC Individual (TIN/NPI)','Eligible Clinician Individual (TIN/NPI): Electronic Prescribing','Required Test 1: Stage 2 Objective 4 and Stage 3 Objective 2', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(3)'), 'EC Group','Eligible Clinician Group: Electronic Prescribing','Required Test 1: Stage 2 Objective 4 and Stage 3 Objective 2', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(3)'), 'EH/CAH','Eligible Hospital/Critical Access Hospital: Electronic Prescribing','Required Test 1: Stage 2 Objective 4 and Stage 3 Objective 2', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)'), 'RT2a EP Individual','RT2a Eligible Provider Individual: Patient Electronic Access','Required Test 2: Stage 2 Objective 8 Measure 1 and Stage 3 Objective 5 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)'), 'RT2a EC Individual (TIN/NPI)','RT2a Eligible Clinician Individual (TIN/NPI): Patient Electronic Access','Required Test 2: Stage 2 Objective 8 Measure 1 and Stage 3 Objective 5 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)'), 'RT2a EC Group','RT2a Eligible Clinician Group: Patient Electronic Access','Required Test 2: Stage 2 Objective 8 Measure 1 and Stage 3 Objective 5 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)'), 'RT2a EH/CAH','Patient Electronic Access','Required Test 2: Stage 2 Objective 8 Measure 1 and Stage 3 Objective 5 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)'), 'RT2b EP Individual','RT2b Eligible Provider Individual: Patient Electronic Access','Required Test 2: Stage 2 Objective 8 Measure 1 and Stage 3 Objective 5 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)'), 'RT2b EC Individual (TIN/NPI)','RT2b Eligible Clinician Individual (TIN/NPI): Patient Electronic Access','Required Test 2: Stage 2 Objective 8 Measure 1 and Stage 3 Objective 5 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)'), 'RT2b EC Group','RT2b Eligible Clinician Group: Patient Electronic Access','Required Test 2: Stage 2 Objective 8 Measure 1 and Stage 3 Objective 5 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)'), 'RT2b EH/CAH','Patient Electronic Access','Required Test 2: Stage 2 Objective 8 Measure 1 and Stage 3 Objective 5 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)'), 'RT4a EP Individual','RT4a Eligible Provider Individual: View, Download, or Transmit (VDT)','Required Test 4: Stage 2 Objective 8 Measure 2 and Stage 3 Objective 6 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)'), 'RT4a EC Individual (TIN/NPI)','RT4a Eligible Clinician Individual (TIN/NPI): View, Download, or Transmit (VDT)','Required Test 4: Stage 2 Objective 8 Measure 2 and Stage 3 Objctive 6 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)'), 'RT4a EC Group','RT4a Eligible Clinician Group: View, Download, or Transmit (VDT)','Required Test 4: Stage 2 Objective 8 Measure 2 and Stage 3 Objective 6 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)'), 'RT4a EH/CAH','View, Download, or Transmit (VDT)','Required Test 4: Stage 2 Objective 8 Measure 2 and Stage 3 Objective 6 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)'),'RT4b EP Individual','RT4b Eligible Provider Individual: View, Download, or Transmit (VDT)','Required Test 4: Stage 2 Objective 8 Measure 2 and Stage 3 Objective 6 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)'), 'RT4b EC Individual (TIN/NPI)','RT4b Eligible Clinician Individual (TIN/NPI): View, Download, or Transmit (VDT)','Required Test 4: Stage 2 Objective 8 Measure 2 and Stage 3 Objective 6 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)'), 'RT4b EC Group','RT4b Eligible Clinician Group: View, Download, or Transmit (VDT)','Required Test 4: Stage 2 Objective 8 Measure 2 and Stage 3 Objective 6 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)'), 'RT4b EH/CAH','View, Download, or Transmit (VDT)','Required Test 4: Stage 2 Objective 8 Measure 2 and Stage 3 Objective 6 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(2)'), 'EP Individual','Eligible Provider Individual: Secure Electronic Messaging','Required Test 9: Stage 2 Objective 9 and Stage 3 Objective 6 Measure 2', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(2)'), 'EC Individual (TIN/NPI)','Eligible Clinician Individual (TIN/NPI): Secure Electronic Messaging','Required Test 9: Stage 2 Objective 9 and Stage 3 Objective 6 Measure 2', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(2)'), 'EC Group','Eligible Clinician Group: Secure Electronic Messaging','Required Test 9: Stage 2 Objective 9 and Stage 3 Objective 6 Measure 2', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(2)'), 'EH/CAH','Eligible Hospital/Critical Access Hospital: Secure Electronic Messaging','Required Test 9: Stage 2 Objective 9 and Stage 3 Objective 6 Measure 2', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(3)'), 'EP Individual','Eligible Provider Individual: Patient-Generated Health Data','Required Test 6: Stage 3 Objective 6 Measure 3', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(3)'), 'EC Individual (TIN/NPI)','Eligible Clinician Individual (TIN/NPI): Patient-Generated Health Data','Required Test 6: Stage 3 Objective 6 Measure 3', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(3)'), 'EC Group','Eligible Clinician Group: Patient-Generated Health Data','Required Test 6: Stage 3 Objective 6 Measure 3', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(3)'), 'EH/CAH','Eligible Hospital/Critical Access Hospital: Patient-Generated Health Data','Required Test 6: Stage 3 Objective 6 Measure 3', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)'), 'RT2a EP Individual','RT2a Eligible Provider Individual: Patient Electronic Access','Required Test 2: Stage 2 Objective 8 Measure 1 and Stage 3 Objective 5 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)'), 'RT2a EC Individual (TIN/NPI)','RT2a Eligible Clinician Individual (TIN/NPI): Patient Electronic Access','Required Test 2: Stage 2 Objective 8 Measure 1 and Stage 3 Objective 5 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)'), 'RT2a EC Group','RT2a Eligible Clinician Group: Patient Electronic Access','Required Test 2: Stage 2 Objective 8 Measure 1 and Stage 3 Objective 5 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)'), 'RT2a EH/CAH','RT2a Eligible Hospital/Critical Access Hospital: Patient Electronic Access','Required Test 2: Stage 2 Objective 8 Measure 1 and Stage 3 Objective 5 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)'), 'RT2c EP Individual','RT2c Eligible Provider Individual: Patient Electronic Access','Required Test 2: Stage 2 Objective 8 Measure 1 and Stage 3 Objective 5 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)'), 'RT2c EC Individual (TIN/NPI)','RT2c Eligible Clinician Individual (TIN/NPI): Patient Electronic Access','Required Test 2: Stage 2 Objective 8 Measure 1 and Stage 3 Objective 5 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)'), 'RT2c EC Group','RT2c Eligible Clinician Group: Patient Electronic Access','Required Test 2: Stage 2 Objective 8 Measure 1 and Stage 3 Objective 5 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)'), 'RT2c EH/CAH','RT2c Eligible Hospital/Critical Access Hospital: Patient Electronic Access','Required Test 2: Stage 2 Objective 8 Measure 1 and Stage 3 Objective 5 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)'), 'RT4a EP Individual','RT4a Eligible Provider Individual: View, Download, or Transmit (VDT)','Required Test 4: Stage 2 Objective 8 Measure 2 and Stage 3 Objective 6 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)'), 'RT4a EC Individual (TIN/NPI)','RT4a Eligible Clinician Individual (TIN/NPI): View, Download, or Transmit (VDT)','Required Test 4: Stage 2 Objective 8 Measure 2 and Stage 3 Objective 6 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)'), 'RT4a EC Group','RT4a Eligible Clinician Group: View, Download, or Transmit (VDT)','Required Test 4: Stage 2 Objective 8 Measure 2 and Stage 3 Objective 6 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)'), 'RT4a EH/CAH','RT4a Eligible Hospital/Critical Access Hospital: View, Download, or Transmit (VDT)','Required Test 4: Stage 2 Objective 8 Measure 2 and Stage 3 Objective 6 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)'), 'RT4c EP Individual','RT4c Eligible Provider Individual: View, Download, or Transmit (VDT)','Required Test 4: Stage 2 Objective 8 Measure 2 and Stage 3 Objective 6 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)'), 'RT4c EC Individual (TIN/NPI)','RT4c Eligible Clinician Individual (TIN/NPI): View, Download, or Transmit (VDT)','Required Test 4: Stage 2 Objective 8 Measure 2 and Stage 3 Objective 6 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)'), 'RT4c EC Group','RT4c Eligible Clinician Group: View, Download, or Transmit (VDT)','Required Test 4: Stage 2 Objective 8 Measure 2 and Stage 3 Objective 6 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)'), 'RT4c EH/CAH','RT4c Eligible Hospital/Critical Access Hospital: View, Download, or Transmit (VDT)','Required Test 4: Stage 2 Objective 8 Measure 2 and Stage 3 Objective 6 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) 
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)'),'RT2a EP Individual','RT2a Eligible Provider Individual: Patient Electronic Access','Required Test 2: Stage 2 Objective 8 Measure 1 and Stage 3 Objective 5 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) 
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)'),'RT2a EC Individual (TIN/NPI)','RT2a Eligible Clinician Individual (TIN/NPI): Patient Electronic Access','Required Test 2: Stage 2 Objective 8 Measure 1 and Stage 3 Objective 5 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) 
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)'),'RT2a EC Group','RT2a Eligible Clinician Group: Patient Electronic Access','Required Test 2: Stage 2 Objective 8 Measure 1 and Stage 3 Objective 5 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) 
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)'),'RT2a EH/CAH','RT2a Eligible Hospital/Critical Access Hospital: Patient Electronic Access','Required Test 2: Stage 2 Objective 8 Measure 1 and Stage 3 Objective 5 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) 
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)'),'RT2c EP Individual','RT2c Eligible Provider Individual: Patient Electronic Access','Required Test 2: Stage 2 Objective 8 Measure 1 and Stage 3 Objective 5 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) 
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)'),'RT2c EC Individual (TIN/NPI)','RT2c Eligible Clinician Individual (TIN/NPI): Patient Electronic Access','Required Test 2: Stage 2 Objective 8 Measure 1 and Stage 3 Objective 5 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) 
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)'),'RT2c EC Group','RT2c Eligible Clinician Group: Patient Electronic Access','Required Test 2: Stage 2 Objective 8 Measure 1 and Stage 3 Objective 5 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) 
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)'),'RT2c EH/CAH','RT2c Eligible Hospital/Critical Access Hospital: Patient Electronic Access','Required Test 2: Stage 2 Objective 8 Measure 1 and Stage 3 Objective 5 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) 
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)'),'RT4a EP Individual','RT4a Eligible Provider Individual: View, Download, or Transmit (VDT)','Required Test 4: Stage 2 Objective 8 Measure 2 and Stage 3 Objective 6 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) 
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)'),'RT4a EC Individual (TIN/NPI)','RT4a Eligible Clinician Individual (TIN/NPI): View, Download, or Transmit (VDT)','Required Test 4: Stage 2 Objective 8 Measure 2 and Stage 3 Objective 6 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) 
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)'),'RT4a EC Group','RT4a Eligible Clinician Group: View, Download, or Transmit (VDT)','Required Test 4: Stage 2 Objective 8 Measure 2 and Stage 3 Objective 6 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) 
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)'),'RT4a EH/CAH','RT4a Eligible Hospital/Critical Access Hospital: View, Download, or Transmit (VDT)','Required Test 4: Stage 2 Objective 8 Measure 2 and Stage 3 Objective 6 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) 
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)'),'RT4c EP Individual','RT4c Eligible Provider Individual: View, Download, or Transmit (VDT)','Required Test 4: Stage 2 Objective 8 Measure 2 and Stage 3 Objective 6 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) 
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)'),'RT4c EC Individual (TIN/NPI)','RT4c Eligible Clinician Individual (TIN/NPI): View, Download, or Transmit (VDT)','Required Test 4: Stage 2 Objective 8 Measure 2 and Stage 3 Objective 6 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) 
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)'),'RT4c EC Group','RT4c Eligible Clinician Group: View, Download, or Transmit (VDT)','Required Test 4: Stage 2 Objective 8 Measure 2 and Stage 3 Objective 6 Measure 1', -1);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) 
values ((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)'),'RT4c EH/CAH','RT4c Eligible Hospital/Critical Access Hospital: View, Download, or Transmit (VDT)','Required Test 4: Stage 2 Objective 8 Measure 2 and Stage 3 Objective 6 Measure 1', -1);

-------------------------------------------------------------------------------------
-- OCD-1158 Add MUU accurate table
-------------------------------------------------------------------------------------
DROP TABLE IF EXISTS openchpl.muu_accurate_as_of_date;
CREATE TABLE openchpl.muu_accurate_as_of_date (
	muu_accurate_as_of_date_id bigserial NOT NULL,
	accurate_as_of_date timestamp without time zone NOT NULL,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_user bigint NOT NULL,
	deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT muu_accurate_as_of_date_pk PRIMARY KEY (muu_accurate_as_of_date_id)
)
WITH (
  OIDS=FALSE
);

GRANT ALL ON TABLE openchpl.muu_accurate_as_of_date TO openchpl;

CREATE TRIGGER muu_accurate_as_of_date_audit
  AFTER INSERT OR UPDATE OR DELETE
  ON openchpl.muu_accurate_as_of_date
  FOR EACH ROW
  EXECUTE PROCEDURE audit.if_modified_func();

CREATE TRIGGER muu_accurate_as_of_date_timestamp
  BEFORE UPDATE
  ON openchpl.muu_accurate_as_of_date
  FOR EACH ROW
  EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
  
  INSERT INTO openchpl.muu_accurate_as_of_date (accurate_as_of_date, last_modified_user) SELECT '11/30/2016', -1
  WHERE
    NOT EXISTS (
        SELECT muu_accurate_as_of_date_id FROM openchpl.muu_accurate_as_of_date
    );
