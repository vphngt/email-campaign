DROP VIEW IF EXISTS `abtes-510522.raw.email_experiment`;

CREATE OR REPLACE TABLE `abtes-510522.raw.email_experiment` AS
SELECT
  GENERATE_UUID() AS user_key,
  CAST(recency AS INT64) AS months_since_last_buy,
  CAST(history AS FLOAT64) AS historical_spend,
  history_segment AS spend_tier,
  CAST(mens AS INT64) AS bought_mens,
  CAST(womens AS INT64) AS bought_womens,
  CAST(newbie AS INT64) AS is_new_acc,
  LOWER(zip_code) AS geo_zone,
  LOWER(channel) AS channel,
  LOWER(segment) AS variant_group,
  CAST(visit AS INT64) AS did_visit,
  CAST(conversion AS INT64) AS did_convert,
  CAST(spend AS FLOAT64) AS post_campaign_spend
FROM `abtes-510522.raw.email_analytics`;