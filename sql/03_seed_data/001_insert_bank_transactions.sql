USE LedgerMatchDB;
GO

INSERT INTO BankTransactions
(TxnDate, Amount, ReferenceNo, Description, CurrencyCode, SourceFile)
VALUES
('2024-12-01', 15000.00, 'UTR1001', 'Client payment - ABC Corp', 'INR', 'bank_stmt_dec.csv'),
('2024-12-02', 2500.00,  'UTR1002', 'Office supplies', 'INR', 'bank_stmt_dec.csv'),
('2024-12-03', 7200.00,  'UTR1003', 'Client payment - XYZ Ltd', 'INR', 'bank_stmt_dec.csv'),
('2024-12-04', 5000.00,  'UTR1004', 'Consulting income', 'INR', 'bank_stmt_dec.csv'),
('2024-12-05', 1800.00,  'UTR1005', 'Bank charges', 'INR', 'bank_stmt_dec.csv');
GO
-- End of File