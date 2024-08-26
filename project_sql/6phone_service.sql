-- Are those with phone service more likely to churn?
WITH phone_service_counts AS (
    SELECT
        phoneservice,
        CAST(COUNT(*) AS NUMERIC) AS phone_service_count
    FROM customers
    GROUP BY phoneservice
),
churned_phone_services AS (
    SELECT
        phoneservice,
        CAST(COUNT(*) AS NUMERIC) AS churned_phone_service
    FROM customers
    WHERE churn = 'Yes'
    GROUP BY phoneservice
),
total_customers AS (
    SELECT CAST(COUNT(*) AS NUMERIC) AS total_count
    FROM customers
)
SELECT 
    ps.phoneservice,
    ps.phone_service_count,
    ROUND((ps.phone_service_count / tc.total_count) * 100, 2) AS percentage_of_total_customers,
    ROUND((cps.churned_phone_service / ps.phone_service_count) * 100, 2) AS churn_rate
FROM phone_service_counts ps
LEFT JOIN churned_phone_services cps ON ps.phoneservice = cps.phoneservice
CROSS JOIN total_customers tc
ORDER BY churn_rate DESC;
