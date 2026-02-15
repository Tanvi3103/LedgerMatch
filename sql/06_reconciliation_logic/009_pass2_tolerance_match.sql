USE LedgerMatchDB;
GO

DECLARE @ReconRunId INT = 1;
DECLARE @Tolerance DECIMAL(18,2) = 1.00; -- adjustable tolerance

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
    'MATCHED',
    'TOLERANCE_MATCH'
FROM BankTransactions b
INNER JOIN InternalTransactions i
    ON b.ReferenceNo = i.ReferenceNo
    AND b.TxnDate = i.TxnDate
    AND b.CurrencyCode = i.CurrencyCode
    AND ABS(b.Amount - i.Amount) <= @Tolerance
LEFT JOIN ReconciliationResult r
    ON b.BankTxnId = r.BankTxnId
WHERE r.BankTxnId IS NULL;
GO
