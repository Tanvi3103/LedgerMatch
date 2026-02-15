/*
 Project: LedgerMatch
 Purpose: Track reconciliation runs
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
-- Verify table creation
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'ReconciliationRun';
GO
-- End of File