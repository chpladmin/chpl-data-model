
INSERT INTO openchpl.standard (rule_id,value,regulatory_text_citation,additional_information,start_day,end_day,required_day,last_modified_user,deleted,last_modified_sso_user,group_name)
SELECT NULL,'G4 Standard 1','1.1','','2016-01-01',NULL,'2016-01-01',-1,false,NULL,''
where not exists (select * from openchpl.standard where value = 'G4 Standard 1');

INSERT INTO openchpl.standard (rule_id,value,regulatory_text_citation,additional_information,start_day,end_day,required_day,last_modified_user,deleted,last_modified_sso_user,group_name)
SELECT NULL,'G4 Standard 2','2.2','','2016-01-01',NULL,'2016-01-01',-1,false,NULL,''
where not exists (select * from openchpl.standard where value = 'G4 Standard 2');

INSERT INTO openchpl.standard (rule_id,value,regulatory_text_citation,additional_information,start_day,end_day,required_day,last_modified_user,deleted,last_modified_sso_user,group_name)
SELECT NULL,'G4 Standard 3','3.3','','2016-01-01','2020-01-01','2016-01-01',-1,false,NULL,''
where not exists (select * from openchpl.standard where value = 'G4 Standard 3');

INSERT INTO openchpl.standard (rule_id,value,regulatory_text_citation,additional_information,start_day,end_day,required_day,last_modified_user,deleted,last_modified_sso_user,group_name)
SELECT NULL,'G4 Standard 4','4.4','','2016-01-01','0025-02-02','2016-01-01',-1,false,NULL,''
where not exists (select * from openchpl.standard where value = 'G4 Standard 4');

INSERT INTO openchpl.standard (rule_id,value,regulatory_text_citation,additional_information,start_day,end_day,required_day,last_modified_user,deleted,last_modified_sso_user,group_name)
SELECT NULL,'G4 Standard 5','5.5','','2024-01-01',NULL,'2024-01-01',-1,false,NULL,''
where not exists (select * from openchpl.standard where value = 'G4 Standard 5');

INSERT INTO openchpl.standard (rule_id,value,regulatory_text_citation,additional_information,start_day,end_day,required_day,last_modified_user,deleted,last_modified_sso_user,group_name)
SELECT NULL,'G4 Standard 6','6.6','','2016-01-01',NULL,'2016-01-01',-1,false,NULL,'Test Group'
where not exists (select * from openchpl.standard where value = 'G4 Standard 6');

INSERT INTO openchpl.standard (rule_id,value,regulatory_text_citation,additional_information,start_day,end_day,required_day,last_modified_user,deleted,last_modified_sso_user,group_name)
SELECT NULL,'G4 Standard 7','7.7','','2016-01-01',NULL,'2016-01-01',-1,false,NULL,'Test Group'
where not exists (select * from openchpl.standard where value = 'G4 Standard 7');

INSERT INTO openchpl.standard (rule_id,value,regulatory_text_citation,additional_information,start_day,end_day,required_day,last_modified_user,deleted,last_modified_sso_user,group_name)
SELECT NULL,'G4 Standard 8','8.8','','2016-01-01',NULL,'2024-02-11',-1,false,NULL,''
where not exists (select * from openchpl.standard where value = 'G4 Standard 8');

INSERT INTO openchpl.standard (rule_id,value,regulatory_text_citation,additional_information,start_day,end_day,required_day,last_modified_user,deleted,last_modified_sso_user,group_name)
SELECT NULL,'G4 Standard 9','9.9','','2016-01-01','2020-01-01','2016-01-01',-1,false,NULL,'Test Group 2'
where not exists (select * from openchpl.standard where value = 'G4 Standard 9');

INSERT INTO openchpl.standard (rule_id,value,regulatory_text_citation,additional_information,start_day,end_day,required_day,last_modified_user,deleted,last_modified_sso_user,group_name)
SELECT NULL,'G4 Standard 10','10.10','','2016-01-01','2025-01-01','2016-01-01',-1,false,NULL,'Test Group 2'
where not exists (select * from openchpl.standard where value = 'G4 Standard 10');

INSERT INTO openchpl.standard (rule_id,value,regulatory_text_citation,additional_information,start_day,end_day,required_day,last_modified_user,deleted,last_modified_sso_user,group_name)
SELECT NULL,'G4 Standard 11','11.11','','2024-01-01',null,'2025-01-01',-1,false,NULL,'Test Group 2'
where not exists (select * from openchpl.standard where value = 'G4 Standard 11');


insert into openchpl.standard_criteria_map (standard_id, certification_criterion_id, last_modified_user)
select (select id from openchpl.standard s where value = 'G4 Standard 1'), 53, -1
where not exists
	(select *
	from openchpl.standard_criteria_map
	where standard_id = (select id from openchpl.standard where value = 'G4 Standard 1')
	and certification_criterion_id = 53);

insert into openchpl.standard_criteria_map (standard_id, certification_criterion_id, last_modified_user)
select (select id from openchpl.standard s where value = 'G4 Standard 2'), 53, -1
where not exists
	(select *
	from openchpl.standard_criteria_map
	where standard_id = (select id from openchpl.standard where value = 'G4 Standard 2')
	and certification_criterion_id = 53);

insert into openchpl.standard_criteria_map (standard_id, certification_criterion_id, last_modified_user)
select (select id from openchpl.standard s where value = 'G4 Standard 3'), 53, -1
where not exists
	(select *
	from openchpl.standard_criteria_map
	where standard_id = (select id from openchpl.standard where value = 'G4 Standard 3')
	and certification_criterion_id = 53);

insert into openchpl.standard_criteria_map (standard_id, certification_criterion_id, last_modified_user)
select (select id from openchpl.standard s where value = 'G4 Standard 4'), 53, -1
where not exists
	(select *
	from openchpl.standard_criteria_map
	where standard_id = (select id from openchpl.standard where value = 'G4 Standard 4')
	and certification_criterion_id = 53);

insert into openchpl.standard_criteria_map (standard_id, certification_criterion_id, last_modified_user)
select (select id from openchpl.standard s where value = 'G4 Standard 5'), 53, -1
where not exists
	(select *
	from openchpl.standard_criteria_map
	where standard_id = (select id from openchpl.standard where value = 'G4 Standard 5')
	and certification_criterion_id = 53);

insert into openchpl.standard_criteria_map (standard_id, certification_criterion_id, last_modified_user)
select (select id from openchpl.standard s where value = 'G4 Standard 6'), 53, -1
where not exists
	(select *
	from openchpl.standard_criteria_map
	where standard_id = (select id from openchpl.standard where value = 'G4 Standard 6')
	and certification_criterion_id = 53);

insert into openchpl.standard_criteria_map (standard_id, certification_criterion_id, last_modified_user)
select (select id from openchpl.standard s where value = 'G4 Standard 7'), 53, -1
where not exists
	(select *
	from openchpl.standard_criteria_map
	where standard_id = (select id from openchpl.standard where value = 'G4 Standard 7')
	and certification_criterion_id = 53);

insert into openchpl.standard_criteria_map (standard_id, certification_criterion_id, last_modified_user)
select (select id from openchpl.standard s where value = 'G4 Standard 8'), 53, -1
where not exists
	(select *
	from openchpl.standard_criteria_map
	where standard_id = (select id from openchpl.standard where value = 'G4 Standard 8')
	and certification_criterion_id = 53);

insert into openchpl.standard_criteria_map (standard_id, certification_criterion_id, last_modified_user)
select (select id from openchpl.standard s where value = 'G4 Standard 9'), 53, -1
where not exists
	(select *
	from openchpl.standard_criteria_map
	where standard_id = (select id from openchpl.standard where value = 'G4 Standard 9')
	and certification_criterion_id = 53);

insert into openchpl.standard_criteria_map (standard_id, certification_criterion_id, last_modified_user)
select (select id from openchpl.standard s where value = 'G4 Standard 10'), 53, -1
where not exists
	(select *
	from openchpl.standard_criteria_map
	where standard_id = (select id from openchpl.standard where value = 'G4 Standard 10')
	and certification_criterion_id = 53);

insert into openchpl.standard_criteria_map (standard_id, certification_criterion_id, last_modified_user)
select (select id from openchpl.standard s where value = 'G4 Standard 11'), 53, -1
where not exists
	(select *
	from openchpl.standard_criteria_map
	where standard_id = (select id from openchpl.standard where value = 'G4 Standard 11')
	and certification_criterion_id = 53);
