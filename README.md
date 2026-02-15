
# LedgerMatch – Financial Reconciliation Engine

![SQL Server](https://img.shields.io/badge/SQL%20Server-2022-blue)
![.NET Core](https://img.shields.io/badge/.NET%20Core-9.0-green)
![Docker](https://img.shields.io/badge/Docker-Desktop-blue)


---

## ⚡ Quick Start

```bash
# Clone repo
git clone https://github.com/Tanvi3103/LedgerMatch.git
cd LedgerMatch

# Start SQL Server in Docker
docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=YourPassword" -p 1433:1433 -d mcr.microsoft.com/mssql/server:2022-latest

# Run SQL scripts in order using Azure Data Studio / SSMS
# 01_database_setup → 02_tables → 03_seed_data → 06_reconciliation_logic

# Optional: Run the backend API
cd ReconciliationAPI
dotnet run
````

API Swagger UI: `https://localhost:5001/swagger`

---

## 📝 Project Overview

LedgerMatch is a **SQL-driven financial reconciliation system** that matches bank transactions with internal ledger records.

It simulates real-world finance reconciliation including:

* Exact matches
* Amount mismatches
* Bank-only / Internal-only transactions
* Tolerance-based matching (± amount)

> Focused on **data integrity**, **finance-domain logic**, and **audit-safe reconciliation**, rather than UI.

---

## 🏗️ System Design

**Core Concepts:**

* Run-based reconciliation (traceable executions)
* Multi-pass matching strategy
* Immutable results
* Explicit match rules for audit clarity

**Flow:**

1. Load bank and internal transactions
2. Create a reconciliation run
3. Apply exact match rules
4. Apply mismatch rules
5. Identify unmatched transactions
6. Generate reconciliation summary

---

## 🗄️ Database Schema

**Key Tables:**

* `BankTransactions` – Raw bank data
* `InternalTransactions` – Internal ledger data
* `ReconciliationRun` – Tracks execution date/status
* `ReconciliationResult` – Stores match outcomes & rules

**Views:**

* `vw_ReconciliationSummary` – Aggregated counts and totals
* `vw_UnmatchedTransactions` – Detailed unmatched transactions
* `vw_MatchDetails` – Full matched transaction info

---

## 🔁 Reconciliation Logic
```
Pass 1 – Exact Match:** Date, Amount, Currency, Reference match → `MATCHED / EXACT_MATCH`
Pass 2 – Amount Mismatch:** Date, Currency, Reference match but different amount → `MISMATCH / AMOUNT_MISMATCH`
Pass 3 – Bank Only:** Transaction exists only in bank → `UNMATCHED / BANK_ONLY`
Pass 4 – Internal Only:** Transaction exists only internally → `UNMATCHED / INTERNAL_ONLY`
Pass 5 – Tolerance Match:** Approximate amount match within tolerance → `MATCHED / TOLERANCE_MATCH`
```

---

## 📁 Project Structure

```
LedgerMatch/
│
├── sql/
│   ├── 01_database_setup/
│   ├── 02_tables/
│   ├── 03_seed_data/
│   └── 06_reconciliation_logic/
│
├── ReconciliationAPI/
│   ├── Controllers/
│   ├── Models/
│   ├── Services/
│   ├── Program.cs
│   └── appsettings.json
│
├── README.md
└── LedgerMatch.sln
```

---

## 🚀 Running the Project

1. **Start SQL Server in Docker**
2. **Execute SQL scripts** (setup → tables → seed → reconciliation)
3. **Run API** (optional, for programmatic access)

---

## 📊 Sample Output

Reconciliation summary groups transactions by `MatchStatus` and `MatchRule`:

```json
[
  {
    "reconRunId": 1002,
    "matchStatus": "MISMATCH",
    "matchRule": "AMOUNT_MISMATCH",
    "transactionCount": 1,
    "totalAmount": 5000
  },
  {
    "reconRunId": 1002,
    "matchStatus": "UNMATCHED",
    "matchRule": "BANK_ONLY",
    "transactionCount": 1,
    "totalAmount": 1800
  }
]
```

---

## 🔮 Future Enhancements

* Tolerance-based matching (± amount)
* Partial matching rules
* Performance tuning with indexes
* Full .NET API for reconciliation execution
* Frontend dashboard (React/Vue)
* Export results to CSV / Excel

---

## 🎯 Why This Project

* Demonstrates **advanced SQL joins, filtering, and aggregation**
* Models a **real-world financial problem**
* Implements **audit-safe, rule-based reconciliation**
* Production-style data processing patterns

---




