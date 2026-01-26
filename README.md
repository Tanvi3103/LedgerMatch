# LedgerMatch – Financial Reconciliation Engine (SQL-Heavy Project)

LedgerMatch is a SQL-driven financial reconciliation system designed to match bank transactions with internal ledger records.  
The project simulates real-world finance reconciliation scenarios including exact matches, amount mismatches, and unmatched transactions, with full audit tracking.

This project focuses on **advanced SQL design**, **data integrity**, and **finance-domain logic**, rather than UI.

---

## 🧠 Problem Statement

In financial systems, transactions recorded internally must be reconciled against bank statements.  
Differences can occur due to:
- Timing issues
- Amount discrepancies
- Missing transactions on either side

LedgerMatch implements a **rule-based, multi-pass reconciliation engine** to classify these cases accurately and auditably.

---

## 🏗️ System Design Overview

**Core Concepts**
- Run-based reconciliation (each execution is traceable)
- Multi-pass matching strategy
- Immutable reconciliation results
- Explicit match rules for audit clarity

**High-level flow**
1. Load bank and internal transactions
2. Create a reconciliation run
3. Apply exact match rules
4. Apply mismatch rules
5. Classify unmatched transactions
6. Generate reconciliation summary

---

## 🗄️ Database Schema

### Key Tables

- **BankTransactions**
  - Raw transactions received from bank statements

- **InternalTransactions**
  - Transactions recorded in internal systems

- **ReconciliationRun**
  - Tracks each reconciliation execution (date, status)

- **ReconciliationResult**
  - Stores match outcomes with rule classification

---

## 🔁 Reconciliation Logic

LedgerMatch uses a **multi-pass approach**:

### Pass 1 – Exact Match
Transactions are matched when:
- Transaction date matches
- Amount matches
- Currency matches
- Reference number matches

Result:
MatchStatus = MATCHED
MatchRule = EXACT_MATCH


---

### Pass 2 – Amount Mismatch
Transactions match on reference, date, and currency but differ in amount.

Result:
MatchStatus = MISMATCH
MatchRule = AMOUNT_MISMATCH


---

### Pass 3 – Bank Only
Transactions present in bank data but missing internally.

Result:
MatchStatus = UNMATCHED
MatchRule = BANK_ONLY


---

### Pass 4 – Internal Only
Transactions present internally but missing in bank data.

Result:
MatchStatus = UNMATCHED
MatchRule = INTERNAL_ONLY


---

## 📁 Project Structure

LedgerMatch/
│
├── sql/
│ ├── 01_database_setup/
│ ├── 02_tables/
│ ├── 03_seed_data/
│ ├── 06_reconciliation_logic/
│
├── README.md


Each SQL file is **idempotent and ordered** to allow step-by-step execution.

---

## 🚀 How to Run the Project

### Prerequisites
- Docker Desktop (macOS)
- SQL Server container
- VS Code with SQL extensions

### Steps
1. Start Docker Desktop
2. Start SQL Server container
3. Execute scripts in order:
   - Database creation
   - Table creation
   - Seed data
   - Reconciliation logic
4. Run reconciliation summary script to view results

---

## 📊 Sample Output

Reconciliation summary groups transactions by:
- MatchStatus
- MatchRule

This mirrors real financial reconciliation reports used in banking and accounting systems.

---

## 🔮 Future Enhancements

- Tolerance-based matching (± amount)
- Partial matching rules
- Performance tuning with indexes
- Stored procedures for reconciliation runs
- .NET API layer for reconciliation execution
- Frontend dashboard (React)

---

## 🎯 Why This Project

This project demonstrates:
- Advanced SQL joins and filtering
- Real-world finance problem modeling
- Audit-safe reconciliation design
- Production-style data processing patterns

It is intentionally SQL-heavy to reflect real enterprise data workloads.
