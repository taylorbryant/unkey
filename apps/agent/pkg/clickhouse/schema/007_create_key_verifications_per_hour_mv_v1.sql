-- +goose up
CREATE MATERIALIZED VIEW default.key_verifications_per_hour_mv_v1
TO default.key_verifications_per_hour_v1
AS
SELECT
  workspace_id,
  key_space_id,
  identity_id,
  key_id,
  outcome,
  count(*) as count,
  toStartOfHour(fromUnixTimestamp64Milli(time)) AS time
FROM default.raw_key_verifications_v1
GROUP BY
  workspace_id,
  key_space_id,
  identity_id,
  key_id,
  outcome,
  time
;