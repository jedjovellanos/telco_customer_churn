-- How do churn rates vary across payment methods?
WITH paymentmethod_counts AS (
    SELECT
        paymentmethod,
        CAST(COUNT(*) AS NUMERIC) AS paymentmethod_count
    FROM customers
    GROUP BY paymentmethod
),
churned_paymentmethod AS (
    SELECT
        paymentmethod,
        CAST(COUNT(*) AS NUMERIC) AS churned_paymentmethod
    FROM customers
    WHERE churn = 'Yes'
    GROUP BY paymentmethod
),
total_customers AS (
    SELECT CAST(COUNT(*) AS NUMERIC) AS total_count
    FROM customers
)
SELECT 
    pm.paymentmethod,
    pm.paymentmethod_count AS total_count,
    ROUND((pm.paymentmethod_count / tc.total_count) * 100, 2) AS percentage_of_total_customers,
    ROUND((cp.churned_paymentmethod / pm.paymentmethod_count) * 100, 2) AS churn_rate
FROM paymentmethod_counts pm
LEFT JOIN churned_paymentmethod cp ON pm.paymentmethod = cp.paymentmethod
CROSS JOIN total_customers tc
ORDER BY churn_rate DESC;
