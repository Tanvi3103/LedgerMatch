USE LedgerMatchDB;
GO

INSERT INTO InternalTransactions
(TxnDate, Amount, ReferenceNo, Module, CurrencyCode)
VALUES
('2024-12-01', 15000.00, 'UTR1001', 'AccountsReceivable', 'INR'),
('2024-12-02', 2500.00,  'UTR1002', 'Expense', 'INR'),
('2024-12-03', 7200.00,  'UTR1003', 'AccountsReceivable', 'INR'),
('2024-12-04', 4800.00,  'UTR1004', 'AccountsReceivable', 'INR'),
('2024-12-06', 3000.00,  'UTR9999', 'Expense', 'INR');
GO
-- End of File