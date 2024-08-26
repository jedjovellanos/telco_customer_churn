-- What are the most and least common internet service add-ons?
SELECT
    COUNT(CASE WHEN onlinesecurity = 'Yes' THEN 1 END) AS onlinesecurity,
    COUNT(CASE WHEN onlinebackup = 'Yes' THEN 1 END) AS onlinebackup,
    COUNT(CASE WHEN deviceprotection = 'Yes' THEN 1 END) AS deviceprotection,
    COUNT(CASE WHEN techsupport = 'Yes' THEN 1 END) AS techsupport,
    COUNT(CASE WHEN streamingtv = 'Yes' THEN 1 END) AS streamingtv,
    COUNT(CASE WHEN streamingmovies = 'Yes' THEN 1 END) AS streamingmovies
FROM customers;

-- Find the percentage of all customers that are signed up for each add-on
WITH add_on_counts AS (
    SELECT
        CAST(SUM(CASE WHEN onlinesecurity = 'Yes' THEN 1 ELSE 0 END) AS NUMERIC) AS count_onlinesecurity,
        CAST(SUM(CASE WHEN onlinebackup = 'Yes' THEN 1 ELSE 0 END) AS NUMERIC) AS count_onlinebackup,
        CAST(SUM(CASE WHEN deviceprotection = 'Yes' THEN 1 ELSE 0 END) AS NUMERIC) AS count_deviceprotection,
        CAST(SUM(CASE WHEN techsupport = 'Yes' THEN 1 ELSE 0 END) AS NUMERIC) AS count_techsupport,
        CAST(SUM(CASE WHEN streamingtv = 'Yes' THEN 1 ELSE 0 END) AS NUMERIC) AS count_streamingtv,
        CAST(SUM(CASE WHEN streamingmovies = 'Yes' THEN 1 ELSE 0 END) AS NUMERIC) AS count_streamingmovies
    FROM customers
),
total_customers AS (
    SELECT CAST(COUNT(*) AS NUMERIC) AS total_count
    FROM customers
)
SELECT
    ROUND((ac.count_onlinesecurity / tc.total_count) * 100, 2) AS percentage_onlinesecurity,
    ROUND((ac.count_onlinebackup / tc.total_count) * 100, 2) AS percentage_onlinebackup,
    ROUND((ac.count_deviceprotection / tc.total_count) * 100, 2) AS percentage_deviceprotection,
    ROUND((ac.count_techsupport / tc.total_count) * 100, 2) AS percentage_techsupport,
    ROUND((ac.count_streamingtv / tc.total_count) * 100, 2) AS percentage_streamingtv,
    ROUND((ac.count_streamingmovies / tc.total_count) * 100, 2) AS percentage_streamingmovies
FROM add_on_counts ac
CROSS JOIN total_customers tc;

-- What are the churn rates associated with customers that have each of the add-ons?
WITH add_on_counts AS (
    SELECT
        CAST(SUM(CASE WHEN onlinesecurity = 'Yes' THEN 1 ELSE 0 END) AS NUMERIC) AS count_onlinesecurity,
        CAST(SUM(CASE WHEN onlinebackup = 'Yes' THEN 1 ELSE 0 END) AS NUMERIC) AS count_onlinebackup,
        CAST(SUM(CASE WHEN deviceprotection = 'Yes' THEN 1 ELSE 0 END) AS NUMERIC) AS count_deviceprotection,
        CAST(SUM(CASE WHEN techsupport = 'Yes' THEN 1 ELSE 0 END) AS NUMERIC) AS count_techsupport,
        CAST(SUM(CASE WHEN streamingtv = 'Yes' THEN 1 ELSE 0 END) AS NUMERIC) AS count_streamingtv,
        CAST(SUM(CASE WHEN streamingmovies = 'Yes' THEN 1 ELSE 0 END) AS NUMERIC) AS count_streamingmovies,
        CAST(SUM(CASE WHEN churn = 'Yes' AND onlinesecurity = 'Yes' THEN 1 ELSE 0 END) AS NUMERIC) AS ch_onlinesecurity,
        CAST(SUM(CASE WHEN churn = 'Yes' AND onlinebackup = 'Yes' THEN 1 ELSE 0 END) AS NUMERIC) AS ch_onlinebackup,
        CAST(SUM(CASE WHEN churn = 'Yes' AND deviceprotection = 'Yes' THEN 1 ELSE 0 END) AS NUMERIC) AS ch_deviceprotection,
        CAST(SUM(CASE WHEN churn = 'Yes' AND techsupport = 'Yes' THEN 1 ELSE 0 END) AS NUMERIC) AS ch_techsupport,
        CAST(SUM(CASE WHEN churn = 'Yes' AND streamingtv = 'Yes' THEN 1 ELSE 0 END) AS NUMERIC) AS ch_streamingtv,
        CAST(SUM(CASE WHEN churn = 'Yes' AND streamingmovies = 'Yes' THEN 1 ELSE 0 END) AS NUMERIC) AS ch_streamingmovies
    FROM customers
)
SELECT
    ROUND((ch_onlinesecurity / NULLIF(count_onlinesecurity, 0)) * 100, 2) AS onlinesecurity_churn_rate,
    ROUND((ch_onlinebackup / NULLIF(count_onlinebackup, 0)) * 100, 2) AS onlinebackup_churn_rate,
    ROUND((ch_deviceprotection / NULLIF(count_deviceprotection, 0)) * 100, 2) AS deviceprotection_churn_rate,
    ROUND((ch_techsupport / NULLIF(count_techsupport, 0)) * 100, 2) AS techsupport_churn_rate,
    ROUND((ch_streamingtv / NULLIF(count_streamingtv, 0)) * 100, 2) AS streamingtv_churn_rate,
    ROUND((ch_streamingmovies / NULLIF(count_streamingmovies, 0)) * 100, 2) AS streamingmovies_churn_rate
FROM add_on_counts;