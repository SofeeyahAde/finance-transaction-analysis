# Finance Transaction Analysis

Analysis of financial transactions, expenditure, income, payment methods, and geographic transaction patterns using SQL.

## Project Overview

This project analyzes financial transaction data to understand spending and income patterns across transaction categories, payment methods, locations, and transaction types.

The analysis focuses on identifying the categories and locations associated with the highest expenses and income, understanding payment method usage, and comparing expenditure with income.

## Dataset

The dataset contains approximately **11,000 unique transactions** recorded between **2021 and 2024**, involving **150 unique users**.

Transaction amounts range from **0 to approximately 999 million**.

The dataset includes information relating to:

* Transaction amounts
* Transaction types
* Categories
* Payment methods
* Locations
* Users
* Transaction dates

## Analytical Questions

1. Which categories account for the highest total expenses and income?
2. Which payment mode is used most frequently, and what type of transaction is it primarily used for?
3. How does total expenditure compare with total income?
4. Which location has the highest total expenses and highest total income?

## Tools Used

* **MySQL** — data cleaning, querying, aggregation, and exploratory analysis

## Analysis

SQL queries were used to analyze:

* Expenses and income by category
* Payment method frequency
* Transaction types associated with payment methods
* Expenditure versus income
* Expenses and income by location

## Key Findings

### Category Performance

* **Revenues** recorded the highest total expense at approximately **17 billion**.
* **Freelance** generated the highest total income at approximately **36 million**.

### Payment Methods

* **Bank transfer** was the most frequently used payment method.
* **Expense** was the most common transaction type associated with bank transfers, accounting for approximately **2,416 transactions**.

### Expenditure vs Income

* Expenses accounted for approximately **85%** of all transactions.
* Income transactions accounted for approximately **15%**.

### Geographic Performance

* **Mumbai** recorded the highest total expenses at approximately **8 billion**.
* **Jaipur** recorded the highest total income at approximately **13 million**.

## Project Files

The repository contains the SQL scripts used for data cleaning and exploratory analysis.

## Outcome

The analysis provided insight into spending and income patterns across transaction categories, payment methods, and locations, highlighting the substantially higher share of expense transactions within the dataset.

## Key Skills Demonstrated

* SQL data analysis
* Data cleaning
* Aggregation
* Filtering and grouping
* Transaction analysis
* Financial data analysis
* Comparative analysis
* Insight generation
