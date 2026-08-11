-- =====================================================
-- Credit Card Transaction Analysis
-- Database Setup & Initial Validation
-- =====================================================


-- =====================================================
-- 1. DATABASE SETUP
-- =====================================================

CREATE TABLE credit_card_transactions (
    trans_date_trans_time TIMESTAMP,
    cc_num BIGINT,
    merchant TEXT,
    category TEXT,
    amt DOUBLE PRECISION,
    first TEXT,
    last TEXT,
    gender TEXT,
    street TEXT,
    city TEXT,
    state TEXT,
    zip INTEGER,
    lat DOUBLE PRECISION,
    long DOUBLE PRECISION,
    city_pop BIGINT,
    job TEXT,
    dob DATE,
    trans_num TEXT,
    unix_time BIGINT,
    merch_lat DOUBLE PRECISION,
    merch_long DOUBLE PRECISION,
    is_fraud INTEGER,
    merch_zipcode DOUBLE PRECISION,
    year INTEGER,
    month INTEGER,
    month_name TEXT,
    day INTEGER,
    day_name TEXT,
    hour INTEGER
);


-- =====================================================
-- 2. DATA VALIDATION
-- =====================================================

-- Check total number of records
SELECT COUNT(*) 
FROM credit_card_transactions;


-- Preview the first 10 records
SELECT *
FROM credit_card_transactions
LIMIT 10;


-- Check transaction date range and total transactions
SELECT
    MIN(trans_date_trans_time) AS first_transaction,
    MAX(trans_date_trans_time) AS last_transaction,
    COUNT(*) AS total_transactions
FROM credit_card_transactions;


-- =====================================================
-- 3. BASIC DATASET OVERVIEW
-- =====================================================

-- Count transactions, customers, merchants and categories
SELECT
    COUNT(*) AS total_transactions,
    COUNT(DISTINCT cc_num) AS unique_customers,
    COUNT(DISTINCT merchant) AS unique_merchants,
    COUNT(DISTINCT category) AS unique_categories
FROM credit_card_transactions;



-- =====================================================
-- 4. OVERALL TRANSACTION KPIs
-- =====================================================

-- Calculate overall transaction amount statistics
SELECT
    COUNT(*) AS total_transactions,
    SUM(amt) AS total_transaction_amount,
    ROUND(AVG(amt)::numeric, 2) AS average_transaction_amount,
    MIN(amt) AS minimum_transaction_amount,
    MAX(amt) AS maximum_transaction_amount
FROM credit_card_transactions;





-- =====================================================
-- 5. FRAUD ANALYSIS
-- =====================================================

-- Analyze overall fraud transactions and fraud amount
SELECT
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    SUM(CASE WHEN is_fraud = 1 THEN amt ELSE 0 END) AS fraud_amount,
    ROUND(
        100.0 * SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS fraud_percentage
FROM credit_card_transactions;


-- Fraud transactions by category
SELECT
    category,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    ROUND(
        100.0 * SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS fraud_percentage
FROM credit_card_transactions
GROUP BY category
ORDER BY fraud_transactions DESC;


-- Fraud transactions by month
SELECT
    year,
    month,
    month_name,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_transactions
FROM credit_card_transactions
GROUP BY year, month, month_name
ORDER BY year, month;


-- Fraud transactions by hour
SELECT
    hour,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_transactions
FROM credit_card_transactions
GROUP BY hour
ORDER BY fraud_transactions DESC;


-- Fraud amount by category
SELECT
    category,
    COUNT(*) AS fraud_transactions,
    SUM(amt) AS fraud_amount
FROM credit_card_transactions
WHERE is_fraud = 1
GROUP BY category
ORDER BY fraud_amount DESC;




-- =====================================================
-- 6. CUSTOMER ANALYSIS
-- =====================================================

-- 6.1 Customer Transaction Summary
SELECT
    cc_num,
    COUNT(*) AS total_transactions,
    SUM(amt) AS total_spent,
    ROUND(AVG(amt)::numeric, 2) AS average_transaction_amount
FROM credit_card_transactions
GROUP BY cc_num
ORDER BY total_spent DESC;



-- 6.2 Top 10 Customers by Spending
SELECT
    cc_num,
    COUNT(*) AS total_transactions,
    SUM(amt) AS total_spent,
    ROUND(AVG(amt)::numeric, 2) AS average_transaction_amount
FROM credit_card_transactions
GROUP BY cc_num
ORDER BY total_spent DESC
LIMIT 10;



-- 6.3 Top 10 Customers by Transaction Count
SELECT
    cc_num,
    COUNT(*) AS total_transactions,
    SUM(amt) AS total_spent,
    ROUND(AVG(amt)::numeric, 2) AS average_transaction_amount
FROM credit_card_transactions
GROUP BY cc_num
ORDER BY total_transactions DESC
LIMIT 10;



-- 6.4 Top 10 Customers by Average Transaction Amount
SELECT
    cc_num,
    COUNT(*) AS total_transactions,
    SUM(amt) AS total_spent,
    ROUND(AVG(amt)::numeric, 2) AS average_transaction_amount
FROM credit_card_transactions
GROUP BY cc_num
ORDER BY average_transaction_amount DESC
LIMIT 10;


-- 6.5 Customers with Fraudulent Transactions
SELECT
    cc_num,
    COUNT(*) AS fraud_transactions,
    SUM(amt) AS fraud_amount,
    ROUND(AVG(amt)::numeric, 2) AS average_fraud_transaction
FROM credit_card_transactions
WHERE is_fraud = 1
GROUP BY cc_num
ORDER BY fraud_amount DESC
LIMIT 10;


-- =====================================================
-- 6.6 Customer Fraud Rate
-- =====================================================

SELECT
    cc_num,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    ROUND(
        100.0 * SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS fraud_rate_percentage
FROM credit_card_transactions
GROUP BY cc_num
HAVING COUNT(*) >= 10
ORDER BY fraud_rate_percentage DESC
LIMIT 10;


-- =====================================================
-- 6.7 Customer Analysis by Gender
-- =====================================================

SELECT
    gender,
    COUNT(DISTINCT cc_num) AS unique_customers,
    COUNT(*) AS total_transactions,
    SUM(amt) AS total_spent,
    ROUND(AVG(amt)::numeric, 2) AS average_transaction_amount
FROM credit_card_transactions
GROUP BY gender
ORDER BY total_spent DESC;


-- =====================================================
-- 6.8 Customer Age Analysis
-- =====================================================

SELECT
    cc_num,
    DATE_PART(
        'year',
        AGE(trans_date_trans_time::date, dob)
    ) AS customer_age,
    COUNT(*) AS total_transactions,
    SUM(amt) AS total_spent,
    ROUND(AVG(amt)::numeric, 2) AS average_transaction_amount
FROM credit_card_transactions
GROUP BY
    cc_num,
    customer_age
ORDER BY total_spent DESC
LIMIT 10;



-- =====================================================
-- 6.9 Customer Spending by Age Group
-- =====================================================

SELECT
    CASE
        WHEN DATE_PART('year', AGE(trans_date_trans_time::date, dob)) < 25
            THEN 'Under 25'
        WHEN DATE_PART('year', AGE(trans_date_trans_time::date, dob)) BETWEEN 25 AND 34
            THEN '25-34'
        WHEN DATE_PART('year', AGE(trans_date_trans_time::date, dob)) BETWEEN 35 AND 44
            THEN '35-44'
        WHEN DATE_PART('year', AGE(trans_date_trans_time::date, dob)) BETWEEN 45 AND 54
            THEN '45-54'
        WHEN DATE_PART('year', AGE(trans_date_trans_time::date, dob)) BETWEEN 55 AND 64
            THEN '55-64'
        ELSE '65+'
    END AS age_group,

    COUNT(*) AS total_transactions,
    COUNT(DISTINCT cc_num) AS unique_customers,
    SUM(amt) AS total_spent,
    ROUND(AVG(amt)::numeric, 2) AS average_transaction_amount

FROM credit_card_transactions

GROUP BY
    CASE
        WHEN DATE_PART('year', AGE(trans_date_trans_time::date, dob)) < 25
            THEN 'Under 25'
        WHEN DATE_PART('year', AGE(trans_date_trans_time::date, dob)) BETWEEN 25 AND 34
            THEN '25-34'
        WHEN DATE_PART('year', AGE(trans_date_trans_time::date, dob)) BETWEEN 35 AND 44
            THEN '35-44'
        WHEN DATE_PART('year', AGE(trans_date_trans_time::date, dob)) BETWEEN 45 AND 54
            THEN '45-54'
        WHEN DATE_PART('year', AGE(trans_date_trans_time::date, dob)) BETWEEN 55 AND 64
            THEN '55-64'
        ELSE '65+'
    END

ORDER BY total_spent DESC;



-- =====================================================
-- 7. CATEGORY ANALYSIS
-- =====================================================

-- 7.1 Category Transaction Summary
SELECT
    category,
    COUNT(*) AS total_transactions,
    COUNT(DISTINCT cc_num) AS unique_customers,
    SUM(amt) AS total_spent,
    ROUND(AVG(amt)::numeric, 2) AS average_transaction_amount
FROM credit_card_transactions
GROUP BY category
ORDER BY total_spent DESC;


-- 7.2 Top 10 Categories by Transaction Count
SELECT
    category,
    COUNT(*) AS total_transactions,
    COUNT(DISTINCT cc_num) AS unique_customers,
    SUM(amt) AS total_spent
FROM credit_card_transactions
GROUP BY category
ORDER BY total_transactions DESC
LIMIT 10;


-- 7.3 Top 10 Categories by Total Spending
SELECT
    category,
    COUNT(*) AS total_transactions,
    SUM(amt) AS total_spent,
    ROUND(AVG(amt)::numeric, 2) AS average_transaction_amount
FROM credit_card_transactions
GROUP BY category
ORDER BY total_spent DESC
LIMIT 10;


-- 7.4 Top 10 Categories by Average Transaction Amount
SELECT
    category,
    COUNT(*) AS total_transactions,
    SUM(amt) AS total_spent,
    ROUND(AVG(amt)::numeric, 2) AS average_transaction_amount
FROM credit_card_transactions
GROUP BY category
ORDER BY average_transaction_amount DESC
LIMIT 10;



-- 7.5 Category Customer Reach
SELECT
    category,
    COUNT(DISTINCT cc_num) AS unique_customers,
    COUNT(*) AS total_transactions,
    ROUND(AVG(amt)::numeric, 2) AS average_transaction_amount
FROM credit_card_transactions
GROUP BY category
ORDER BY unique_customers DESC;



-- 7.6 Category Spending per Customer
SELECT
    category,
    COUNT(DISTINCT cc_num) AS unique_customers,
    SUM(amt) AS total_spent,
    ROUND(
        (SUM(amt) / COUNT(DISTINCT cc_num))::numeric,
        2
    ) AS spending_per_customer
FROM credit_card_transactions
GROUP BY category
ORDER BY spending_per_customer DESC;






-- =====================================================
-- 8. MERCHANT ANALYSIS
-- =====================================================


-- =====================================================
-- 8.1 Merchant Transaction Summary
-- =====================================================

SELECT
    merchant,
    COUNT(*) AS total_transactions,
    COUNT(DISTINCT cc_num) AS unique_customers,
    SUM(amt) AS total_transaction_amount,
    ROUND(AVG(amt)::numeric, 2) AS average_transaction_amount
FROM credit_card_transactions
GROUP BY merchant
ORDER BY total_transaction_amount DESC;


-- =====================================================
-- 8.2 Top 10 Merchants by Transaction Count
-- =====================================================

SELECT
    merchant,
    COUNT(*) AS total_transactions,
    COUNT(DISTINCT cc_num) AS unique_customers,
    SUM(amt) AS total_transaction_amount
FROM credit_card_transactions
GROUP BY merchant
ORDER BY total_transactions DESC
LIMIT 10;


-- =====================================================
-- 8.3 Top 10 Merchants by Transaction Value
-- =====================================================

SELECT
    merchant,
    COUNT(*) AS total_transactions,
    COUNT(DISTINCT cc_num) AS unique_customers,
    SUM(amt) AS total_transaction_amount,
    ROUND(AVG(amt)::numeric, 2) AS average_transaction_amount
FROM credit_card_transactions
GROUP BY merchant
ORDER BY total_transaction_amount DESC
LIMIT 10;


-- =====================================================
-- 8.4 Top 10 Merchants by Average Transaction Amount
-- =====================================================

SELECT
    merchant,
    COUNT(*) AS total_transactions,
    SUM(amt) AS total_transaction_amount,
    ROUND(AVG(amt)::numeric, 2) AS average_transaction_amount
FROM credit_card_transactions
GROUP BY merchant
HAVING COUNT(*) >= 10
ORDER BY average_transaction_amount DESC
LIMIT 10;


-- =====================================================
-- 8.5 Merchant Customer Reach
-- =====================================================

SELECT
    merchant,
    COUNT(DISTINCT cc_num) AS unique_customers,
    COUNT(*) AS total_transactions,
    SUM(amt) AS total_transaction_amount
FROM credit_card_transactions
GROUP BY merchant
ORDER BY unique_customers DESC
LIMIT 10;


-- =====================================================
-- 8.6 Merchant Fraud Analysis
-- =====================================================

SELECT
    merchant,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    SUM(CASE WHEN is_fraud = 1 THEN amt ELSE 0 END) AS fraud_amount,
    ROUND(
        100.0 * SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS fraud_rate_percentage
FROM credit_card_transactions
GROUP BY merchant
HAVING COUNT(*) >= 10
ORDER BY fraud_transactions DESC
LIMIT 10;





-- =====================================================
-- 9. GEOGRAPHIC ANALYSIS
-- =====================================================


-- =====================================================
-- 9.1 State Transaction Summary
-- =====================================================

SELECT
    state,
    COUNT(*) AS total_transactions,
    COUNT(DISTINCT cc_num) AS unique_customers,
    SUM(amt) AS total_transaction_amount,
    ROUND(AVG(amt)::numeric, 2) AS average_transaction_amount
FROM credit_card_transactions
GROUP BY state
ORDER BY total_transaction_amount DESC;


-- =====================================================
-- 9.2 Top 10 States by Transaction Count
-- =====================================================

SELECT
    state,
    COUNT(*) AS total_transactions,
    COUNT(DISTINCT cc_num) AS unique_customers,
    SUM(amt) AS total_transaction_amount
FROM credit_card_transactions
GROUP BY state
ORDER BY total_transactions DESC
LIMIT 10;


-- =====================================================
-- 9.3 Top 10 States by Transaction Value
-- =====================================================

SELECT
    state,
    COUNT(*) AS total_transactions,
    SUM(amt) AS total_transaction_amount,
    ROUND(AVG(amt)::numeric, 2) AS average_transaction_amount
FROM credit_card_transactions
GROUP BY state
ORDER BY total_transaction_amount DESC
LIMIT 10;


-- =====================================================
-- 9.4 Top 10 States by Average Transaction Amount
-- =====================================================

SELECT
    state,
    COUNT(*) AS total_transactions,
    SUM(amt) AS total_transaction_amount,
    ROUND(AVG(amt)::numeric, 2) AS average_transaction_amount
FROM credit_card_transactions
GROUP BY state
HAVING COUNT(*) >= 100
ORDER BY average_transaction_amount DESC
LIMIT 10;


-- =====================================================
-- 9.5 Top 10 Cities by Transaction Activity
-- =====================================================

SELECT
    city,
    state,
    COUNT(*) AS total_transactions,
    COUNT(DISTINCT cc_num) AS unique_customers,
    SUM(amt) AS total_transaction_amount
FROM credit_card_transactions
GROUP BY city, state
ORDER BY total_transactions DESC
LIMIT 10;


-- =====================================================
-- 9.6 Top 10 Cities by Transaction Value
-- =====================================================

SELECT
    city,
    state,
    COUNT(*) AS total_transactions,
    SUM(amt) AS total_transaction_amount,
    ROUND(AVG(amt)::numeric, 2) AS average_transaction_amount
FROM credit_card_transactions
GROUP BY city, state
ORDER BY total_transaction_amount DESC
LIMIT 10;


-- =====================================================
-- 9.7 Fraud Analysis by State
-- =====================================================

SELECT
    state,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    SUM(CASE WHEN is_fraud = 1 THEN amt ELSE 0 END) AS fraud_amount,
    ROUND(
        100.0 * SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS fraud_rate_percentage
FROM credit_card_transactions
GROUP BY state
ORDER BY fraud_transactions DESC;


-- =====================================================
-- 9.8 Top 10 States by Fraud Rate
-- =====================================================

SELECT
    state,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    ROUND(
        100.0 * SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS fraud_rate_percentage
FROM credit_card_transactions
GROUP BY state
HAVING COUNT(*) >= 100
ORDER BY fraud_rate_percentage DESC
LIMIT 10;



-- =====================================================
-- 10. TIME / TREND ANALYSIS
-- =====================================================


-- =====================================================
-- 10.1 Yearly Transaction Summary
-- =====================================================

SELECT
    year,
    COUNT(*) AS total_transactions,
    SUM(amt) AS total_transaction_amount,
    ROUND(AVG(amt)::numeric, 2) AS average_transaction_amount
FROM credit_card_transactions
GROUP BY year
ORDER BY year;

-- =====================================================
-- 10.2 Monthly Transaction Trend
-- =====================================================

SELECT
    month,
    month_name,
    COUNT(*) AS total_transactions,
    SUM(amt) AS total_transaction_amount,
    ROUND(AVG(amt)::numeric, 2) AS average_transaction_amount
FROM credit_card_transactions
GROUP BY month, month_name
ORDER BY month;


-- =====================================================
-- 10.3 Year-Month Transaction Trend
-- =====================================================

SELECT
    year,
    month,
    month_name,
    COUNT(*) AS total_transactions,
    SUM(amt) AS total_transaction_amount,
    ROUND(AVG(amt)::numeric, 2) AS average_transaction_amount
FROM credit_card_transactions
GROUP BY year, month, month_name
ORDER BY year, month;


-- =====================================================
-- 10.4 Day-of-Week Analysis
-- =====================================================

SELECT
    EXTRACT(ISODOW FROM trans_date_trans_time) AS day_of_week,
    TO_CHAR(trans_date_trans_time, 'Day') AS day_name,
    COUNT(*) AS total_transactions,
    SUM(amt) AS total_transaction_amount,
    ROUND(AVG(amt)::numeric, 2) AS average_transaction_amount
FROM credit_card_transactions
GROUP BY
    EXTRACT(ISODOW FROM trans_date_trans_time),
    TO_CHAR(trans_date_trans_time, 'Day')
ORDER BY day_of_week;


-- =====================================================
-- 10.5 Hourly Transaction Analysis
-- =====================================================

SELECT
    hour,
    COUNT(*) AS total_transactions,
    SUM(amt) AS total_transaction_amount,
    ROUND(AVG(amt)::numeric, 2) AS average_transaction_amount
FROM credit_card_transactions
GROUP BY hour
ORDER BY hour;


-- =====================================================
-- 10.6 Peak Transaction Hours
-- =====================================================

SELECT
    hour,
    COUNT(*) AS total_transactions,
    SUM(amt) AS total_transaction_amount
FROM credit_card_transactions
GROUP BY hour
ORDER BY total_transactions DESC
LIMIT 10;


-- =====================================================
-- 10.7 Monthly Fraud Trend
-- =====================================================

SELECT
    year,
    month,
    month_name,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    ROUND(
        100.0 * SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS fraud_rate_percentage
FROM credit_card_transactions
GROUP BY year, month, month_name
ORDER BY year, month;


-- =====================================================
-- 10.8 Monthly Revenue Trend
-- =====================================================

SELECT
    year,
    month,
    month_name,
    SUM(amt) AS total_revenue,
    COUNT(*) AS total_transactions,
    ROUND(AVG(amt)::numeric, 2) AS average_transaction_amount
FROM credit_card_transactions
GROUP BY year, month, month_name
ORDER BY year, month;


-- =====================================================
-- 10.9 Year-over-Year Comparison
-- =====================================================

WITH yearly_summary AS (
    SELECT
        year,
        COUNT(*) AS total_transactions,
        SUM(amt) AS total_revenue
    FROM credit_card_transactions
    GROUP BY year
)

SELECT
    year,
    total_transactions,
    total_revenue,
    LAG(total_revenue) OVER (ORDER BY year) AS previous_year_revenue,
    ROUND(
        (
            (total_revenue - LAG(total_revenue) OVER (ORDER BY year))
            / NULLIF(LAG(total_revenue) OVER (ORDER BY year), 0)
            * 100
        )::numeric,
        2
    ) AS revenue_growth_percentage
FROM yearly_summary
ORDER BY year;





-- =====================================================
-- 11. ADVANCED SQL
-- =====================================================

-- 11.1 Customers Spending Above Average
SELECT
    cc_num,
    SUM(amt) AS total_spent
FROM credit_card_transactions
GROUP BY cc_num
HAVING SUM(amt) > (
    SELECT AVG(customer_total)
    FROM (
        SELECT
            cc_num,
            SUM(amt) AS customer_total
        FROM credit_card_transactions
        GROUP BY cc_num
    ) AS customer_spending
)
ORDER BY total_spent DESC;


-- =====================================================
-- 11.2 Correlated Subquery
-- =====================================================

-- Transactions greater than the customer's own average
SELECT
    t.cc_num,
    t.trans_num,
    t.trans_date_trans_time,
    t.amt
FROM credit_card_transactions AS t
WHERE t.amt > (
    SELECT AVG(t2.amt)
    FROM credit_card_transactions AS t2
    WHERE t2.cc_num = t.cc_num
)
ORDER BY t.amt DESC
LIMIT 20;



-- =====================================================
-- 11.3 CTE Business Problem
-- =====================================================

WITH customer_spending AS (
    SELECT
        cc_num,
        COUNT(*) AS total_transactions,
        SUM(amt) AS total_spent,
        ROUND(AVG(amt)::numeric, 2) AS average_transaction_amount
    FROM credit_card_transactions
    GROUP BY cc_num
)

SELECT
    cc_num,
    total_transactions,
    total_spent,
    average_transaction_amount
FROM customer_spending
ORDER BY total_spent DESC
LIMIT 10;


-- =====================================================
-- 11.4 RANK() - Merchant Ranking
-- =====================================================

SELECT
    merchant,
    total_transaction_amount,
    RANK() OVER (
        ORDER BY total_transaction_amount DESC
    ) AS merchant_rank
FROM (
    SELECT
        merchant,
        SUM(amt) AS total_transaction_amount
    FROM credit_card_transactions
    GROUP BY merchant
) AS merchant_summary
ORDER BY merchant_rank
LIMIT 10;



-- =====================================================
-- 11.5 ROW_NUMBER() - Merchant Ranking
-- =====================================================

SELECT
    merchant,
    total_transaction_amount,
    ROW_NUMBER() OVER (
        ORDER BY total_transaction_amount DESC
    ) AS row_number
FROM (
    SELECT
        merchant,
        SUM(amt) AS total_transaction_amount
    FROM credit_card_transactions
    GROUP BY merchant
) AS merchant_summary
ORDER BY row_number
LIMIT 10;



-- =====================================================
-- 11.6 Running Total
-- =====================================================

WITH monthly_revenue AS (
    SELECT
        year,
        month,
        month_name,
        SUM(amt) AS monthly_revenue
    FROM credit_card_transactions
    GROUP BY year, month, month_name
)

SELECT
    year,
    month,
    month_name,
    monthly_revenue,
    SUM(monthly_revenue) OVER (
        ORDER BY year, month
    ) AS running_total_revenue
FROM monthly_revenue
ORDER BY year, month;



-- =====================================================
-- 11.7 LAG() / LEAD() - Monthly Revenue Comparison
-- =====================================================

WITH monthly_revenue AS (
    SELECT
        year,
        month,
        month_name,
        SUM(amt) AS monthly_revenue
    FROM credit_card_transactions
    GROUP BY year, month, month_name
)

SELECT
    year,
    month,
    month_name,
    monthly_revenue,

    LAG(monthly_revenue) OVER (
        ORDER BY year, month
    ) AS previous_month_revenue,

    LEAD(monthly_revenue) OVER (
        ORDER BY year, month
    ) AS next_month_revenue

FROM monthly_revenue
ORDER BY year, month;




-- =====================================================
-- 12. SQL VIEWS
-- =====================================================

-- 12.1 Customer Summary View

CREATE OR REPLACE VIEW customer_summary AS
SELECT
    cc_num,
    COUNT(*) AS total_transactions,
    SUM(amt) AS total_spent,
    ROUND(AVG(amt)::numeric, 2) AS average_transaction_amount,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_transactions
FROM credit_card_transactions
GROUP BY cc_num;

SELECT *
FROM customer_summary
ORDER BY total_spent DESC
LIMIT 10;



-- =====================================================
-- 12.2 Monthly Transaction View
-- =====================================================

CREATE OR REPLACE VIEW monthly_transaction_summary AS
SELECT
    year,
    month,
    month_name,
    COUNT(*) AS total_transactions,
    SUM(amt) AS total_transaction_amount,
    ROUND(AVG(amt)::numeric, 2) AS average_transaction_amount,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    SUM(CASE WHEN is_fraud = 1 THEN amt ELSE 0 END) AS fraud_amount
FROM credit_card_transactions
GROUP BY
    year,
    month,
    month_name;

SELECT *
FROM monthly_transaction_summary
ORDER BY year, month;



-- =====================================================
-- 13. MATERIALIZED VIEW
-- =====================================================

-- 13.1 Monthly Transaction Summary

CREATE MATERIALIZED VIEW monthly_transaction_summary_mv AS
SELECT
    year,
    month,
    month_name,
    COUNT(*) AS total_transactions,
    SUM(amt) AS total_transaction_amount,
    ROUND(AVG(amt)::numeric, 2) AS average_transaction_amount,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    SUM(CASE WHEN is_fraud = 1 THEN amt ELSE 0 END) AS fraud_amount
FROM credit_card_transactions
GROUP BY
    year,
    month,
    month_name;

SELECT *
FROM monthly_transaction_summary_mv
ORDER BY year, month;




-- =====================================================
-- 14. INDEXING & QUERY PERFORMANCE
-- =====================================================

-- 14.1 Create Index on Transaction Date

CREATE INDEX idx_credit_card_transactions_date
ON credit_card_transactions(trans_date_trans_time);

-- 14.2 EXPLAIN Query Plan

EXPLAIN
SELECT *
FROM credit_card_transactions
WHERE trans_date_trans_time >= '2020-01-01';


-- 14.3 EXPLAIN ANALYZE Query Performance

EXPLAIN ANALYZE
SELECT *
FROM credit_card_transactions
WHERE trans_date_trans_time >= '2020-01-01';