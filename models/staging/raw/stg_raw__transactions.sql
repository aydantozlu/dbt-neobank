with 

source as (

    select * from {{ source('raw', 'transactions') }}

),

renamed as (

    select
        transaction_id,
        transactions_type,
        transactions_currency,
        amount_usd,
        transactions_state,
        ea_merchant_mcc,
        COALESCE(ea_merchant_country, 'None') AS ea_merchant_country,
        direction,
        user_id,
        created_date

    from source

)

select * from renamed
