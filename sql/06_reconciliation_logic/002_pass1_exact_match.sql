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
    'MATCHED',
    'EXACT_MATCH'
FROM BankTransactions b
INNER JOIN InternalTransactions i
    ON b.ReferenceNo = i.ReferenceNo
    AND b.TxnDate = i.TxnDate
    AND b.Amount = i.Amount
    AND b.CurrencyCode = i.CurrencyCode;
GO
-- End of File