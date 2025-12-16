# E-Toll Collection System (ETCS) Database

![SQL Server](https://img.shields.io/badge/Database-SQL%20Server-CC2927?style=flat&logo=microsoft-sql-server)
![Status](https://img.shields.io/badge/Status-Completed-success)

A comprehensive Relational Database Management System (RDBMS) designed to manage the operations of an Electronic Toll Collection System. This project was developed using **Microsoft SQL Server (T-SQL)** and demonstrates advanced database design principles, normalization, and server-side logic.

## 📌 Project Overview

The ETCS database automates the core functions of toll plazas, including tracking vehicles, managing drivers, calculating toll fees based on vehicle types, and auditing transactions. It serves as a robust backend for handling high-volume toll traffic data efficiently.

### Key Features
* **Normalized Schema:** Designed up to 3NF to ensure data integrity and reduce redundancy.
* **Automated Auditing:** Uses triggers to automatically log administrative actions (e.g., adding new plazas) into audit tables.
* **Complex Views:** Secure views with encryption and schema binding to abstract complex joins for reporting revenue and driver history.
* **Advanced Logic:** Implements Stored Procedures for safe data entry and User-Defined Functions (UDFs) for dynamic tax calculations.

## 🛠️ Tech Stack

* **Database:** Microsoft SQL Server 2019+
* **Language:** T-SQL (Transact-SQL)
* **Tools:** SSMS (SQL Server Management Studio)

## 📂 Database Schema

The database consists of **11 primary tables** organized into logical groups:

1.  **Infrastructure:** `Plaza`, `Location`, `PlazaLanes`
2.  **Personnel:** `HR.Employees`, `Driver`, `Designation`
3.  **Assets & Pricing:** `Vehicles`, `VehicleType`, `TollTicket`, `PaymentType`
4.  **Operations:** `Transactions` (Central fact table)

## 🚀 Installation & Usage

1.  **Clone the Repository:**
    ```bash
    git clone [https://github.com/YourUsername/E-Toll-Collection-System-SQL.git](https://github.com/nifahim4/E-Toll-Collection-System-SQL.git)
    ```
2.  **Open the Script:**
    Open the file `E-Toll_MS_DDL.sql` in SQL Server Management Studio (SSMS).
3.  **Configure Paths:**
    * Find the `CREATE DATABASE` section at the top of the script.
    * Update the `FILENAME` paths to match your local machine's folder structure (e.g., `C:\SQLData\`).
4.  **Execute:**
    Run the script to build the entire database, including all tables, views, and procedures.

## 📝 Code Highlights

### Stored Procedures
Pre-compiled routines to handle repetitive tasks securely.
```sql
-- Example: Registering a new vehicle
EXEC sp_InsertVehicle 
    @RegNo = 'DHK-MET-1234', 
    @TypeID = 1, 
    @Model = 'Toyota Corolla', 
    @Color = 'White', 
    @DriverID = 101;
