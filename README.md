# Sales Analysis Using SQL and Python

This repository contains Python projects that showcase my data analysis skills. Below are the details of each project included in this repository.

### Overview
This project demonstrates my ability to perform data analysis and cleaning using Python and SQL. The primary focus is on analyzing retail order data to extract meaningful insights and load the cleaned data into an SQL database.

### Files
- `orders data analysis.py`
- `sql_code.sql`

### Details
1. **Data Acquisition and Preparation**:
    - Downloaded the retail order dataset from Kaggle.
    - Extracted the dataset from a ZIP file.
    - Loaded the data into a Pandas DataFrame and handled null values.

2. **Data Cleaning**:
    - Displayed unique values in the 'Ship Mode' column to check for consistency and data quality.
    - Cleaned column names by making them lowercase and replacing spaces with underscores.
    - Derived new columns for discount, sale price, and profit.
    - Converted the 'order_date' column to datetime format.
    - Dropped unnecessary columns to optimize the dataset.

3. **Data Loading**:
    - Loaded the cleaned data into an SQL Server database using SQLAlchemy.
    - Exported the cleaned data to a new CSV file for further analysis or reporting.

### Highlights
- **Pandas**: Used for data manipulation and cleaning.
- **SQLAlchemy**: Used for loading data into an SQL Server database.
- **Data Quality Checks**: Ensured data consistency and accuracy before loading into the database.

### SQL Code
The `sql_code.sql` file contains SQL scripts used for querying and analyzing the data within the SQL Server database. The scripts include creating tables, inserting data, and performing various analysis queries.

---

Thank you for reviewing my projects! I look forward to connecting with you and discussing how I can contribute to your team.
