ALTER TABLE openchpl.attestation_checkin_report
ADD COLUMN IF NOT EXISTS attests_g7 boolean;

ALTER TABLE openchpl.attestation_checkin_report
ADD COLUMN IF NOT EXISTS attests_g9 boolean;

ALTER TABLE openchpl.attestation_checkin_report
ADD COLUMN IF NOT EXISTS attests_g10 boolean;

