-- Remove (Cures Update) from all criteria titles

UPDATE openchpl.certification_criterion
SET title = REPLACE(title, ' (Cures Update)', '');
