USE LedgerMatchDB;
GO
SELECT * FROM BankTransactions ORDER BY TxnDate;
SELECT * FROM InternalTransactions ORDER BY TxnDate;
