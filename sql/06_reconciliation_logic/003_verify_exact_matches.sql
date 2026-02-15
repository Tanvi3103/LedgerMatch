USE LedgerMatchDB;
GO

SELECT *
FROM ReconciliationResult
WHERE MatchStatus = 'MATCHED';
