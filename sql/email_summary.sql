SELECT
  variant_group,
  COUNT(*) AS users,
  SUM(did_visit) AS visits,
  SUM(did_convert) AS conversions,
  SUM(post_campaign_spend) AS revenue,
  AVG(post_campaign_spend) AS rev_per_user,
  STDDEV_SAMP(post_campaign_spend) AS rev_std,
  COUNTIF(did_convert = 1 AND did_visit = 0) AS bad_rows, -- check if = 0
  COUNTIF(post_campaign_spend < 0) AS neg_spend -- check if = 0
FROM `abtes-510522.raw.email_experiment`
GROUP BY variant_group;
