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
    b.BankTxnId,
    NULL,
    'UNMATCHED',
    'BANK_ONLY'
FROM BankTransactions b
LEFT JOIN InternalTransactions i
    ON b.ReferenceNo = i.ReferenceNo
LEFT JOIN ReconciliationResult r
    ON b.BankTxnId = r.BankTxnId
WHERE i.InternalTxnId IS NULL
  AND r.BankTxnId IS NULL;
GO
-- End of File