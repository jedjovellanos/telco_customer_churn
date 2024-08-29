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

/*
Testing combinations

-- Single with no dependents
SELECT COUNT(*)
FROM customers
WHERE partner = 'No' AND dependents = 'No' AND churn = 'Yes';

-- Single with dependents
SELECT COUNT(*)
FROM customers
WHERE partner = 'No' AND dependents = 'Yes' AND churn = 'Yes';

-- Couple no dependents
SELECT COUNT(*)
FROM customers
WHERE partner = 'Yes' AND dependents = 'No' AND churn = 'Yes';

-- Couple with dependents
SELECT COUNT(*)
FROM customers
WHERE partner = 'Yes' AND dependents = 'Yes' AND churn = 'Yes';

/******************************************************************
    Results
    - 1123 Single with no dependents
    - 77 Single with dependents
    - 420 Couple no dependents
    - 249 Couple with dependents
******************************************************************/