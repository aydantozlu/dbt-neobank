SELECT i.*,
c.churner
FROM {{ ref('int_transac_device_user') }} i 
LEFT JOIN {{ ref('explo_customer_engagement') }} c ON c.user_id = i.user_id