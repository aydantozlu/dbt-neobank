with 

source as (

    select * from {{ source('raw', 'devices') }}

),

renamed as (

    select
        string_field_0 AS brand,
        string_field_1 AS user_id,

    from source

)

select * from renamed
