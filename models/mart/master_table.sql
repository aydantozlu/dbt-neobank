SELECT i.*,
c.churner,
sc.score_f,
sc.score_r,
sc.score_m,
sc.score_rfm,
CASE WHEN i.user_settings_crypto_unlocked = 0 THEN 1
  WHEN i.user_settings_crypto_unlocked = 1 THEN 2
  END AS persona
FROM {{ ref('int_transac_device_user') }} i 
LEFT JOIN {{ ref('explo_customer_engagement') }} c ON c.user_id = i.user_id
LEFT JOIN {{ ref('stg_raw__user_id_score_rfm') }} sc ON sc.user_id = i.user_id