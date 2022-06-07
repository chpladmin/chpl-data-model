-- make (g)(10) macra measure 'RT2a EH/CAH Medicare PI' point to the correct mips measure
UPDATE openchpl.allowed_measure_criteria
SET deleted = true
WHERE id = 198;

update openchpl.allowed_measure_criteria_legacy_map
set allowed_criteria_measure_id = 197
where id = 267;

-- remove the incorrect (g)(10) measure; nothing maps to this
UPDATE openchpl.measure
SET deleted = true
where id = 88;
