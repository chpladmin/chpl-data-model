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
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/data-export'
WHERE certification_criterion_id = 21;

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


-------------------------------
-- Set up data for these URLs to be in the Questionable URL report
-------------------------------
INSERT INTO openchpl.url_type (name, last_modified_user)
SELECT 'Certification Criterion', -1
WHERE NOT EXISTS (
	SELECT id from openchpl.url_type where name = 'Certification Criterion'
);