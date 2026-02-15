/*
 Project: LedgerMatch
 Purpose: Store reconciliation results
*/

USE LedgerMatchDB;
GO
IF OBJECT_ID('ReconciliationRun', 'U') IS NOT NULL
    DROP TABLE ReconciliationRun;
GO

CREATE TABLE ReconciliationRun (
    ReconRunId INT IDENTITY PRIMARY KEY,
    ReconDate DATE NOT NULL,
    StartedAt DATETIME DEFAULT GETDATE(),
    CompletedAt DATETIME NULL,
    Status VARCHAR(20) DEFAULT 'IN_PROGRESS'
);
GO


IF OBJECT_ID('ReconciliationResult', 'U') IS NOT NULL
    DROP TABLE ReconciliationResult;
GO

CREATE TABLE ReconciliationResult (
    ReconResultId BIGINT IDENTITY PRIMARY KEY,
    ReconRunId INT NOT NULL,
    BankTxnId BIGINT NULL,
    InternalTxnId BIGINT NULL,
    MatchStatus VARCHAR(30) NOT NULL,
    MatchRule VARCHAR(50),
    CreatedAt DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Recon_Run FOREIGN KEY (ReconRunId)
        REFERENCES ReconciliationRun(ReconRunId)
);
GO
-- Verify table creation
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'ReconciliationResult';
GO