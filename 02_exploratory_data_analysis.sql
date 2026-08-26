SELECT *
FROM finance_dataset_staging;

SELECT COUNT(DISTINCT transaction_id)
FROM finance_dataset_staging;
-- 11,106 unique transactions

SELECT COUNT(DISTINCT user_id)
FROM finance_dataset_staging;
-- 150 unique users

SELECT MAX(amount), MIN(amount)
FROM finance_dataset_staging;
-- Max amount: 999,999,999 and Min amount: 0

SELECT MAX(`date`), MIN(`date`)
FROM finance_dataset_staging;
-- Max date: 2024-12-31 and Min date: 2021-01-01

SELECT DISTINCT category
FROM finance_dataset_staging;
-- Unique categories: Savings, Others, Health, Travel, Freelance, Food, Rent, Entertainment, Utilities, Education, Salary, Investment, Bonus, Misc.

SELECT DISTINCT location
FROM finance_dataset_staging;
-- Unique locations: Ahmedabad, Lucknow, Mumbai, Jaipur, Delhi, Hyderabad, Chennai, Bangalore, Pune, Kolkata.

SELECT DISTINCT payment_mode
FROM finance_dataset_staging;
-- Unique payment mode: Unified Payment, Bank Transfer, Card, Cash.


-- Question 1. Which Categories account for the highest total expense and income?
WITH category_totals AS (
	SELECT 
		transaction_type,
		category,
		SUM(amount) AS total
	FROM finance_dataset_staging
	GROUP BY transaction_type, category),
ranked_categories AS (
	SELECT 
    transaction_type,
    category,
    total,
    ROW_NUMBER() OVER (
		PARTITION BY
transaction_type
		ORDER BY total DESC
        ) AS ranking
	FROM category_totals
)
SELECT 
	transaction_type,
    category,
    total
FROM ranked_categories
WHERE ranking = 1;

-- Finding: Rent recorded the highest total expense with a total of 17,040,095,811 while Freelance recorded the highest total income with a total of 26,206,693.

-- Question 2. Which Payment Mode is used most frequently and what transaction type is it primarily used for?
SELECT 
	transaction_type,
	payment_mode,
	COUNT(transaction_id) AS mode_count
FROM finance_dataset_staging
GROUP BY payment_mode, transaction_type
ORDER BY mode_count DESC
LIMIT 1;

-- Finding: Bank Transfer is recorded as the most frequently used Payment Mode with a transaction type combination which is expense with 2,416 counts.

-- Question 3. What proportion of transactions are expenses versus income?
WITH transaction_counts AS (
	SELECT
		transaction_type,
		COUNT(transaction_id) AS count
	FROM finance_dataset_staging
	GROUP BY transaction_type)
SELECT 
	transaction_type,
    count,
    count * 100.0 /
		SUM(count)
OVER () AS percentage
FROM transaction_counts;

-- Findings: Approximately 85% of recorded transactions are expenses, while 15% are income transactions.

-- Question 4. Which Locations have the highest total expenses & highest total income?
WITH location_totals AS (
	SELECT 
		transaction_type,
		location,
		SUM(amount) AS total
	FROM finance_dataset_staging
	GROUP BY transaction_type, location),
ranked_locations AS (
	SELECT 
    transaction_type,
    location,
    total,
    ROW_NUMBER() OVER (
		PARTITION BY
transaction_type
		ORDER BY total DESC
        ) AS ranking
	FROM location_totals
)
SELECT 
	transaction_type,
    location,
    total
FROM ranked_locations
WHERE ranking = 1;

-- Findings: Mumbai is recorded as the location with the highest total expense of 8,012,548,315 
--          while Jaipur is recorded as the location with the highest total income of 13,019,703.




