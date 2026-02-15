/*
 Project: LedgerMatch
 Purpose: Create Internal Transactions Table
*/

USE LedgerMatchDB;
GO

IF OBJECT_ID('InternalTransactions', 'U') IS NOT NULL
    DROP TABLE InternalTransactions;
GO

CREATE TABLE InternalTransactions (
    InternalTxnId BIGINT IDENTITY PRIMARY KEY,
    TxnDate DATE NOT NULL,
    Amount DECIMAL(18,2) NOT NULL,
    ReferenceNo VARCHAR(50),
    Module VARCHAR(50),
    CurrencyCode CHAR(3) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO
-- Verify table creation
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'InternalTransactions';
GO
-- End of File