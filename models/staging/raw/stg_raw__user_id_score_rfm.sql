with 

source as (

    select * from {{ source('raw', 'user_id_score_rfm') }}

),

renamed as (

    select
        user_id,
        score_f,
        score_r,
        score_m,
        score_rfm

    from source

)

select * from renamed
