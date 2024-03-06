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
from {{ ref("stg_raw__transactions") }} t
left join {{ ref("stg_raw__devices") }} d on t.user_id = d.user_id
left join {{ ref("stg_raw__users") }} u on t.user_id = u.user_id