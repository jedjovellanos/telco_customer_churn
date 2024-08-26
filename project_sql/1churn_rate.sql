-- find number of churned customers 
SELECT COUNT(*) AS num_churned
FROM customers
WHERE churn = 'Yes';

-- find total number of customers
SELECT COUNT(*) AS total_customers
FROM customers;

-- calculate churn rate
WITH churned_customers AS (
    SELECT customerid
    FROM customers
    WHERE churn = 'Yes'
),
total_churned AS (
    SELECT CAST(COUNT(*) AS NUMERIC) AS churned_count
    FROM churned_customers
),
total_customers AS (
    SELECT CAST(COUNT(*) AS NUMERIC) AS total_count
    FROM customers
)
SELECT
    tc.churned_count AS num_churned,
    t.total_count AS total_customers,
    ROUND((tc.churned_count / t.total_count) * 100, 2) AS churn_rate
FROM total_customers t
CROSS JOIN total_churned tc;

-- condensed version without using CTEs
SELECT
    COUNT(CASE WHEN churn = 'Yes' THEN 1 END) AS num_churned,
    COUNT(*) AS total_customers,
    ROUND((CAST(COUNT(CASE WHEN churn = 'Yes' THEN 1 END) AS NUMERIC)/COUNT(*))*100,2) AS churn_rate
FROM customers;