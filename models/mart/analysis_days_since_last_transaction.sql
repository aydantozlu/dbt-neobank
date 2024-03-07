WITH TransactionSummary AS (
  SELECT
    user_id,
    DATE_DIFF(DATE('2019-05-16'), DATE(MAX(created_date)), DAY) AS days_since_last_transaction,
    DATE_DIFF(DATE('2019-05-16'), DATE(MAX(created_date)), MONTH) AS months_since_last_transaction,
    DATE_DIFF(DATE('2019-05-16'), DATE(MAX(created_date)), YEAR) AS years_since_last_transaction
  FROM {{ ref('int_transac_device_user') }}
  GROUP BY
    user_id
)

SELECT
  MIN(days_since_last_transaction) AS min_days,
  APPROX_QUANTILES(days_since_last_transaction, 4)[OFFSET(1)] AS first_quartile_days,
  APPROX_QUANTILES(days_since_last_transaction, 2)[OFFSET(1)] AS median_days,
  APPROX_QUANTILES(days_since_last_transaction, 4)[OFFSET(3)] AS third_quartile_days,
  APPROX_QUANTILES(days_since_last_transaction, 10)[OFFSET(8)] AS percentile_80_days,
  APPROX_QUANTILES(days_since_last_transaction, 10)[OFFSET(9)] AS percentile_90_days,
  MAX(days_since_last_transaction) AS max_days,
  COUNT(user_id) AS nb_customers
FROM
  TransactionSummary
