SELECT
  t.*,
  d.brand,
  u.birth_year,
  u.country,
  u.created_date AS user_created_date,
  u.user_settings_crypto_unlocked,
  u.plan,
  u.attributes_notifications_marketing_push,
  u.attributes_notifications_marketing_email,
  u.num_contacts
FROM `neobank1513.dbt_atozlu.stg_raw__transactions` t
LEFT JOIN `neobank1513.dbt_atozlu.stg_raw__devices` d ON t.user_id = d.user_id
LEFT JOIN `neobank1513.dbt_atozlu.stg_raw__users` u ON t.user_id = u.user_id