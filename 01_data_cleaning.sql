-- Step 1: Initial Profiling & Duplication Audit

SELECT *
FROM budgetwise_finance_dataset;

SELECT
	COUNT(*) AS total_rows,
    COUNT(DISTINCT transaction_id) AS unique_users
FROM budgetwise_finance_dataset;

WITH DuplicateCheck AS (
	SELECT *,
	ROW_NUMBER() OVER(
    PARTITION BY transaction_id, user_id, `date`, transaction_type, category, amount, payment_mode, location, notes) AS row_num
    FROM budgetwise_finance_dataset)
    SELECT *
    FROM DuplicateCheck 
    WHERE row_num > 1;

CREATE TABLE `finance_dataset_staging` (
  `transaction_id` text,
  `user_id` text,
  `date` text,
  `transaction_type` text,
  `category` text,
  `amount` int DEFAULT NULL,
  `payment_mode` text,
  `location` text,
  `notes` text,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO finance_dataset_staging
SELECT *,
ROW_NUMBER() OVER(
    PARTITION BY transaction_id, user_id, `date`, transaction_type, category, amount, payment_mode, location, notes) AS row_num
    FROM budgetwise_finance_dataset;

SELECT *
FROM finance_dataset_staging;

DELETE
FROM finance_dataset_staging
WHERE row_num > 1;

SELECT *
FROM finance_dataset_staging
ORDER BY transaction_id;

-- Step 2: Cleaning Text Encoding & Currency Noise

SELECT 
	amount AS raw_amount,
		REGEXP_REPLACE(amount, '[^0-9.]', '') 
	 AS cleaned_amount
FROM finance_dataset_staging;

UPDATE finance_dataset_staging
SET amount = REGEXP_REPLACE(amount, '[^0-9.]', '');

-- Step 3: Standardizing Inconsistent Dates

SELECT *
FROM finance_dataset_staging;

SELECT
	`date`,
    CASE
	WHEN `date` REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}' THEN `date`
	WHEN `date` LIKE '%/%/%' THEN  STR_TO_DATE(`date`, '%m/%d/%Y')
	WHEN `date` REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}' THEN DATE_FORMAT(STR_TO_DATE(`date`, '%d-%m-%Y'), '%Y-%m-%d')
	WHEN `date` REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{2}$' THEN DATE_FORMAT(STR_TO_DATE(`date`, '%d-%m-%Y'), '%Y-%m-%d')
	ELSE NULL
	END AS cleaned_date
FROM finance_dataset_staging;

UPDATE finance_dataset_staging
SET `date` = CASE
	WHEN `date` REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}' THEN `date`
	WHEN `date` LIKE '%/%/%' THEN  STR_TO_DATE(`date`, '%m/%d/%Y')
	WHEN `date` REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}' THEN DATE_FORMAT(STR_TO_DATE(`date`, '%d-%m-%Y'), '%Y-%m-%d')
	WHEN `date` REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{2}$' THEN DATE_FORMAT(STR_TO_DATE(`date`, '%d-%m-%Y'), '%Y-%m-%d')
	ELSE NULL
END;

ALTER TABLE finance_dataset_staging
MODIFY COLUMN `date` DATE;

-- Step 4: String Standardization & Typo Corrections 

SELECT *
FROM finance_dataset_staging;

SELECT DISTINCT category
FROM finance_dataset_staging;

SELECT category
FROM finance_dataset_staging
WHERE category LIKE 'Saving%' OR 
	category LIKE 'Other%' OR 
    category LIKE 'he%' OR 
    category LIKE 'Tra%' OR 
    category LIKE 'fo%' OR 
    category LIKE 'r%' OR 
    category LIKE 'ent%' OR 
    category LIKE 'ut%' OR 
	category LIKE 'edu%'
ORDER BY category ASC;

UPDATE finance_dataset_staging
SET category = 'Savings'
WHERE category LIKE 'Saving%';

UPDATE finance_dataset_staging
SET category = 'Others'
WHERE category LIKE 'Other%';

UPDATE finance_dataset_staging
SET category = 'Health'
WHERE category LIKE 'he%';

UPDATE finance_dataset_staging
SET category = 'Travel'
WHERE category LIKE 'Tra%';

UPDATE finance_dataset_staging
SET category = 'Food'
WHERE category LIKE 'fo%';

UPDATE finance_dataset_staging
SET category = 'Rent'
WHERE category LIKE 'r%';

UPDATE finance_dataset_staging
SET category = 'Entertainment'
WHERE category LIKE 'ent%';

UPDATE finance_dataset_staging
SET category = 'Utilities'
WHERE category LIKE 'ut%';

UPDATE finance_dataset_staging
SET category = 'Education'
WHERE category LIKE 'edu%';

SELECT *
FROM finance_dataset_staging;

SELECT DISTINCT payment_mode
FROM finance_dataset_staging;

SELECT payment_mode
FROM finance_dataset_staging
WHERE payment_mode LIKE 'U%'OR 
	  payment_mode LIKE '%d' OR 
      payment_mode LIKE 'bank%' OR 
      payment_mode LIKE '%sh'
ORDER BY payment_mode ASC;

UPDATE finance_dataset_staging
SET payment_mode = 'Unified Payment'
WHERE payment_mode LIKE 'U%';

UPDATE finance_dataset_staging
SET payment_mode = 'Card'
WHERE payment_mode LIKE '%d';

UPDATE finance_dataset_staging
SET payment_mode = 'Bank Transfer'
WHERE payment_mode LIKE 'bank%';

UPDATE finance_dataset_staging
SET payment_mode = 'Cash'
WHERE payment_mode LIKE '%sh';

UPDATE finance_dataset_staging
SET location = CONCAT(UPPER(LEFT(location, 1)), LOWER(SUBSTRING(location, 2)));

SELECT DISTINCT location
FROM finance_dataset_staging
ORDER BY location ASC;

UPDATE finance_dataset_staging
SET location = 'Ahmedabad'
WHERE location LIKE 'Ahm%';

UPDATE finance_dataset_staging
SET location = 'Bangalore'
WHERE location LIKE 'Ban%';

UPDATE finance_dataset_staging
SET location = 'Chennai'
WHERE location LIKE 'Che%';

UPDATE finance_dataset_staging
SET location = 'Delhi'
WHERE location LIKE 'Del%';

UPDATE finance_dataset_staging
SET location = 'Hyderabad'
WHERE location LIKE 'Hyd%';

UPDATE finance_dataset_staging
SET location = 'Jaipur'
WHERE location LIKE 'Jai%';

UPDATE finance_dataset_staging
SET location = 'Kolkata'
WHERE location LIKE 'Kol%';

UPDATE finance_dataset_staging
SET location = 'Lucknow'
WHERE location LIKE 'Luc%';

UPDATE finance_dataset_staging
SET location = 'Mumbai'
WHERE location LIKE 'Mum%';

UPDATE finance_dataset_staging
SET location = 'Pune'
WHERE location LIKE 'Pun%';

UPDATE finance_dataset_staging
SET location = NULL
WHERE location LIKE 'N/a%';

SELECT *
FROM finance_dataset_staging;

UPDATE finance_dataset_staging
SET notes = CONCAT(UPPER(LEFT(notes, 1)), LOWER(SUBSTRING(notes, 2)));

SELECT DISTINCT notes
FROM finance_dataset_staging;

UPDATE finance_dataset_staging
SET notes = NULL 
WHERE notes = '!!!' OR 
notes = 'N/a' OR 
notes = '...' OR 
notes = 'Xyz123' OR 
notes = 'Asdfgh';


-- Step 5: Handling Missing Values (NULL Imputation)

SELECT *
FROM finance_dataset_staging;

UPDATE finance_dataset_staging
SET category = NULL 
WHERE category = '';

UPDATE finance_dataset_staging
SET payment_mode = NULL 
WHERE payment_mode = '';

UPDATE finance_dataset_staging
SET notes = NULL 
WHERE notes = '';

UPDATE finance_dataset_staging
SET location = NULL 
WHERE location = '';

ALTER TABLE finance_dataset_staging
DROP COLUMN row_num;






