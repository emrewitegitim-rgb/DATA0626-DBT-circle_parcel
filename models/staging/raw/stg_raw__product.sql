with 

source as (

    select * from {{ source('raw', 'product') }}

),

renamed as (

    select
        parcel_id,
        model_mame,
        quantity

    from source

)

select * from renamed