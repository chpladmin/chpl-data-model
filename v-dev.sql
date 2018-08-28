-- OCD-2392 - add whitelisting to api keys

ALTER TABLE openchpl.api_key DROP COLUMN IF EXISTS whitelisted;
ALTER TABLE openchpl.api_key ADD COLUMN whitelisted boolean DEFAULT false;
UPDATE openchpl.api_key SET whitelisted = true WHERE api_key_id = 1;

-- OCD-2414 - Update UI display values for a few G1G2 Macra Measures and Add a couple additional input values
insert into openchpl.macra_criteria_map
(criteria_id, "value", "name", description, last_modified_user)
values
(
	(select certification_criterion_id from openchpl.certification_criterion where "number" = '170.315 (a)(10)'),
	'RT13 EH/CAH Stage 3',
	'Query of Prescription Drug Monitoring Program (PDMP): Eligible Hospital/Critical Access Hospital',
	'Required Test 13: Stage 3',
	-1
);

insert into openchpl.macra_criteria_map
(criteria_id, "value", "name", description, last_modified_user)
values
(
	(select certification_criterion_id from openchpl.certification_criterion where "number" = '170.315 (a)(10)'),
	'RT14 EH/CAH Stage 3',
	'Verify Opioid Treatment Agreement: Eligible Hospital/Critical Access Hospital',
	'Required Test 14: Stage 3',
	-1
);

insert into openchpl.macra_criteria_map
(criteria_id, "value", "name", description, last_modified_user)
values
(
	(select certification_criterion_id from openchpl.certification_criterion where "number" = '170.315 (b)(1)'),
	'RT15 EH/CAH Stage 3',
	'Support Electronic Referral Loops by Receiving and Incorporating Health Information: Eligible Hospital/Critical Access Hospital',
	'Required Test 15: Stage 3',
	-1
);

insert into openchpl.macra_criteria_map
(criteria_id, "value", "name", description, last_modified_user)
values
(
	(select certification_criterion_id from openchpl.certification_criterion where "number" = '170.315 (b)(2)'),
	'RT15 EH/CAH Stage 3',
	'Support Electronic Referral Loops by Receiving and Incorporating Health Information: Eligible Hospital/Critical Access Hospital',
	'Required Test 15: Stage 3',
	-1
);

insert into openchpl.macra_criteria_map
(criteria_id, "value", "name", description, last_modified_user)
values
(
	(select certification_criterion_id from openchpl.certification_criterion where "number" = '170.315 (b)(3)'),
	'RT13 EH/CAH Stage 3',
	'Query of Prescription Drug Monitoring Program (PDMP): Eligible Hospital/Critical Access Hospital',
	'Required Test 13: Stage 3',
	-1
);

insert into openchpl.macra_criteria_map
(criteria_id, "value", "name", description, last_modified_user)
values
(
	(select certification_criterion_id from openchpl.certification_criterion where "number" = '170.315 (b)(3)'),
	'RT14 EH/CAH Stage 3',
	'Verify Opioid Treatment Agreement: Eligible Hospital/Critical Access Hospital',
	'Required Test 14: Stage 3',
	-1
);

update openchpl.macra_criteria_map
set "name" = 'Support Electronic Referral Loops by Sending Health Information (formerly Patient Care Record Exchange):  Eligible Hospital/Critical Access Hospital'
where "id" = (select mcm."id"
			from openchpl.macra_criteria_map mcm
				inner join openchpl.certification_criterion cc
					on mcm.criteria_id = cc.certification_criterion_id
			where mcm."value" = 'RT7 EH/CAH Stage 3'
			and cc.number = '170.315 (b)(1)');
			
update openchpl.macra_criteria_map
set "name" = 'Patient Electronic Access: Eligible Clinician'
where "id" = (select mcm."id"
			from openchpl.macra_criteria_map mcm
				inner join openchpl.certification_criterion cc
					on mcm.criteria_id = cc.certification_criterion_id
			where mcm."value" = 'RT2a EC ACI Transition'
			and cc.number = '170.315 (e)(1)');

update openchpl.macra_criteria_map
set "name" = 'Provider to Patient Exchange (formerly Patient Electronic Access):  Eligible Hospital/Critical Access Hospital'
where "id" = (select mcm."id"
			from openchpl.macra_criteria_map mcm
				inner join openchpl.certification_criterion cc
					on mcm.criteria_id = cc.certification_criterion_id
			where mcm."value" = 'RT2a EH/CAH Stage 3'
			and cc.number = '170.315 (e)(1)');

update openchpl.macra_criteria_map
set "name" = 'Patient-Generated Health Data: Eligible Provider'
where "id" = (select mcm."id"
			from openchpl.macra_criteria_map mcm
				inner join openchpl.certification_criterion cc
					on mcm.criteria_id = cc.certification_criterion_id
			where mcm."value" = 'EP Stage 3'
			and cc.number = '170.315 (e)(3)');

update openchpl.macra_criteria_map
set "name" = 'Patient-Generated Health Data: Eligible Clinician'
where "id" = (select mcm."id"
			from openchpl.macra_criteria_map mcm
				inner join openchpl.certification_criterion cc
					on mcm.criteria_id = cc.certification_criterion_id
			where mcm."value" = 'EC ACI'
			and cc.number = '170.315 (e)(3)');

update openchpl.macra_criteria_map
set "name" = 'Provider to Patient Exchange (formerly Patient Electronic Access):  Eligible Hospital/Critical Access Hospital'
where "id" = (select mcm."id"
			from openchpl.macra_criteria_map mcm
				inner join openchpl.certification_criterion cc
					on mcm.criteria_id = cc.certification_criterion_id
			where mcm."value" = 'RT2a EH/CAH Stage 3'
			and cc.number = '170.315 (g)(8)');

update openchpl.macra_criteria_map
set "name" = 'Provider to Patient Exchange (formerly Patient Electronic Access):  Eligible Hospital/Critical Access Hospital'
where "id" = (select mcm."id"
			from openchpl.macra_criteria_map mcm
				inner join openchpl.certification_criterion cc
					on mcm.criteria_id = cc.certification_criterion_id
			where mcm."value" = 'RT2c EH/CAH Stage 3'
			and cc.number = '170.315 (g)(8)');
			
update openchpl.macra_criteria_map
set "name" = 'View, Download, or Transmit (VDT):  Eligible Clinician'
where "id" = (select mcm."id"
			from openchpl.macra_criteria_map mcm
				inner join openchpl.certification_criterion cc
					on mcm.criteria_id = cc.certification_criterion_id
			where mcm."value" = 'RT4a EC ACI'
			and cc.number = '170.315 (g)(8)');

update openchpl.macra_criteria_map
set "name" = 'View, Download, or Transmit (VDT):  Eligible Clinician'
where "id" = (select mcm."id"
			from openchpl.macra_criteria_map mcm
				inner join openchpl.certification_criterion cc
					on mcm.criteria_id = cc.certification_criterion_id
			where mcm."value" = 'RT4a EC ACI Transition'
			and cc.number = '170.315 (g)(8)');

update openchpl.macra_criteria_map
set "name" = 'View, Download, or Transmit (VDT):  Eligible Provider'
where "id" = (select mcm."id"
			from openchpl.macra_criteria_map mcm
				inner join openchpl.certification_criterion cc
					on mcm.criteria_id = cc.certification_criterion_id
			where mcm."value" = 'RT4c EP Stage 2'
			and cc.number = '170.315 (g)(8)');

update openchpl.macra_criteria_map
set "name" = 'View, Download, or Transmit (VDT):  Eligible Provider'
where "id" = (select mcm."id"
			from openchpl.macra_criteria_map mcm
				inner join openchpl.certification_criterion cc
					on mcm.criteria_id = cc.certification_criterion_id
			where mcm."value" = 'RT4c EP Stage 3'
			and cc.number = '170.315 (g)(8)');

update openchpl.macra_criteria_map
set "name" = 'View, Download, or Transmit (VDT):  Eligible Provider'
where "id" = (select mcm."id"
			from openchpl.macra_criteria_map mcm
				inner join openchpl.certification_criterion cc
					on mcm.criteria_id = cc.certification_criterion_id
			where mcm."value" = 'RT4c EC ACI'
			and cc.number = '170.315 (g)(8)');

update openchpl.macra_criteria_map
set "name" = 'View, Download, or Transmit (VDT):  Eligible Provider'
where "id" = (select mcm."id"
			from openchpl.macra_criteria_map mcm
				inner join openchpl.certification_criterion cc
					on mcm.criteria_id = cc.certification_criterion_id
			where mcm."value" = 'RT4c EC ACI Transition'
			and cc.number = '170.315 (g)(8)');

update openchpl.macra_criteria_map
set "name" = 'Provider to Patient Exchange (formerly Patient Electronic Access):  Eligible Hospital/Critical Access Hospital'
where "id" = (select mcm."id"
			from openchpl.macra_criteria_map mcm
				inner join openchpl.certification_criterion cc
					on mcm.criteria_id = cc.certification_criterion_id
			where mcm."value" = 'RT2a EH/CAH Stage 3'
			and cc.number = '170.315 (g)(9)');

update openchpl.macra_criteria_map
set "name" = 'Provider to Patient Exchange (formerly Patient Electronic Access):  Eligible Hospital/Critical Access Hospital'
where "id" = (select mcm."id"
			from openchpl.macra_criteria_map mcm
				inner join openchpl.certification_criterion cc
					on mcm.criteria_id = cc.certification_criterion_id
			where mcm."value" = 'RT2c EH/CAH Stage 3'
			and cc.number = '170.315 (g)(9)');










