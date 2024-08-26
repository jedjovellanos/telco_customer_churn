-- Are senior citizens more or less likely to churn?
    -- Find percentage of seniors vs non seniors that have churned
WITH senior_counts AS (
    SELECT
        seniorcitizen,
        CAST(COUNT(*) AS NUMERIC) AS senior_count
    FROM customers
    GROUP BY seniorcitizen
),
churned_seniors AS (
    SELECT
        seniorcitizen,
        CAST(COUNT(*) AS NUMERIC) AS churned_senior
    FROM customers
    WHERE churn = 'Yes'
    GROUP BY seniorcitizen
),
total_customers AS (
    SELECT CAST(COUNT(*) AS NUMERIC) AS total_count
    FROM customers
)
SELECT 
    sc.seniorcitizen,
    sc.senior_count,
    ROUND((sc.senior_count / tc.total_count) * 100, 2) AS percentage_of_total_customers,
    ROUND((cs.churned_senior / sc.senior_count) * 100, 2) AS churn_rate
FROM senior_counts sc
LEFT JOIN churned_seniors cs ON sc.seniorcitizen = cs.seniorcitizen
CROSS JOIN total_customers tc
ORDER BY churn_rate DESC;
