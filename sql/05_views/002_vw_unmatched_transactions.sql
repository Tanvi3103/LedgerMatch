USE LedgerMatchDB;
GO

CREATE OR ALTER VIEW vw_UnmatchedTransactions AS
SELECT
    r.ReconRunId,
    r.MatchStatus,
    r.MatchRule,
    b.BankTxnId,
    b.ReferenceNo AS BankReference,
    b.Amount AS BankAmount,
    i.InternalTxnId,
    i.ReferenceNo AS InternalReference,
    i.Amount AS InternalAmount
FROM ReconciliationResult r
LEFT JOIN BankTransactions b
    ON r.BankTxnId = b.BankTxnId
LEFT JOIN InternalTransactions i
    ON r.InternalTxnId = i.InternalTxnId
WHERE r.MatchStatus IN ('UNMATCHED', 'MISMATCH');
GO
