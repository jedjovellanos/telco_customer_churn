/******************************************************************
MAIN QUESTION:
    -- Is there any correlation between charge amounts and churn?
******************************************************************/

-- Compare monthly and total charges
SELECT 
    'Monthly Charges' AS charge_type,
    churn,
    MIN(monthlycharges) AS min_charge,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY monthlycharges) AS q1_charge,
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY monthlycharges) AS median_charge,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY monthlycharges) AS q3_charge,
    MAX(monthlycharges) AS max_charge
FROM customers
GROUP BY churn

UNION ALL

SELECT 
    'Total Charges' AS charge_type,
    churn,
    MIN(totalcharges) AS min_charge,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY totalcharges) AS q1_charge,
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY totalcharges) AS median_charge,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY totalcharges) AS q3_charge,
    MAX(totalcharges) AS max_charge
FROM customers
GROUP BY churn;
