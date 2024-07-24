ALTER TABLE openchpl.subscription_observation
ADD COLUMN IF NOT EXISTS notified_at timestamp;
