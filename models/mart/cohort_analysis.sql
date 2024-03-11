WITH table_cohort AS (SELECT COUNT(DISTINCT user_id) as nb_user_id, cohort, nb_quarter
FROM {{ ref('master_table') }}
GROUP BY cohort, nb_quarter
ORDER BY cohort, nb_quarter),

table_cohort2 AS (
SELECT COUNT(DISTINCT user_id) as nb_users, cohort
FROM {{ ref('master_table') }}
GROUP BY cohort
ORDER BY cohort
)

SELECT table_cohort.*,
table_cohort2.nb_users,
ROUND(nb_user_id/nb_users*100,0) AS pourc_actif
FROM table_cohort
LEFT JOIN table_cohort2
ON table_cohort.cohort = table_cohort2.cohort
ORDER by cohort