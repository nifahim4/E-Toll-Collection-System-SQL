/*
--------------------------------------------------------------------------------
					SQL Project Name : E-Toll Collection System
						Trainee Name : Nakibul Islam Fahim   
						  Trainee ID : 1294701       
						    Batch ID : WADA/PNTL-M/69/01

 --------------------------------------------------------------------------------

Table of Contents: DDL
			=> SECTION 01: Created a Database [ETCS]
			=> SECTION 02: Created Appropriate Tables with column definition related to the project
			=> SECTION 03: ALTER, DROP AND MODIFY TABLES & COLUMNS
			=> SECTION 04: CREATE CLUSTERED AND NONCLUSTERED INDEX
			=> SECTION 05: CREATE SEQUENCE & ALTER SEQUENCE
			=> SECTION 06: CREATE A VIEW & ALTER VIEW
			=> SECTION 07: CREATE STORED PROCEDURE & ALTER STORED PROCEDURE
			=> SECTION 08: CREATE FUNCTION(SCALAR, SIMPLE TABLE VALUED, MULTISTATEMENT TABLE VALUED) & ALTER FUNCTION
			=> SECTION 09: CREATE TRIGGER (FOR/AFTER TRIGGER)
			=> SECTION 10: CREATE TRIGGER (INSTEAD OF TRIGGER)
*/


/*
==============================  SECTION 01  ==============================
	   CHECK DATABASE EXISTANCE & CREATE DATABASE WITH ATTRIBUTES
==========================================================================
*/

USE master;
GO

IF DB_ID('ETCS') IS NOT NULL
DROP DATABASE ETCS;
GO

CREATE DATABASE ETCS
ON PRIMARY
(
    NAME = 'ETCS_Data',
    FILENAME = 'F:\IDB\M_02_SQLserver\ETCS\ETCS_Data.mdf',
    SIZE = 25MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5%
)
LOG ON
(
    NAME = 'ETCS_Log',
    FILENAME = 'F:\IDB\M_02_SQLserver\ETCS\ETCS_Log.ldf',
    SIZE = 10MB,
    MAXSIZE = 50MB,
    FILEGROWTH = 1MB
);
GO

USE ETCS;
GO

/*
==============================  SECTION 02  ==============================
		         Created Appropriate Tables with column definition related to the project
==========================================================================
*/

--============== Table with IDENTITY, PRIMARY KEY & nullability CONSTRAINT... ============--

-- 1. Designation (Look up table)


CREATE TABLE Designation (
    DesignationID INT IDENTITY(1,1) PRIMARY KEY,
    DesignationName VARCHAR(50) NOT NULL
);
go
-- 2. VehicleType (Look up table)


CREATE TABLE VehicleType (
    VehicleTypeID INT IDENTITY(1,1) PRIMARY KEY,
    TypeName VARCHAR(50) NOT NULL
);
go
-- 3. PaymentType (Look up table)


CREATE TABLE PaymentType (
    PaymentTypeID INT IDENTITY(1,1) PRIMARY KEY,
    TypeName VARCHAR(50) NOT NULL
);
GO
--============== CREATE A SCHEMA ============--


CREATE SCHEMA HR AUTHORIZATION dbo;
GO

--============== USE SCHEMA IN A TABLE ============--

-- 4. Employees (Using the HR Schema) [cite: 5]


CREATE TABLE HR.Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50),
    DesignationID INT FOREIGN KEY REFERENCES Designation(DesignationID),
    ContactNumber VARCHAR(20),
    Email VARCHAR(100) UNIQUE,
    HireDate DATE DEFAULT GETDATE()
);
go
--============== Table with PRIMARY KEY & FOREIGN KEY & DEFAULT CONSTRAINT... ============--

-- 5. Location


CREATE TABLE [Location] (
    LocationID INT IDENTITY(1,1) PRIMARY KEY,
    LocationName VARCHAR(100),
    Latitude DECIMAL(9, 6),
    Longitude DECIMAL(9, 6),
    EntryPoint VARCHAR(100),
    ExitPoint VARCHAR(100)
);
go
-- 6. Plaza [cite: 5]


CREATE TABLE Plaza (
    PlazaID INT IDENTITY(1,1) PRIMARY KEY,
    PlazaName VARCHAR(100) NOT NULL,
    LocationID INT FOREIGN KEY REFERENCES Location(LocationID),
    ManagerID INT FOREIGN KEY REFERENCES HR.Employees(EmployeeID),
    IsActive BIT DEFAULT 1 -- Default Constraint
);
GO
-- 7. Driver [cite: 5]


CREATE TABLE Driver (
    DriverID INT IDENTITY(1,1) PRIMARY KEY NONCLUSTERED,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    LicenseNumber VARCHAR(50) UNIQUE, -- Unique Constraint
    ContactNumber VARCHAR(20),
    Address VARCHAR(255)
);
GO
-- 8. Vehicles [cite: 5]


CREATE TABLE Vehicles (
    VehicleRegNo VARCHAR(20) PRIMARY KEY,
    VehicleTypeID INT FOREIGN KEY REFERENCES VehicleType(VehicleTypeID),
    Model VARCHAR(50),
    Color VARCHAR(30),
    DriverID INT FOREIGN KEY REFERENCES Driver(DriverID)
);
GO

--============== Table with CHECK CONSTRAINT & set CONSTRAINT name ============--

-- 9. TollTicket (Pricing)


CREATE TABLE TollTicket (
    TicketCode INT IDENTITY(1,1) PRIMARY KEY,
    VehicleTypeID INT FOREIGN KEY REFERENCES VehicleType(VehicleTypeID),
    Amount DECIMAL(10, 2) NOT NULL,
    CONSTRAINT CK_Amount_Positive CHECK (Amount >= 0) -- Check Constraint
);
GO
-- 10. Transactions [cite: 5]


CREATE TABLE Transactions (
    TransactionID INT IDENTITY(1,1) PRIMARY KEY  nonclustered,
    TransactionDateTime DATETIME DEFAULT GETDATE(),
    VehicleRegNo VARCHAR(20) FOREIGN KEY REFERENCES Vehicles(VehicleRegNo),
    DriverID INT FOREIGN KEY REFERENCES Driver(DriverID),
    PlazaID INT FOREIGN KEY REFERENCES Plaza(PlazaID),
    TicketCode INT FOREIGN KEY REFERENCES TollTicket(TicketCode),
    AmountPaid MONEY,
    PaymentTypeID INT FOREIGN KEY REFERENCES PaymentType(PaymentTypeID),
    CONSTRAINT CK_Transaction_Amount CHECK (AmountPaid >= 0)
);
GO
--============== Table with composite PRIMARY KEY ============--


-- 11. PlazaLanes (Junction table showing which lanes exist in which plaza)


CREATE TABLE PlazaLanes (
    PlazaID INT FOREIGN KEY REFERENCES Plaza(PlazaID),
    LaneNumber INT,
    LaneWidth DECIMAL(5, 2),
    CONSTRAINT PK_PlazaLanes PRIMARY KEY (PlazaID, LaneNumber) -- Composite PK
);
GO

/*
==============================  SECTION 03  ==============================
		          ALTER, DROP AND MODIFY TABLES & COLUMNS
==========================================================================
*/

--============== ALTER TABLE SCHEMA AND TRANSFER TO [DBO] ============--


-- Creating a temp table in HR schema to move it

IF OBJECT_ID('dbo.TempTable', 'U') IS NOT NULL
    DROP TABLE dbo.TempTable;
GO

create table HR.TempTable (id int, nameTemp varchar(50), DateTimeUpdate datetime default getdate());
GO

ALTER SCHEMA dbo TRANSFER HR.TempTable;
GO


--============== Update column definition ============--


ALTER TABLE Driver
ALTER COLUMN Address VARCHAR(300);
GO


--============== ADD column with DEFAULT CONSTRAINT ============--


ALTER TABLE Transactions
ADD CreatedAt DATETIME CONSTRAINT DF_Trans_Created DEFAULT GETDATE();
GO


--============== ADD CHECK CONSTRAINT with defining name ============--


ALTER TABLE Vehicles
ADD CONSTRAINT CK_Vehicle_Model_Len CHECK (LEN(Model) >= 2);
GO


--============== DROP COLUMN ============--


ALTER TABLE dbo.TempTable
DROP COLUMN id;
GO


--============== DROP TABLE ============--


DROP TABLE dbo.TempTable;
GO


--============== DROP SCHEMA ============--


-- CREATE SCHEMA TempSchema;

CREATE SCHEMA TempSchema AUTHORIZATION dbo;
GO

-- DROP SCHEMA TempSchema;

DROP SCHEMA TempSchema;
GO


/*
==============================  SECTION 04  ==============================
		          CREATE CLUSTERED AND NONCLUSTERED INDEX
==========================================================================
*/


-- Clustered Index

-- (Note: Primary Keys automatically create Clustered Indexes, but here is explicit syntax)
CREATE CLUSTERED INDEX IX_Clustered_DriverID ON Driver(DriverID);
GO

-- Nonclustered Index

CREATE NONCLUSTERED INDEX IX_Transaction_Date 
ON Transactions(TransactionDateTime);
GO

CREATE NONCLUSTERED INDEX IX_Vehicle_Type 
ON Vehicles(VehicleTypeID);
GO

/*
==============================  SECTION 05  ==============================
							 CREATE SEQUENCE
==========================================================================
*/

CREATE SEQUENCE seq_InvoiceNum
    AS INT
    START WITH 1000
    INCREMENT BY 1
    MINVALUE 1000
    MAXVALUE 99999
    CYCLE;
GO

--============== ALTER SEQUENCE ============--


ALTER SEQUENCE seq_InvoiceNum
    RESTART WITH 2000;
GO


/*
==============================  SECTION 06  ==============================
							  CREATE A VIEW
==========================================================================
*/

-- VIEW WITH ENCRYPTION, SCHEMABINDING & WITH CHECK OPTION


CREATE VIEW v_PlazaInfo
WITH SCHEMABINDING, ENCRYPTION
AS
SELECT PlazaID, PlazaName, LocationID, ManagerID
FROM dbo.Plaza
WITH CHECK OPTION;
GO


-- A COMPLEX VIEW with JOINs to get Driver Transaction History


CREATE VIEW v_DriverTransactionHistory
AS
SELECT 
    d.DriverID,
    d.FirstName + ' ' + d.LastName AS DriverName,
    t.VehicleRegNo,
    p.PlazaName,
    t.TransactionDateTime,
    t.AmountPaid
FROM Transactions t
INNER JOIN Driver d ON t.DriverID = d.DriverID
INNER JOIN Plaza p ON t.PlazaID = p.PlazaID;
GO

-- A VIEW to get total Profit

CREATE VIEW v_TotalRevenue
AS
SELECT 
    p.PlazaName,
    SUM(t.AmountPaid) AS TotalRevenue
FROM Transactions t
JOIN Plaza p ON t.PlazaID = p.PlazaID
GROUP BY p.PlazaName;
GO

--============== ALTER VIEW ============--


ALTER VIEW v_TotalRevenue
AS
SELECT 
    p.PlazaName,
    COUNT(t.TransactionID) AS TotalCars,
    SUM(t.AmountPaid) AS TotalRevenue
FROM Transactions t
JOIN Plaza p ON t.PlazaID = p.PlazaID
GROUP BY p.PlazaName;
GO


/*
==============================  SECTION 07  ==============================
							 STORED PROCEDURE
==========================================================================
*/

--============== STORED PROCEDURE for insert data using parameter ============--

-- Insert a new Vehicle record

GO
CREATE PROCEDURE sp_InsertVehicle
    @RegNo VARCHAR(20),
    @TypeID INT,
    @Model VARCHAR(50),
    @Color VARCHAR(30),
    @DriverID INT
AS
BEGIN
    INSERT INTO Vehicles (VehicleRegNo, VehicleTypeID, Model, Color, DriverID)
    VALUES (@RegNo, @TypeID, @Model, @Color, @DriverID)
END
GO

--============== STORED PROCEDURE with OUTPUT parameter ============--

CREATE PROCEDURE sp_InsertPaymentTypeWithID
    @TypeName VARCHAR(50),
    @NewID INT OUTPUT
AS
BEGIN
    INSERT INTO PaymentType(TypeName)
    VALUES (@TypeName);

    SET @NewID = SCOPE_IDENTITY();
END
GO

--============== STORED PROCEDURE with TRY CATCH ============--

CREATE PROCEDURE sp_InsertDesignationSafe
    @DesignationName VARCHAR(50)
AS
BEGIN
    BEGIN TRY
        IF EXISTS(SELECT 1 FROM Designation WHERE DesignationName = @DesignationName)
        BEGIN
            RAISERROR('Designation already exists.', 16, 1);
        END

        INSERT INTO Designation(DesignationName)
        VALUES (@DesignationName);
        
        PRINT 'Designation inserted successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred: ' + ERROR_MESSAGE();
    END CATCH
END
GO

--============== STORED PROCEDURE for UPDATE data ============--


GO
CREATE PROCEDURE sp_UpdateDriverAddress
    @DriverID INT,
    @NewAddress VARCHAR(300)
AS
BEGIN
    UPDATE Driver
    SET Address = @NewAddress
    WHERE DriverID = @DriverID
END
GO

--============== STORED PROCEDURE for DELETE Table data ============--


GO
CREATE PROCEDURE sp_DeleteDesignation
    @DesignationID INT
AS
BEGIN
    DELETE FROM Designation
    WHERE DesignationID = @DesignationID
END
GO

--============== ALTER STORED PROCEDURE ============--


GO
ALTER PROCEDURE sp_UpdateDriverAddress
    @DriverID INT,
    @NewAddress VARCHAR(300)
AS
BEGIN
    UPDATE Driver
    SET Address = @NewAddress
    WHERE DriverID = @DriverID;
    
    PRINT 'Address Updated Successfully';
END
GO


/*
==============================  SECTION 08  ==============================
								 FUNCTION
==========================================================================
*/

--============== A SCALAR FUNCTION ============--


-- Calculates tax (15% VAT) on a given amount
GO
CREATE FUNCTION fn_CalculateTax(@Amount DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @Amount * 0.15
END
GO

--============== A SIMPLE TABLE VALUED FUNCTION ============--


-- Returns all vehicles of a certain type
GO
CREATE FUNCTION fn_GetVehiclesByType(@TypeID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT VehicleRegNo, Model, Color 
    FROM Vehicles 
    WHERE VehicleTypeID = @TypeID
)
GO

--============== A MULTISTATEMENT TABLE VALUED FUNCTION ============--


-- Returns Driver details with a status column
GO
CREATE FUNCTION fn_DriverStatus()
RETURNS @DriverInfo TABLE 
(
    DriverName VARCHAR(100),
    LicenseNumber VARCHAR(50),
    Status VARCHAR(20)
)
AS
BEGIN
    INSERT INTO @DriverInfo
    SELECT 
        FirstName + ' ' + LastName,
        LicenseNumber,
        'Active'
    FROM Driver;
    
    RETURN;
END
GO

--============== ALTER FUNCTION ============--


GO
ALTER FUNCTION fn_CalculateTax(@Amount DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
    -- Changed VAT to 10%
    RETURN @Amount * 0.10
END
GO


/*
==============================  SECTION 09  ==============================
							FOR/AFTER TRIGGER
==========================================================================
*/

--============== AN AFTER/FOR TRIGGER FOR INSERT, UPDATE, DELETE ============--
-- Create an Audit Table first
CREATE TABLE PlazaAudit (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    AuditMessage VARCHAR(255),
    LogDate DATETIME DEFAULT GETDATE()
);
GO

CREATE TRIGGER trg_AfterPlazaInsert
ON Plaza
AFTER INSERT
AS
BEGIN

    DECLARE @PlazaName VARCHAR(100);
    SELECT @PlazaName = PlazaName FROM inserted;
    
    INSERT INTO PlazaAudit (AuditMessage)
    VALUES ('New Plaza Added: ' + @PlazaName);
    
END
GO


/*
==============================  SECTION 10  ==============================
							INSTEAD OF TRIGGER
==========================================================================
*/

--============== AN INSTEAD OF TRIGGER ON VIEW ============--


-- 1. Create an INSTEAD OF INSERT TRIGGER on the v_DriverTransactionHistory view


CREATE TRIGGER trg_InsteadOfInsertDriverHistory
ON v_DriverTransactionHistory
INSTEAD OF INSERT
AS
BEGIN
    -- We only insert into the Transactions table, as Driver and Plaza should already exist.
    -- This assumes the view's 'DriverID', 'VehicleRegNo', and 'PlazaID' are provided in the INSERT statement.
    
    INSERT INTO Transactions (VehicleRegNo, DriverID, PlazaID, TransactionDateTime, AmountPaid)
    SELECT 
        i.VehicleRegNo, 
        i.DriverID, 
        (SELECT PlazaID FROM Plaza WHERE PlazaName = i.PlazaName), -- Look up ID based on Name
        GETDATE(), -- Default to current time if not provided
        i.AmountPaid
    FROM inserted i;

    PRINT 'Transaction successfully recorded via View Trigger.';
END
GO


