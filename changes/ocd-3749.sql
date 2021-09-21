alter table openchpl.certification_criterion_attribute drop column if exists conformance_method;
ALTER TABLE openchpl.certification_criterion_attribute ADD COLUMN IF NOT EXISTS conformance_method BOOL NOT NULL DEFAULT FALSE;
alter table openchpl.certification_criterion_attribute drop column if exists test_procedure;
ALTER TABLE openchpl.certification_criterion_attribute ADD COLUMN IF NOT EXISTS test_procedure BOOL NOT NULL DEFAULT FALSE;

-- make sure all 2014 and 2015 criteria have entries in the attribute table
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 1, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 1);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 2, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 2);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 3, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 3);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 4, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 4);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 5, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 5);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 6, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 6);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 7, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 7);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 8, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 8);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 9, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 9);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 10, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 10);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 11, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 11);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 12, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 12);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 13, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 13);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 14, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 14);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 15, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 15);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 16, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 16);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 17, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 17);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 18, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 18);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 19, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 19);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 20, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 20);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 21, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 21);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 22, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 22);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 23, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 23);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 24, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 24);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 25, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 25);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 26, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 26);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 27, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 27);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 28, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 28);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 29, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 29);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 30, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 30);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 31, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 31);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 32, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 32);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 33, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 33);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 34, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 34);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 35, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 35);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 36, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 36);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 37, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 37);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 38, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 38);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 39, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 39);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 40, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 40);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 41, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 41);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 42, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 42);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 43, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 43);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 44, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 44);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 45, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 45);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 46, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 46);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 47, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 47);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 48, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 48);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 49, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 49);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 50, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 50);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 51, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 51);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 52, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 52);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 53, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 53);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 54, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 54);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 55, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 55);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 56, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 56);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 57, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 57);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 58, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 58);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 59, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 59);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 60, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 60);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 165, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 165);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 166, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 166);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 167, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 167);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 168, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 168);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 169, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 169);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 170, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 170);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 171, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 171);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 172, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 172);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 173, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 173);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 174, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 174);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 175, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 175);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 176, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 176);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 177, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 177);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 178, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 178);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 179, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 179);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 180, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 180);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 181, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 181);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 182, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 182);

update openchpl.certification_criterion_attribute set test_procedure = true where criterion_id >= 61 and criterion_id <= 119; -- all 2014 Criteria can have TP

-- allow specific 2015 criteria to have conformance_method (assumes removed criteria have none)
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(1)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(2)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(3)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(4)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(5)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(9)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(10)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(12)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(13)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(14)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (a)(15)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(10)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(1)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(2)' and title like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(2)' and title not like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(3)' and title like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(3)' and title not like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(4)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(5)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(6)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(7)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(8)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(9)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(10)' and title like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(10)' and title not like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(11)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(12)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (d)(13)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(1)' and title like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(1)' and title not like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(2)' and title like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(2)' and title not like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(3)' and title like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(3)' and title not like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(6)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(7)' and title like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(7)' and title not like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(8)' and title like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(8)' and title not like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(9)' and title like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (b)(9)' and title not like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (c)(1)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (c)(2)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (c)(3)' and title like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (c)(3)' and title not like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (c)(4)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (e)(1)' and title like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (e)(1)' and title not like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (e)(2)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (e)(3)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (f)(1)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (f)(2)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (f)(3)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (f)(4)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (f)(5)' and title like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (f)(5)' and title not like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (f)(6)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (f)(7)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(1)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(2)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(3)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(4)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(5)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(6)' and title like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(6)' and title not like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(7)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(8)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(9)' and title like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(9)' and title not like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (g)(10)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (h)(1)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (h)(2)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (c)(2)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (c)(3)' and title not like '%(Cures Update)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (c)(4)');
update openchpl.certification_criterion_attribute set conformance_method = true where criterion_id = (select cc.certification_criterion_id from openchpl.certification_criterion cc where cc.number = '170.315 (f)(1)');

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
