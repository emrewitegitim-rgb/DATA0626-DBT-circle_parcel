WITH parcel_details AS (
    SELECT 
        parcel_id
        , SUM(quantity) as total_quantity
        , count(model_name) as nb_model
    FROM {{ ref("stg_raw__product")}}
    GROUP BY parcel_id
)

SELECT
    p.*
    , EXTRACT(MONTH FROM date_purchase) AS month_purhase
    , {{ getStatus(date_cancelled, date_delivery, date_shipping, date_purchase) }} AS status
    , DATE_DIFF(date_shipping, date_purchase, DAY) AS expedition_time
    , DATE_DIFF(date_delivery, date_shipping, DAY) AS transport_time
    , DATE_DIFF(date_delivery, date_purchase, DAY) AS delivery_time
    , IF(DATE_DIFF(date_delivery, date_purchase, DAY) > 3, DATE_DIFF(date_delivery, date_purchase, DAY) - 3, NULL) AS delay
    , total_quantity as qty
    , nb_model
FROM {{ ref("stg_raw__parcel")}} as p
JOIN parcel_details as d
    using(parcel_id)