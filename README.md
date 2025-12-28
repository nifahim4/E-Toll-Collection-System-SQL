# E-Toll Collection System (ETCS) Database

![SQL Server](https://img.shields.io/badge/Database-SQL%20Server-CC2927?style=flat&logo=microsoft-sql-server)
![Status](https://img.shields.io/badge/Status-Work%20in%20Progress-blue)

A comprehensive Relational Database Management System (RDBMS) designed to manage the operations of an Electronic Toll Collection System. This project was developed using **Microsoft SQL Server 2022** and demonstrates advanced database design principles including schemas, encryption, triggers, and complex reporting views.

## 📋 Project Information

| Field | Details |
| :--- | :--- |
| **Project Name** | E-Toll Collection System (ETCS) |
| **Trainee Name** | **Nakibul Islam Fahim** |
| **Trainee ID** | **1294701** |
| **Batch ID** | **WADA/PNTL-M/69/01** |
| **Submission Date** | 31st December 2025 |

## 📂 Repository Structure

* **`E-Toll_MS_DDL.sql`**: (Data Definition Language) Contains the scripts to create the database, tables, relationships, views, stored procedures, functions, and triggers.
* **`E-Toll_MS_DML.sql`**: (Data Manipulation Language) Contains scripts for inserting dummy data, executing stored procedures, and running testing queries.
* **`Case Study.pdf`**: Detailed documentation of the project requirements and design.

## 🚀 Project Overview

The ETCS database automates the core functions of toll plazas. It handles vehicle tracking, automated fee calculation based on vehicle type (Heavy/Light), and revenue management. It serves as a backend for handling high-volume traffic data efficiently while maintaining strict data integrity.

### Key Features Implemented

* **Advanced Normalization:** Schema designed up to 3NF using lookup tables (`VehicleType`, `PaymentType`, `Designation`).
* **Security & Schemas:** Implements a custom `HR` schema for employee data and uses `WITH ENCRYPTION` and `SCHEMABINDING` for sensitive Views.
* **Automated Auditing:** Uses **AFTER Triggers** (`trg_AfterPlazaInsert`) to automatically log administrative actions into an audit table.
* **Smart Data Entry:** Uses **INSTEAD OF Triggers** on Views (`trg_InsteadOfInsertDriverHistory`) to handle complex insertions securely.
* **Error Handling:** Stored Procedures utilize `TRY...CATCH` blocks to gracefully handle errors during transaction processing.
* **Reporting Logic:** Includes Scalar Functions (`fn_CalculateTax`) for tax logic and Table-Valued Functions (`fn_GetVehiclesByType`) for filtering data.

## 🗄️ Database Schema

The database consists of **11 primary tables** organized into logical groups:

1.  **Infrastructure:** `Plaza`, `Location`, `PlazaLanes`
2.  **Personnel (HR Schema):** `HR.Employees`, `Designation`
3.  **Fleet Management:** `Driver`, `Vehicles`
4.  **Financials:** `TollTicket` (Pricing), `PaymentType`, `Transactions`
5.  **Logs:** `PlazaAudit`

## 🛠 Installation & Usage

1.  **Clone the Repository:**
    ```bash
    git clone [https://github.com/nifahim4/E-Toll-Collection-System-SQL.git](https://github.com/nifahim4/E-Toll-Collection-System-SQL.git)
    ```
2.  **Open the DDL Script:**
    Open `E-Toll_MS_DDL.sql` in SQL Server Management Studio (SSMS).
3.  **Configure Paths:**
    Find the `CREATE DATABASE` section. Update the `FILENAME` paths to match your local machine:
    ```sql
    FILENAME = 'C:\Your_Path\ETCS_Data.mdf',
    ```
4.  **Execute Scripts:**
    1.  Run `E-Toll_MS_DDL.sql` first to build the structure.
    2.  Run `E-Toll_MS_DML.sql` second to populate it with sample data and test the queries.

## 💻 Code Highlights

### Secure Stored Procedure with Error Handling
```sql
CREATE PROCEDURE sp_InsertTransactionMsg
    @VehicleRegNo VARCHAR(30),
    @DriverID INT,
    @PlazaID INT,
    @TicketCode INT,
    @AmountPaid MONEY,
    @PaymentTypeID INT
AS
BEGIN
    BEGIN TRY
        INSERT INTO Transactions (...) VALUES (...);
        PRINT 'Transaction successful.';
    END TRY
    BEGIN CATCH
        PRINT 'Error: ' + ERROR_MESSAGE();
    END CATCH
END
