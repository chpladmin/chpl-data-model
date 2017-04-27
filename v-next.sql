------------------------------------------------------------
-- OCD-1433 - Find any current products that have bad values
------------------------------------------------------------
DO $$
BEGIN
raise notice 'Updating openchpl.certification_result and openchpl.pending_certification_result to remove whitespace from privacy_security_framework';
END; 
$$;

-- remove leading and trailing whitespace from privacy_security_framework
BEGIN;
UPDATE openchpl.certification_result
SET privacy_security_framework = TRIM(both ' ' from privacy_security_framework);
END;

BEGIN;
UPDATE openchpl.pending_certification_result 
SET privacy_security_framework = TRIM(both ' ' from privacy_security_framework);
END;

-- update comma to semicolon
BEGIN;
UPDATE openchpl.certification_result
SET privacy_security_framework = REPLACE(privacy_security_framework, ',', ';');
END;

BEGIN;
UPDATE openchpl.pending_certification_result
SET privacy_security_framework = REPLACE(privacy_security_framework, ',', ';');
END;

-- remove space after semicolon
BEGIN;
UPDATE openchpl.certification_result
SET privacy_security_framework = REPLACE(privacy_security_framework, '; ', ';');
END;

BEGIN;
UPDATE openchpl.pending_certification_result
SET privacy_security_framework = REPLACE(privacy_security_framework, '; ', ';');
END;

---------------------- certified products with bad data

DO $$
BEGIN
raise notice 'The following certified_product_id have bad values not in the set of Approach 1, Approach 2, or Approach 1;Approach 2';
END; 
$$;

SELECT cr.certified_product_id, cc.number, cr.privacy_security_framework
FROM openchpl.certification_result cr
LEFT JOIN openchpl.certification_criterion cc ON cr.certification_criterion_id = cc.certification_criterion_id
WHERE cr.privacy_security_framework IS NOT NULL
AND cr.privacy_security_framework <> ''
AND REPLACE(cr.privacy_security_framework, ' ', '') NOT IN ('Approach1', 'Approach2', 'Approach1;Approach2', 'Approach1,Approach2');

---------------------- pending products with bad data
DO $$
BEGIN
raise notice 'The following pending_certified_product_id have bad values not in the set of Approach 1, Approach 2, or Approach 1;Approach 2';
END; 
$$;

SELECT pr.pending_certified_product_id, cc.number, pr.privacy_security_framework
FROM openchpl.pending_certification_result pr
LEFT JOIN openchpl.certification_criterion cc ON pr.certification_criterion_id = cc.certification_criterion_id
WHERE pr.privacy_security_framework IS NOT NULL 
AND pr.privacy_security_framework <> ''
AND REPLACE(pr.privacy_security_framework, ' ', '') NOT IN ('Approach1', 'Approach2', 'Approach1;Approach2', 'Approach1,Approach2');

------------------------------------------------------------
-- OCD-1443 - Update values for CQMs with typos
------------------------------------------------------------
BEGIN;
UPDATE openchpl.cqm_criterion
SET title = 'ADHD: Follow-Up Care for Children Prescribed Attention-Deficit/Hyperactivity Disorder (ADHD) Medication'
WHERE title = 'ADHD: Follow-Up Care for Children Prescribed AttentionDeficit/Hyperactivi ty Disorder (ADHD) Medication';
END; 

BEGIN;
UPDATE openchpl.cqm_criterion
SET title = 'Functional Status Assessment for Total Hip Replacement'
WHERE title = 'Functional Status Assessment for Hip Replacemen';
END;

BEGIN;
UPDATE openchpl.cqm_criterion
SET title = 'Heart Failure (HF): Beta-Blocker Therapy for Left Ventricular Systolic Dysfunction (LVSD)'
WHERE title = 'Heart Failure (HF): BetaBlocker Therapy for Left Ventricular Systolic Dysfunction (LVSD)';
END;

BEGIN;
UPDATE openchpl.cqm_criterion
SET title = 'Heart Failure (HF): Angiotensin-Converting Enzyme (ACE) Inhibitor or Angiotensin Receptor Blocker (ARB) Therapy for Left Ventricular Systolic Dysfunction (LVSD)'
WHERE title = 'Heart Failure (HF): AngiotensinConverting Enzyme (ACE) Inhibitor or Angiotensin Receptor Blocker (ARB) Therapy for Left Ventricular Systolic Dysfunction (LVSD)';
END;

BEGIN;
UPDATE openchpl.cqm_criterion
SET title = 'Incidence of Potentially-Preventable Venous Thromboembolism'
WHERE title = 'Incidence of PotentiallyPreventable Venous Thromboembolism';
END;
