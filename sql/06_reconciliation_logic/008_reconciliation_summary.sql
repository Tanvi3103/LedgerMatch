USE LedgerMatchDB;
GO

SELECT
    MatchStatus,
    MatchRule,
    COUNT(*) AS TxnCount
FROM ReconciliationResult
GROUP BY MatchStatus, MatchRule
ORDER BY MatchStatus, MatchRule;
-- GO