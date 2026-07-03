{% macro getStatus(date_cancelled, date_delivery, date_shipping, date_purchase) %}
    CASE
        WHEN date_cancelled is not null THEN "Cancelled"
        WHEN date_delivery is not null THEN "Delivered"
        WHEN date_shipping is not null THEN "Shipped"
        WHEN date_purchase is not null THEN "In Progress"
        ELSE Null
    END
{% endmacro%}