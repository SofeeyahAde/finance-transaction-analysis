# Finance Transaction Analysis
SQL analysis of financial transactions, expenses, income, payment methods, and geographic transaction patterns.
## Project Overview
This project analyzes financial transaction data to examine spending and income patterns, payment method usage, transaction types, and geographic differences in financial activity. The analysis focuses on identifying the categories and locations associated with the highest expenses and income and comparing the distribution of expenditure and income transactions.
## Dataset
The dataset contains approximately 11,000 unique transactions involving 150 unique users from 2021 to 2024.
Transaction amounts range from 0 to approximately 999 million.
## Analytical Questions
1. Which categories account for the highest total expenses and income?
2. Which payment mode is used most frequently, and what type of transaction is it primarily used for?
3. How does total expenditure compare with total income?
4. Which location has the highest total expenses and highest total income?
## Tools Used
- MySQL — data cleaning, transformation, querying, and exploratory data analysis
## Analysis Approach
SQL was used to explore transaction patterns, aggregate expenses and income, compare payment methods and transaction types, and identify locations with the highest financial activity.
Aggregation, filtering, grouping, and analytical SQL techniques were used to answer the project's questions.
## Key Findings
- The dataset contains approximately 11,000 unique transactions involving 150 unique users from 2021 to 2024.
- Transaction amounts ranged from 0 to approximately 999 million.
- Rent recorded the highest total expense at approximately 17 billion.
- Freelance generated the highest total income at approximately 36 million.
- Bank Transfer was the most frequently used payment method, with Expense as its most common transaction type, accounting for 2,416 transactions.
- Expenses accounted for approximately 85% of all transactions, compared with 15% for income transactions.
- Mumbai recorded the highest total expense at approximately 8 billion.
- Jaipur recorded the highest total income at approximately 13 million.
## Project Files
#### Data Cleaning SQL
Contains the SQL queries used to inspect, clean, and prepare the financial transaction data.
#### Exploratory Data Analysis SQL
Contains the SQL queries used to analyze the dataset and answer the project's analytical questions.
## Outcome
The analysis identified differences between expenditure and income activity, highlighted the most frequently used payment method and transaction type, and identified the locations associated with the highest expenses and income.
The project demonstrates the use of SQL to clean, aggregate, investigate, and derive insights from transactional data.
