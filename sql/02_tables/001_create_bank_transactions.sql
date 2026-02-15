/*
 Project: LedgerMatch
 Purpose: Create Bank Transactions Table
*/

USE LedgerMatchDB;
GO

IF OBJECT_ID('BankTransactions', 'U') IS NOT NULL
    DROP TABLE BankTransactions;
GO

CREATE TABLE BankTransactions (
    BankTxnId BIGINT IDENTITY PRIMARY KEY,
    TxnDate DATE NOT NULL,
    Amount DECIMAL(18,2) NOT NULL,
    ReferenceNo VARCHAR(50),
    Description VARCHAR(255),
    CurrencyCode CHAR(3) NOT NULL,
    SourceFile VARCHAR(100),
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO
-- Verify table creation
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'BankTransactions';
GO
-- End of File