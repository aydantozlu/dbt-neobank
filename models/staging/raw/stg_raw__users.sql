with 

source as (

    select * from {{ source('raw', 'users') }}

),

renamed as (

    select
        user_id,
        birth_year,
        country,
        created_date,
        user_settings_crypto_unlocked,
        plan,
        COALESCE(attributes_notifications_marketing_push, 0) AS attributes_notifications_marketing_push,
        COALESCE(attributes_notifications_marketing_email, 0) AS attributes_notifications_marketing_email,
        num_contacts

    from source

)

select * from renamed
