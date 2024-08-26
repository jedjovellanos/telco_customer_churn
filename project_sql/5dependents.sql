-- Are those with dependents more likely to churn?
WITH dependent_counts AS (
    SELECT
        dependents,
        CAST(COUNT(*) AS NUMERIC) AS dependent_count
    FROM customers
    GROUP BY dependents
),
churned_dependents AS (
    SELECT
        dependents,
        CAST(COUNT(*) AS NUMERIC) AS churned_dependents
    FROM customers
    WHERE churn = 'Yes'
    GROUP BY dependents
),
total_customers AS (
    SELECT CAST(COUNT(*) AS NUMERIC) AS total_count
    FROM customers
)
SELECT 
    d.dependents,
    d.dependent_count,
    ROUND((d.dependent_count / tc.total_count) * 100, 2) AS percentage_of_total_customers,
    ROUND((cd.churned_dependents / d.dependent_count) * 100, 2) AS churn_rate
FROM dependent_counts d
LEFT JOIN churned_dependents cd ON d.dependents = cd.dependents
CROSS JOIN total_customers tc
ORDER BY churn_rate DESC;
