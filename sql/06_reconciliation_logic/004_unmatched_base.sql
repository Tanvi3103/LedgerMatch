USE LedgerMatchDB;
GO

-- Bank txns not already matched
SELECT b.*
FROM BankTransactions b
LEFT JOIN ReconciliationResult r
    ON b.BankTxnId = r.BankTxnId
WHERE r.BankTxnId IS NULL;
GO
