-- What is the distribution for internet service?
WITH internet_service_counts AS(
    SELECT
        internetservice,
        CAST(COUNT(*) AS NUMERIC) AS internet_service_count
    FROM customers
    GROUP BY internetservice
),
churned_internet AS (
    SELECT
        internetservice,
        CAST(COUNT(*) AS NUMERIC) AS churned_internet
    FROM customers
    WHERE churn = 'Yes'
    GROUP BY internetservice
),
total_customers AS (
    SELECT CAST(COUNT(*) AS NUMERIC) AS total_count
    FROM customers
)
SELECT
    isc.internetservice,
    isc.internet_service_count,
    ROUND((isc.internet_service_count/tc.total_count)*100, 2) AS percentage_of_total_customers,
    ROUND((ci.churned_internet/isc.internet_service_count)*100, 2) AS churn_rate
FROM internet_service_counts isc
LEFT JOIN churned_internet ci ON isc.internetservice = ci.internetservice
CROSS JOIN total_customers tc
ORDER BY churn_rate DESC;