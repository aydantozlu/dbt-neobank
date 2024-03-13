SELECT i.*,
CONCAT(CAST(EXTRACT(YEAR FROM (i.user_created_date)) AS STRING), ' Q', CAST(EXTRACT(QUARTER FROM (i.user_created_date)) AS STRING)) AS cohort,
DATE_DIFF(DATE(created_date), DATE(c.first_transaction_date), QUARTER) AS nb_quarter,
c.churner,
c.first_transaction_date,
sc.score_f,
sc.score_r,
sc.score_m,
sc.score_rfm,
CASE WHEN i.user_settings_crypto_unlocked = 0 THEN "Chameau"
  WHEN i.user_settings_crypto_unlocked = 1 THEN "Licorne"
  END AS persona
FROM {{ ref('int_transac_device_user') }} i 
LEFT JOIN {{ ref('explo_customer_engagement') }} c ON c.user_id = i.user_id
LEFT JOIN {{ ref('stg_raw__user_id_score_rfm') }} sc ON sc.user_id = i.user_id