/*
 Project: LedgerMatch
 Purpose: Create primary database
 Author: Tanvi Gurav
 Created: Day 1
*/


-- Create the LedgerMatchDB database if it does not exist
IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE name = 'LedgerMatchDB')
BEGIN
    CREATE DATABASE LedgerMatchDB;
END
GO

-- Verify database creation
SELECT name, create_date
FROM sys.databases
WHERE name = 'LedgerMatchDB';
GO
-- End of File