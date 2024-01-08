-- Deployment file for version 24.5.0
--     as of 2024-01-08
-- ./changes/ocd-4377.sql
ALTER TABLE openchpl.ehr_certification_id ADD COLUMN IF NOT EXISTS deleted BOOL NOT NULL DEFAULT false;

CREATE OR REPLACE FUNCTION "openchpl".column_exists (ptable text, pcolumn text, pschema text DEFAULT 'public')
    RETURNS boolean
    LANGUAGE sql
    STABLE STRICT
    AS $BODY$
    -- does the requested table.column exist in schema?
    SELECT
        EXISTS (
            SELECT
                NULL
            FROM
                information_schema.columns
            WHERE
                table_name = ptable
                AND column_name = pcolumn
                AND table_schema = pschema);
$BODY$;


CREATE OR REPLACE FUNCTION openchpl.last_modified_user_constraint() RETURNS trigger LANGUAGE plpgsql
AS $function$
BEGIN
	IF NEW.last_modified_user IS NULL AND NEW.last_modified_sso_user IS NULL THEN
		RAISE EXCEPTION 'Column last_modified_user or last_modified_sso_user requires a value.';
	ELSIF  NEW.last_modified_user IS NOT NULL AND NEW.last_modified_sso_user IS NOT NULL THEN
		RAISE EXCEPTION 'Only one of the columns [last_modified_user , last_modified_sso_user] can have a value.';
	END IF;
	RETURN NEW;
END;
$function$;


DO $$
DECLARE
    row record;
    cmd text;
    table_name text;
BEGIN
	FOR row IN SELECT schemaname, tablename FROM pg_tables WHERE schemaname = 'openchpl' ORDER BY tablename LOOP
		IF openchpl.column_exists(row.tablename, 'last_modified_user', row.schemaname) THEN
	        	cmd := format('ALTER TABLE %I.%I ADD COLUMN IF NOT EXISTS last_modified_sso_user uuid;', row.schemaname, row.tablename);
		        --RAISE NOTICE '%', cmd;
		        EXECUTE cmd;

			cmd :=  format('ALTER TABLE %I.%I ALTER COLUMN last_modified_user DROP NOT NULL;', row.schemaname, row.tablename);
			--RAISE NOTICE '%', cmd;
			EXECUTE cmd;

			cmd := format('DROP TRIGGER IF EXISTS %s_last_modified_user_constraint on %I.%I;', row.tablename, row.schemaname, row.tablename);
			--RAISE NOTICE '%', cmd;
			EXECUTE cmd;

			cmd := format('CREATE CONSTRAINT TRIGGER %s_last_modified_user_constraint AFTER INSERT OR UPDATE ON %I.%I DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();', row.tablename, row.schemaname, row.tablename);
			--RAISE NOTICE '%', cmd;
        		EXECUTE cmd;
		ELSE
			RAISE NOTICE '%s does not have a last_modified_user column', row.tablename;
		END IF;

		IF not openchpl.column_exists(row.tablename, 'deleted', row.schemaname) THEN
			RAISE NOTICE '%s does not have a deleted', row.tablename;
		END IF;
    	END LOOP;
END
$$ LANGUAGE plpgsql;


DROP FUNCTION openchpl.column_exists;
;
-- ./changes/ocd-4383.sql
insert into openchpl.certification_result (certified_product_id, certification_criterion_id, success, g1_success, g2_success, last_modified_user)
select cp.certified_product_id, crit.certification_criterion_id, false, false, false, -1
from openchpl.certified_product cp,
	(select cc.certification_criterion_id
	from openchpl.certification_criterion cc
		inner join openchpl.certification_criterion_attribute cca
			on cc.certification_criterion_id = cca.criterion_id
	where cc.certification_edition_id = 2
	and (cca.g1_success or cca.g2_success)) crit
where certification_edition_id = 2
and cp.deleted = false
and not exists (
	select certification_result_id
	from openchpl.certification_result cr
	where cr.certification_criterion_id = crit.certification_criterion_id
	and cr.certified_product_id = cp.certified_product_id
	and cr.deleted = false
);
;
-- ./changes/ocd-4417.sql
-------------------------------
-- Add all the companion guide URLs
-------------------------------

ALTER TABLE openchpl.certification_criterion
ADD COLUMN IF NOT EXISTS certification_companion_guide_link text;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/computerized-provider-order-entry-cpoe-medications'
WHERE certification_criterion_id = 1;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/computerized-provider-order-entry-cpoe-laboratory'
WHERE certification_criterion_id = 2;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/computerized-provider-order-entry-cpoe-diagnostic-imaging'
WHERE certification_criterion_id = 3;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/drug-drug-drug-allergy-interaction-checks-cpoe'
WHERE certification_criterion_id = 4;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/demographics'
WHERE certification_criterion_id = 5;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/clinical-decision-support-cds'
WHERE certification_criterion_id = 9;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/family-health-history'
WHERE certification_criterion_id = 12;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/implantable-device-list'
WHERE certification_criterion_id = 14;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/social-psychological-and-behavioral-data'
WHERE certification_criterion_id = 15;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/transitions-care'
WHERE certification_criterion_id = 165;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/clinical-information-reconciliation-and-incorporation'
WHERE certification_criterion_id = 166;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/electronic-prescribing'
WHERE certification_criterion_id = 167;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/security-tags-summary-care-send'
WHERE certification_criterion_id = 168;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/security-tags-summary-care-receive'
WHERE certification_criterion_id = 169;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/care-plan'
WHERE certification_criterion_id = 170;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/electronic-health-information-export'
WHERE certification_criterion_id = 171;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/clinical-quality-measures-cqms-record-and-export'
WHERE certification_criterion_id = 25;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/clinical-quality-measures-cqms-import-and-calculate'
WHERE certification_criterion_id = 26;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/clinical-quality-measures-cqms-report'
WHERE certification_criterion_id = 172;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/clinical-quality-measures-cqms-filter'
WHERE certification_criterion_id = 28;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/authentication-access-control-authorization'
WHERE certification_criterion_id = 29;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/auditable-events-and-tamper-resistance'
WHERE certification_criterion_id = 173;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/audit-reports'
WHERE certification_criterion_id = 174;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/amendments'
WHERE certification_criterion_id = 32;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/automatic-access-time-out'
WHERE certification_criterion_id = 33;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/emergency-access'
WHERE certification_criterion_id = 34;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/end-user-device-encryption'
WHERE certification_criterion_id = 35;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/integrity'
WHERE certification_criterion_id = 36;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/trusted-connection'
WHERE certification_criterion_id = 37;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/auditing-actions-health-information'
WHERE certification_criterion_id = 175;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/accounting-disclosures'
WHERE certification_criterion_id = 39;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/encrypt-authentication-credentials'
WHERE certification_criterion_id = 176;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/multi-factor-authentication'
WHERE certification_criterion_id = 177;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/view-download-and-transmit-3rd-party-0'
WHERE certification_criterion_id = 178;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/patient-health-information-capture'
WHERE certification_criterion_id = 42;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/transmission-immunization-registries'
WHERE certification_criterion_id = 43;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/transmission-public-health-agencies-syndromic-surveillance'
WHERE certification_criterion_id = 44;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/transmission-public-health-agencies-reportable-laboratory-tests-and-valueresults'
WHERE certification_criterion_id = 45;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/transmission-cancer-registries'
WHERE certification_criterion_id = 46;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/transmission-public-health-agencies-electronic-case-reporting'
WHERE certification_criterion_id = 179;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/transmission-public-health-agencies-antimicrobial-use-and-resistance-reporting'
WHERE certification_criterion_id = 48;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/transmission-public-health-agencies-health-care-surveys'
WHERE certification_criterion_id = 49;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/automated-numerator-recording'
WHERE certification_criterion_id = 50;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/automated-measure-calculation'
WHERE certification_criterion_id = 51;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/safety-enhanced-design'
WHERE certification_criterion_id = 52;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/quality-management-system'
WHERE certification_criterion_id = 53;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/accessibility-centered-design'
WHERE certification_criterion_id = 54;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/consolidated-cda-creation-performance'
WHERE certification_criterion_id = 180;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/application-access-patient-selection'
WHERE certification_criterion_id = 56;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/application-access-all-data-request'
WHERE certification_criterion_id = 181;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/standardized-api-patient-and-population-services'
WHERE certification_criterion_id = 182;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/direct-project'
WHERE certification_criterion_id = 59;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/direct-project-edge-protocol-and-xdrxdm'
WHERE certification_criterion_id = 60;

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/decision-support-interventions'
WHERE certification_criterion_id = 210;

-------------------------------
-- Set up data for these URLs to be in the Questionable URL report
-------------------------------
INSERT INTO openchpl.url_type (name, last_modified_user)
SELECT 'Certification Criterion', -1
WHERE NOT EXISTS (
	SELECT id from openchpl.url_type where name = 'Certification Criterion'
);;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('24.5.0', '2024-01-08', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
