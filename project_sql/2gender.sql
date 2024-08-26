-- Is one gender more likely to churn?
WITH gender_counts AS (
    SELECT
        gender,
        CAST(COUNT(*) AS NUMERIC) AS gender_count
    FROM customers
    GROUP BY gender
),
churned_genders AS(
    SELECT
        gender,
        CAST(COUNT(*) AS NUMERIC) AS churned_gender
    FROM customers
    WHERE churn = 'Yes'
    GROUP BY gender
),
total_customers AS (
    SELECT CAST(COUNT(*) AS NUMERIC) AS total_count
    FROM customers
)
SELECT 
    gc.gender,
    gc.gender_count,
    ROUND((gc.gender_count / tc.total_count) * 100, 2) AS percentage_of_total_customers,
    ROUND((cg.churned_gender / gender_count) * 100, 2) AS churn_rate
FROM gender_counts gc
LEFT JOIN churned_genders cg ON gc.gender = cg.gender
CROSS JOIN total_customers tc
ORDER BY churn_rate DESC;
