-- Dummy 'bad' URL for a7 criterion 

UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'http://abadurl.com'
WHERE certification_criterion_id = 7;