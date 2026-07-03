{{ config(materialized='table') }}

with 

source as (

    select * from {{ source('raw', 'parcel') }}

),

renamed as (

    select
        parcel_id,
        parcel_tracking,
        transporter,
        priority,
        PARSE_DATE('%B %d, %Y', Date_purCHase) as date_purchase,
        PARSE_DATE('%B %d, %Y', Date_sHIpping) as date_shipping,
        PARSE_DATE('%B %d, %Y', DATE_delivery) as date_delivery,
        PARSE_DATE('%B %d, %Y', DaTeCANcelled) as date_cancelled

    from source

)

select * from renamed