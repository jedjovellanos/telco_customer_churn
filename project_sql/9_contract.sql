-- What is the contract type breakdown?
WITH contract_counts AS (
    SELECT 
        contract,
        CAST(COUNT(*) AS NUMERIC) AS count_contract
    FROM customers
    GROUP BY contract
),
total_customers AS (
    SELECT CAST(COUNT(*) AS NUMERIC) AS total_count
    FROM customers
),
churned_contracts AS (
    SELECT 
        contract,
        COUNT(*) AS churned_count
    FROM customers
    WHERE churn = 'Yes'
    GROUP BY contract
)
SELECT
    cc.contract,
    cc.count_contract,
    ROUND((cc.count_contract / tc.total_count) * 100, 2) AS contract_percentage,
    ROUND((chc.churned_count / cc.count_contract) * 100, 2) AS churn_rate
FROM contract_counts cc
LEFT JOIN churned_contracts chc ON cc.contract = chc.contract
CROSS JOIN total_customers tc
ORDER BY churn_rate DESC;

