WITH base AS (
  SELECT
    variant_group, 
    did_visit, 
    did_convert, 
    post_campaign_spend,
    CASE WHEN months_since_last_buy <= 3 THEN '1-3 months'
         WHEN months_since_last_buy <= 6 THEN '4-6 months'
         ELSE '7-12 months' END AS recency,
    CASE WHEN bought_mens = 1 AND bought_womens = 1 THEN 'both'
         WHEN bought_mens = 1 THEN 'mens only'
         WHEN bought_womens = 1 THEN 'womens only'
         ELSE 'neither' END AS past_purchase,
    spend_tier,
    CASE WHEN is_new_acc = 1 THEN 'new' ELSE 'existing' END AS customer_type,
    channel,
    geo_zone
  FROM `abtes-510522.raw.email_experiment`
),
long AS (
            SELECT 
              variant_group, 
              did_visit, 
              did_convert, 
              post_campaign_spend, 
              'recency' AS dimension, 
              recency AS segment 
            FROM base
  UNION ALL SELECT 
              variant_group, 
              did_visit, 
              did_convert, 
              post_campaign_spend, 
              'past_purchase' AS dimension, 
              past_purchase AS segment 
            FROM base
  UNION ALL SELECT 
              variant_group, 
              did_visit, 
              did_convert, 
              post_campaign_spend, 
              'spend_tier' AS dimension, 
              spend_tier AS segment 
            FROM base
  UNION ALL SELECT 
              variant_group, 
              did_visit, 
              did_convert, 
              post_campaign_spend, 
              'customer_type' AS dimension, 
              customer_type AS segment 
            FROM base
  UNION ALL SELECT 
              variant_group, 
              did_visit, 
              did_convert, 
              post_campaign_spend, 
              'channel' AS dimension, 
              channel AS segment 
            FROM base
  UNION ALL SELECT 
              variant_group,
              did_visit, 
              did_convert, 
              post_campaign_spend, 
              'geo_zone' AS dimension, 
              geo_zone AS segment 
              FROM base
)
SELECT
  dimension, 
  segment, 
  variant_group,
  COUNT(*) AS users,
  SUM(did_visit) AS visits,
  SUM(did_convert) AS conversions,
  SUM(post_campaign_spend) AS revenue,
  AVG(post_campaign_spend) AS rev_per_user,
  STDDEV_SAMP(post_campaign_spend) AS rev_std
FROM long
GROUP BY dimension, segment, variant_group;
