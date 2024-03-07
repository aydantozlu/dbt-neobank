select
    t.*,
    d.brand,
    u.birth_year,
    u.country,
    u.created_date as user_created_date,
    u.user_settings_crypto_unlocked,
    u.plan,
    u.attributes_notifications_marketing_push,
    u.attributes_notifications_marketing_email,
    u.num_contacts,
    m.ea_merchant_mcc_description,
    CASE
        WHEN 2019 - u.birth_year <= 25 THEN '18-25'
        WHEN 2019 - u.birth_year BETWEEN 26 AND 35 THEN '26-35'
        WHEN 2019 - u.birth_year BETWEEN 36 AND 50 THEN '36-50'
        ELSE '+50'
    END AS tranche_age
from {{ ref("stg_raw__transactions") }} t
left join {{ ref("stg_raw__devices") }} d on t.user_id = d.user_id
left join {{ ref("stg_raw__users") }} u on t.user_id = u.user_id
left join {{ ref('stg_raw__mcc_description') }} m on t.ea_merchant_mcc = m.ea_merchant_mcc