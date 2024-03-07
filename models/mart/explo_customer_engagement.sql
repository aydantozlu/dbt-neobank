SELECT
user_id,
MIN(user_created_date) AS first_user_created_date,
EXTRACT(YEAR FROM MIN(user_created_date)) AS first_user_created_yr_only,
EXTRACT(QUARTER FROM MIN(user_created_date)) AS first_user_created_qt_only,
CONCAT(CAST(EXTRACT(YEAR FROM MIN(user_created_date)) AS STRING), ' Q', CAST(EXTRACT(QUARTER FROM MIN(user_created_date)) AS STRING)) AS acquisition_quarter,
MAX(created_date) AS last_transaction_date,
EXTRACT(YEAR FROM MAX(created_date)) AS last_transaction_yr_only,
EXTRACT(QUARTER FROM MAX(created_date)) AS last_transaction_qt_only,
CONCAT(CAST(EXTRACT(YEAR FROM MAX(created_date)) AS STRING), ' Q', CAST(EXTRACT(QUARTER FROM MAX(created_date)) AS STRING)) AS last_transaction_quarter,
DATE_DIFF(DATE('2019-05-16'),DATE(MAX(created_date)),  DAY) AS days_since_last_transaction,
COUNT(transaction_id) AS nb_transactions,
SUM(amount_usd) AS amount_transactions,
CASE
    WHEN DATE_DIFF(DATE('2019-05-16'), DATE(MAX(created_date)), DAY) > 134 THEN 1
    ELSE 0
  END AS churner
FROM {{ ref('int_transac_device_user') }}
GROUP BY user_id