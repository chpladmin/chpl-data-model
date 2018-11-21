-- OCD-2532 - 2015 functionality tested should be restricted by criteria
-- 1) Create new table to support relationship between criteria and test functionality
-- 2) Add triggers to new table
-- 3) Rename old column
-- 4) Add new 2015 data to new table
-- 5) Add existing 2014 data to new table

--Drop thje new table if it exists
DROP TABLE IF EXISTS openchpl.test_functionality_criteria_map;

--Create the new table
CREATE TABLE openchpl.test_functionality_criteria_map
(
    id bigserial NOT NULL,
    criteria_id bigint NOT NULL,
    test_functionality_id bigint NOT NULL,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
    CONSTRAINT test_functionality_criteria_map_pk PRIMARY KEY (id),
    CONSTRAINT test_functionality_criteria_fk FOREIGN KEY (criteria_id)
        REFERENCES openchpl.certification_criterion (certification_criterion_id) MATCH FULL
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT test_functionality_fk FOREIGN KEY (test_functionality_id)
        REFERENCES openchpl.test_functionality (test_functionality_id) MATCH FULL
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

--Create the required triggers
CREATE TRIGGER test_functionality_criteria_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.test_functionality_criteria_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER test_functionality_criteria_map_timestamp BEFORE UPDATE on openchpl.test_functionality_criteria_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

-- Rename the column that will no longer be used
DO $$
BEGIN
  IF EXISTS(SELECT *
                FROM information_schema.columns
                WHERE table_catalog = 'openchpl'
                AND table_name = 'test_functionality'
                AND column_name = 'certification_criterion_id')
  THEN
      ALTER TABLE "openchpl"."test_functionality" RENAME COLUMN "certification_criterion_id" TO "certification_criterion_id_deleted";
  END IF;
END $$;

--Insert the 2015 data
INSERT INTO openchpl.test_functionality_criteria_map (criteria_id, test_functionality_id, last_modified_user)
VALUES (
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(1)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(2)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(2)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(3)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(3)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(4)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(4)(ii)(B)(1)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(4)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(4)(ii)(B)(2)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(5)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(5)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(6)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(6)(i)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(6)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(6)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(7)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(7)(i)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(7)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(7)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(8)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(8)(i)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(8)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(8)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(10)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(10)(i)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(10)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(10)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(13)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(13)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(14)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(14)(iii)(A)(1)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(14)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(14)(iii)(A)(2)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(1)(ii)(A)(5)(i)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(1)(ii)(A)(5)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(1)(iii)(E)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(1)(iii)(F)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(1)(iii)(G)(1)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(3)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(3)(iii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(4)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(4)(v)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(4)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(4)(vi)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(4)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(4)(vii)(A)(2)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(5)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(5)(i)(E)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(5)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(5)(i)(F)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(5)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(5)(ii)(A)(5)(i)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(5)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(5)(ii)(A)(5)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(6)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(6)(i)(B)(1)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(6)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(6)(i)(B)(2)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(6)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(6)(ii)(E)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(6)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(6)(ii)(F)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (c)(3)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(c)(3)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (d)(7)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(d)(7)(i)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (d)(7)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(d)(7)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (d)(9)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(d)(9)(i)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (d)(9)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(d)(9)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (e)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(e)(1)(i)(A)(2)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (e)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(e)(1)(i)(A)(3)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (e)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(e)(1)(i)(B)(2)(i)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (e)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(e)(1)(i)(B)(2)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (e)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(e)(1)(i)(B)(3)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (e)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(e)(1)(i)(C)(2)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(4)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(g)(4)(i)(A)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(4)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(g)(4)(i)(B)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(5)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(g)(5)(i)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(5)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(g)(5)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(5)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(g)(5)(iii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(13)(ii)(C)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(4)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(13)(ii)(C)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(5)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(13)(ii)(C)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(6)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(13)(ii)(C)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (e)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(13)(ii)(C)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (f)(5)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(13)(ii)(C)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(6)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(13)(ii)(C)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(8)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(13)(ii)(C)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(9)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(13)(ii)(C)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(19)(i)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(4)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(19)(i)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(5)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(19)(i)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(6)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(19)(i)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (e)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(19)(i)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (f)(5)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(19)(i)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(6)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(19)(i)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(8)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(19)(i)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(9)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(19)(i)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(19)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(4)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(19)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(5)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(19)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(6)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(19)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (e)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(19)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (f)(5)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(19)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(6)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(19)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(8)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(19)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(9)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(19)(ii)' AND  certification_edition_id = 3),
	-1
);

-- Convert the existing 2014 data
INSERT INTO openchpl.test_functionality_criteria_map (criteria_id, test_functionality_id, last_modified_user)
VALUES (
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (a)(6)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(6)(i)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (a)(7)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(7)(i)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (a)(14)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(14)(vi)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (b)(2)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(2)(i)(E)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (b)(7)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(7)(v)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (b)(8)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(8)(iii)(E)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (e)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(e)(1)(i)(A)(2)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (e)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(e)(1)(i)(B)(1)(i)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (f)(3)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(f)(3)(i)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (a)(5)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(5)(ii)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (a)(6)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(6)(ii)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (a)(7)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(7)(ii)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (b)(2)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(2)(i)(F)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (b)(7)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(7)(vi)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (b)(8)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(8)(iii)(F)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (e)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(e)(1)(i)(A)(3)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (e)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(e)(1)(i)(B)(2)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (e)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(e)(1)(i)(C)(2)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (f)(3)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(f)(3)(ii)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (a)(4)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(4)(iii)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (b)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(1)(i)(B)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (b)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(1)(i)(C)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (f)(3)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(f)(3)(i)(B)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (f)(7)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(f)(7)(i)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (a)(5)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(5)(i)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (a)(8)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(8)(iii)(B)(3)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (e)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(e)(1)(i)(B)(1)(ii)' AND  certification_edition_id = 2),
	-1
);
-- END OCD-2532
----------------------------------------------------

----------------------------------------------------
-- OCD-1665 Retire ACBs and ATLS
----------------------------------------------------
-- Update certification_body table
ALTER TABLE openchpl.certification_body DROP COLUMN IF EXISTS retired;
ALTER TABLE openchpl.certification_body ADD COLUMN retired boolean default false;

UPDATE openchpl.certification_body
SET retired = false
where name = 'InfoGard';

UPDATE openchpl.certification_body
SET retired = true
where name = 'CCHIT';

UPDATE openchpl.certification_body
SET retired = false
where name = 'Drummond Group';

UPDATE openchpl.certification_body
SET retired = false
where name = 'SLI Compliance';

UPDATE openchpl.certification_body
SET retired = true
where name = 'Surescripts LLC';

UPDATE openchpl.certification_body
SET retired = false
where name = 'ICSA Labs';

UPDATE openchpl.certification_body
SET retired = true
where name = 'Pending';

UPDATE openchpl.certification_body
SET deleted = false;

-- Update testing labs
ALTER TABLE openchpl.testing_lab DROP COLUMN IF EXISTS retired;
ALTER TABLE openchpl.testing_lab ADD COLUMN retired boolean default false;

UPDATE openchpl.testing_lab
SET retired = false
where name = 'InfoGard';

UPDATE openchpl.testing_lab
SET retired = true
where name = 'CCHIT';

UPDATE openchpl.testing_lab
SET retired = false
where name = 'Drummond Group';

UPDATE openchpl.testing_lab
SET retired = false
where name = 'SLI Compliance';

UPDATE openchpl.testing_lab
SET retired = false
where name = 'ICSA Labs';

UPDATE openchpl.testing_lab
SET retired = true
where name = 'National Technical Systems';

UPDATE openchpl.testing_lab
SET retired = false
where name = 'National Committee for Quality Assurance (NCQA)';

UPDATE openchpl.testing_lab
SET deleted = false;
----------------------------------------------------
-- END OCD-1665 Retire ACBs and ATLS
----------------------------------------------------

-- OCD-2560 - Add Reason to Questionable Activity when changing Developer status
-- Add column reason to questionable_activity_developer table
DO $$
BEGIN
  IF NOT EXISTS(SELECT *
                FROM information_schema.columns
                WHERE table_catalog = 'openchpl'
                AND table_name = 'questionable_activity_developer'
                AND column_name = 'reason')
  THEN
      ALTER TABLE openchpl.questionable_activity_developer ADD COLUMN reason TEXT DEFAULT null;
  END IF;
END $$;

--re-run grants
\i dev/openchpl_grant-all.sql