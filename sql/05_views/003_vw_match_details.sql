USE LedgerMatchDB;
GO

CREATE OR ALTER VIEW vw_MatchDetails AS
SELECT
    r.ReconRunId,
    r.MatchStatus,
    r.MatchRule,
    b.ReferenceNo,
    b.Amount AS BankAmount,
    i.Amount AS InternalAmount,
    b.TxnDate,
    b.CurrencyCode
FROM ReconciliationResult r
LEFT JOIN BankTransactions b
    ON r.BankTxnId = b.BankTxnId
LEFT JOIN InternalTransactions i
    ON r.InternalTxnId = i.InternalTxnId;
GO
