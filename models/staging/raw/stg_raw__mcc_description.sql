with 

source as (

    select * from {{ source('raw', 'mcc_description') }}

),

renamed as (

    select
        ea_merchant_mcc,
        ea_merchant_mcc_description

    from source

)

select * from renamed
