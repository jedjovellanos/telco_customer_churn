-- Does billing type affect churn rates?
WITH billing_counts AS (
    SELECT
        paperlessbilling,
        CAST(COUNT(*) AS NUMERIC) AS billing_count
    FROM customers
    GROUP BY paperlessbilling
),
churned_billing AS (
    SELECT
        paperlessbilling,
        CAST(COUNT(*) AS NUMERIC) AS churned_billing
    FROM customers
    WHERE churn = 'Yes'
    GROUP BY paperlessbilling
),
total_customers AS (
    SELECT CAST(COUNT(*) AS NUMERIC) AS total_count
    FROM customers
)
SELECT 
    b.paperlessbilling,
    b.billing_count AS total_count,
    ROUND((b.billing_count / tc.total_count) * 100, 2) AS percentage_of_total_customers,
    ROUND((cb.churned_billing / b.billing_count) * 100, 2) AS churn_rate
FROM billing_counts b
LEFT JOIN churned_billing cb ON b.paperlessbilling = cb.paperlessbilling
CROSS JOIN total_customers tc
ORDER BY churn_rate DESC;
