with 

source as (

    select * from {{ source('raw', 'notifications') }}

),

renamed as (

    select
        GENERATE_UUID() AS notification_id,
        reason,
        channel,
        status,
        user_id,
        created_date

    from source

)

select * from renamed
