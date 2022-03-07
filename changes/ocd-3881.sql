INSERT INTO openchpl.surveillance_requirement_type (name, last_modified_user)
SELECT 'Attestations Submission', -1
WHERE NOT EXISTS(
   SELECT *
   FROM openchpl.surveillance_requirement_type
   WHERE name = 'Attestations Submission'
);
