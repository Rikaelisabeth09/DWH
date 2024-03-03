CREATE DATABASE DWH;

USE DWH;

-- Dimension Table

CREATE TABLE DimCustomer (
	CustomerId integer not null,
	CustomerName varchar(50),
	Address varchar(MAX),
	CityName varchar(50),
	StateName varchar(50),
	Age varchar(3),
	Gender varchar(10),
	Email varchar(50),
	CONSTRAINT PKCustomer PRIMARY KEY (CustomerId)
);

CREATE TABLE DimBranch (
	BranchId integer not null,
	BranchName varchar(50),
	BrachLocation varchar(50),
	CONSTRAINT PKBranch PRIMARY KEY (BranchId)
);

CREATE TABLE DimAccount (
	AccountId integer not null,
	CustomerId integer,
	AccountType varchar(10),
	Balance integer,
	DateOpened datetime2(0),
	Status varchar(10)
	CONSTRAINT PKAccount PRIMARY KEY (AccountId),
	CONSTRAINT FKCostumerId FOREIGN KEY (CustomerId) REFERENCES DimCustomer(CustomerId)
);

CREATE TABLE FactTransaction1 (
	TransactionId integer not null,
	AccountId integer,
	TransactionDate datetime2(0),
	Amount integer,
	TransactionType varchar(50),
	BranchId integer,
	CONSTRAINT PKTransactionId PRIMARY KEY (TransactionId)
);


SELECT * FROM DimCustomer
SELECT * FROM DimBranch
SELECT * FROM DimAccount
SELECT * FROM FactTransaction1

--- Make A Daily Transaction
CREATE PROCEDURE DailyTransaction
    @start_date DATE,
    @end_date DATE
AS
BEGIN
    SELECT 
        CAST(TransactionDate AS DATE) AS Date,
        COUNT(*) AS TotalTransactions,
        SUM(Amount) AS TotalAmount
    FROM FactTransaction1
    WHERE TransactionDate BETWEEN @start_date AND @end_date
    GROUP BY CAST(TransactionDate AS DATE)
    ORDER BY CAST(TransactionDate AS DATE);
END;


EXEC DailyTransaction @start_date = '2024-01-18', @end_date = '2024-01-21'

--- Make A Balance Per Customer 
CREATE PROCEDURE BalancePerCustomer
   @name varchar(50)
AS
BEGIN
    SELECT
        c.CustomerName,
        a.AccountType,
        a.Balance,
        a.Balance - ISNULL(SUM(CASE WHEN t.TransactionType = 'Deposit' THEN t.Amount ELSE -t.Amount END), 0) AS CurrentBalance
    FROM
        DimCustomer c
    INNER JOIN
        DimAccount a ON c.CustomerId = a.CustomerId
    LEFT JOIN
        FactTransaction1 t ON a.AccountId = t.AccountId
    WHERE
        UPPER(c.CustomerName) = UPPER(@name)
        AND a.Status = 'Active'
    GROUP BY
        c.CustomerName,
        a.AccountType,
        a.Balance;
END;

EXEC BalancePerCustomer @name = 'SHELLY JUWITA';




