# Data Warehouse Project

Data Engineering Test in ID/X Partners 

Creating a Data Warehouse and Stored Procedure for one of the client IDs/X Partners
Using SQL and Talend

Data Warehouse from various different sources stored within their system. Some of these data sources include:

transaction_excel (Excel file)
transaction_csv (CSV file)
transaction_db (SQL Server Database)
account (SQL Server Database)
customer (SQL Server Database)
branch (SQL Server Database)
city (SQL Server Database)
state (SQL Server Database)

With The Challenge As a Data Engineer, tasks include:

Database Setup:

Create a new database named DWH.
Create three dimension tables: DimAccount, DimCustomer, DimBranch.
Create one fact table: FactTransaction.
Define primary keys and foreign keys for each table.
ETL Job for Dimension Tables:

Use Talend to transfer data from the source to DimAccount, DimBranch, and DimCustomer tables.
Format data in DimCustomer as follows: CustomerID, CustomerName, Address, CityName, StateName, Age, Gender, Email. Convert all data to uppercase except CustomerID, Age, and Email.
ETL Job for Fact Table:

Merge transaction data from transaction_excel, transaction_csv, and transaction_db into FactTransaction.
Ensure no duplicate rows in FactTransaction.
Stored Procedures:

Create a Stored Procedure named DailyTransaction.
Parameters: start_date and end_date.
Calculate the number of transactions and their total amounts each day.
Display Date, TotalTransactions, TotalAmount for the specified date range.




