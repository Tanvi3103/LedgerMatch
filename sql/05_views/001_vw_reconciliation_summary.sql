USE LedgerMatchDB;
GO

CREATE OR ALTER VIEW vw_ReconciliationSummary AS
SELECT
    r.ReconRunId,
    r.MatchStatus,
    r.MatchRule,
    COUNT(*) AS TransactionCount,
    SUM(COALESCE(b.Amount, i.Amount)) AS TotalAmount
FROM ReconciliationResult r
LEFT JOIN BankTransactions b
    ON r.BankTxnId = b.BankTxnId
LEFT JOIN InternalTransactions i
    ON r.InternalTxnId = i.InternalTxnId
GROUP BY
    r.ReconRunId,
    r.MatchStatus,
    r.MatchRule;
GO
