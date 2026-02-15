USE LedgerMatchDB;
GO

DECLARE @ReconRunId INT = 1;

INSERT INTO ReconciliationResult
(
    ReconRunId,
    BankTxnId,
    InternalTxnId,
    MatchStatus,
    MatchRule
)
SELECT
    @ReconRunId,
    NULL,
    i.InternalTxnId,
    'UNMATCHED',
    'INTERNAL_ONLY'
FROM InternalTransactions i
LEFT JOIN BankTransactions b
    ON b.ReferenceNo = i.ReferenceNo
LEFT JOIN ReconciliationResult r
    ON i.InternalTxnId = r.InternalTxnId
WHERE b.BankTxnId IS NULL
  AND r.InternalTxnId IS NULL;
GO
-- End of File