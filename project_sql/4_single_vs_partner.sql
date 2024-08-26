-- Are those with partners more likely to churn?
WITH partner_counts AS (
    SELECT
        partner,
        CAST(COUNT(*) AS NUMERIC) AS partner_count
    FROM customers
    GROUP BY partner
),
churned_partners AS (
    SELECT
        partner,
        CAST(COUNT(*) AS NUMERIC) AS churned_partner
    FROM customers
    WHERE churn = 'Yes'
    GROUP BY partner
),
total_customers AS (
    SELECT CAST(COUNT(*) AS NUMERIC) AS total_count
    FROM customers
)
SELECT 
    p.partner,
    p.partner_count,
    ROUND((p.partner_count / tc.total_count) * 100, 2) AS percentage_of_total_customers,
    ROUND((c.churned_partner / p.partner_count) * 100, 2) AS churn_rate
FROM partner_counts p
LEFT JOIN churned_partners c ON p.partner = c.partner
CROSS JOIN total_customers tc
ORDER BY churn_rate DESC;
