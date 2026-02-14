USE LedgerMatchDB;
GO

CREATE OR ALTER PROCEDURE dbo.sp_RunReconciliation
    @Tolerance DECIMAL(18,2) = 1.00
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ReconRunId INT;

    ---------------------------------------------------------
    -- 1. Create reconciliation run
    ---------------------------------------------------------
    INSERT INTO ReconciliationRun (ReconDate, Status)
    VALUES (CAST(GETDATE() AS DATE), 'IN_PROGRESS');

    SET @ReconRunId = SCOPE_IDENTITY();

    ---------------------------------------------------------
    -- 2. EXACT MATCH
    ---------------------------------------------------------
    INSERT INTO ReconciliationResult
    (ReconRunId, BankTxnId, InternalTxnId, MatchStatus, MatchRule)
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
        AND b.CurrencyCode = i.CurrencyCode
        AND b.Amount = i.Amount;

    ---------------------------------------------------------
    -- 3. TOLERANCE MATCH
    ---------------------------------------------------------
    INSERT INTO ReconciliationResult
    (ReconRunId, BankTxnId, InternalTxnId, MatchStatus, MatchRule)
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
    WHERE NOT EXISTS (
        SELECT 1 FROM ReconciliationResult r
        WHERE r.BankTxnId = b.BankTxnId
          AND r.ReconRunId = @ReconRunId
    );

    ---------------------------------------------------------
    -- 4. AMOUNT MISMATCH
    ---------------------------------------------------------
    INSERT INTO ReconciliationResult
    (ReconRunId, BankTxnId, InternalTxnId, MatchStatus, MatchRule)
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
    WHERE NOT EXISTS (
        SELECT 1 FROM ReconciliationResult r
        WHERE r.BankTxnId = b.BankTxnId
          AND r.ReconRunId = @ReconRunId
    );

    ---------------------------------------------------------
    -- 5. BANK ONLY
    ---------------------------------------------------------
    INSERT INTO ReconciliationResult
    (ReconRunId, BankTxnId, InternalTxnId, MatchStatus, MatchRule)
    SELECT
        @ReconRunId,
        b.BankTxnId,
        NULL,
        'UNMATCHED',
        'BANK_ONLY'
    FROM BankTransactions b
    WHERE NOT EXISTS (
        SELECT 1 FROM ReconciliationResult r
        WHERE r.BankTxnId = b.BankTxnId
          AND r.ReconRunId = @ReconRunId
    );

    ---------------------------------------------------------
    -- 6. INTERNAL ONLY
    ---------------------------------------------------------
    INSERT INTO ReconciliationResult
    (ReconRunId, BankTxnId, InternalTxnId, MatchStatus, MatchRule)
    SELECT
        @ReconRunId,
        NULL,
        i.InternalTxnId,
        'UNMATCHED',
        'INTERNAL_ONLY'
    FROM InternalTransactions i
    WHERE NOT EXISTS (
        SELECT 1 FROM ReconciliationResult r
        WHERE r.InternalTxnId = i.InternalTxnId
          AND r.ReconRunId = @ReconRunId
    );

    ---------------------------------------------------------
    -- 7. Mark run completed
    ---------------------------------------------------------
    UPDATE ReconciliationRun
    SET 
        Status = 'COMPLETED',
        CompletedAt = GETDATE()
    WHERE ReconRunId = @ReconRunId;

    ---------------------------------------------------------
    -- 8. Return summary
    ---------------------------------------------------------
    SELECT *
    FROM dbo.vw_ReconciliationSummary
    WHERE ReconRunId = @ReconRunId;


END

EXEC sp_RunReconciliation @Tolerance = 1.00;
SELECT * FROM dbo.ReconciliationRun ORDER BY ReconRunId DESC;

GO
