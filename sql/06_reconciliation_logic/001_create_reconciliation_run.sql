USE LedgerMatchDB;
GO

INSERT INTO ReconciliationRun (ReconDate, Status)
VALUES (CAST(GETDATE() AS DATE), 'IN_PROGRESS');
GO

SELECT TOP 1 ReconRunId
FROM ReconciliationRun
ORDER BY ReconRunId DESC;
GO
-- End of File