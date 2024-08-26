/**********************************************************
MAIN QUESTION:
    -- Are longer tenured customers less likely to churn?
**********************************************************/

-- What is entire range of tenures?
SELECT 
    tenure,
    ROUND(CAST(tenure AS NUMERIC)/12,1) AS tenure_in_years
FROM customers
GROUP BY tenure
ORDER BY tenure DESC;

-- Where do most customers fall?
SELECT 
    tenure,
    ROUND(CAST(tenure AS NUMERIC)/12,1) AS tenure_in_years,
    COUNT(tenure) AS num_customers
FROM customers
GROUP BY tenure
ORDER BY num_customers DESC;

-- How do churn rates vary across tenure groups?
WITH tenure_groups AS (
    SELECT
        tenure,
        COUNT(*) AS total_customers,
        SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers
    FROM customers
    GROUP BY tenure
)
SELECT
    tenure,
    total_customers,
    churned_customers,
    ROUND((churned_customers::NUMERIC / total_customers::NUMERIC)*100, 2) AS churn_percentage
FROM tenure_groups
ORDER BY churn_percentage DESC;
