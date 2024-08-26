-- Are those with multiple lines more likely to churn?
WITH multiple_lines_counts AS (
    SELECT
        multiplelines,
        CAST(COUNT(*) AS NUMERIC) AS multiple_lines_count
    FROM customers
    GROUP BY multiplelines
),
churned_multiple_lines AS (
    SELECT
        multiplelines,
        CAST(COUNT(*) AS NUMERIC) AS churned_multiple_lines
    FROM customers
    WHERE churn = 'Yes'
    GROUP BY multiplelines
),
total_customers AS (
    SELECT CAST(COUNT(*) AS NUMERIC) AS total_count
    FROM customers
)
SELECT 
    ml.multiplelines,
    ml.multiple_lines_count AS total_count,
    ROUND((ml.multiple_lines_count / tc.total_count) * 100, 2) AS percentage_of_total_customers,
    ROUND((cml.churned_multiple_lines / ml.multiple_lines_count) * 100, 2) AS churn_rate
FROM multiple_lines_counts ml
LEFT JOIN churned_multiple_lines cml ON ml.multiplelines = cml.multiplelines
CROSS JOIN total_customers tc
ORDER BY churn_rate DESC;

