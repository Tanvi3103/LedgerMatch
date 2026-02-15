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
    i.InternalTxnId,
    'MISMATCH',
    'AMOUNT_MISMATCH'
FROM BankTransactions b
INNER JOIN InternalTransactions i
    ON b.ReferenceNo = i.ReferenceNo
    AND b.TxnDate = i.TxnDate
    AND b.CurrencyCode = i.CurrencyCode
    AND b.Amount <> i.Amount
LEFT JOIN ReconciliationResult r
    ON b.BankTxnId = r.BankTxnId
WHERE r.BankTxnId IS NULL;
GO
-- End of File