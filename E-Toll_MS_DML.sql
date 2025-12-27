/*
					SQL Project Name : E-Toll Collection System
						Trainee Name : Nakibul Islam Fahim   
						  Trainee ID : 1294701       
						    Batch ID : WADA/PNTL-M/69/01

 --------------------------------------------------------------------------------
Table of Contents: DML
			=> SECTION 01: INSERT DATA USING INSERT INTO KEYWORD
			=> SECTION 02: INSERT DATA THROUGH STORED PROCEDURE
				SUB SECTION => 2.1 : INSERT DATA THROUGH STORED PROCEDURE WITH AN OUTPUT PARAMETER 
				SUB SECTION => 2.2 : INSERT DATA USING SEQUENCE VALUE
			=> SECTION 03: UPDATE DELETE DATA THROUGH STORED PROCEDURE
				SUB SECTION => 3.1 : UPDATE DATA THROUGH STORED PROCEDURE
				SUB SECTION => 3.2 : DELETE DATA THROUGH STORED PROCEDURE
				SUB SECTION => 3.3 : STORED PROCEDURE WITH TRY CATCH AND RAISE ERROR
			=> SECTION 04: INSERT UPDATE DELETE DATA THROUGH VIEW
				SUB SECTION => 4.1 : INSERT DATA through view
				SUB SECTION => 4.2 : UPDATE DATA through view
				SUB SECTION => 4.3 : DELETE DATA through view
			=> SECTION 05: RETREIVE DATA USING FUNCTION(SCALAR, SIMPLE TABLE VALUED, MULTISTATEMENT TABLE VALUED)
			=> SECTION 06: TEST TRIGGER (FOR/AFTER TRIGGER ON TABLE, INSTEAD OF TRIGGER ON TABLE & VIEW)
			=> SECTION 07: QUERY
				SUB SECTION => 7.01 : SELECT FROM TABLE
				SUB SECTION => 7.02 : SELECT FROM VIEW
				SUB SECTION => 7.03 : SELECT INTO
				SUB SECTION => 7.04 : IMPLICIT JOIN WITH WHERE BY CLAUSE, ORDER BY CLAUSE
				SUB SECTION => 7.05 : INNER JOIN WITH GROUP BY CLAUSE
				SUB SECTION => 7.06 : OUTER JOIN
				SUB SECTION => 7.07 : CROSS JOIN
				SUB SECTION => 7.08 : TOP CLAUSE WITH TIES
				SUB SECTION => 7.09 : DISTINCT
				SUB SECTION => 7.10 : COMPARISON, LOGICAL(AND OR NOT) & BETWEEN OPERATOR
				SUB SECTION => 7.11 : LIKE, IN, NOT IN, OPERATOR & IS NULL CLAUSE
				SUB SECTION => 7.12 : OFFSET FETCH
				SUB SECTION => 7.13 : UNION
				SUB SECTION => 7.14 : EXCEPT INTERSECT
				SUB SECTION => 7.15 : AGGREGATE FUNCTIONS
				SUB SECTION => 7.16 : GROUP BY & HAVING CLAUSE
				SUB SECTION => 7.17 : ROLLUP & CUBE OPERATOR
				SUB SECTION => 7.18 : GROUPING SETS
				SUB SECTION => 7.19 : SUB-QUERIES (INNER, CORRELATED)
				SUB SECTION => 7.20 : EXISTS
				SUB SECTION => 7.21 : CTE
				SUB SECTION => 7.22 : BUILT IN FUNCTION
				SUB SECTION => 7.23 : CASE
				SUB SECTION => 7.24 : IIF
				SUB SECTION => 7.25 : COALESCE & ISNULL
				SUB SECTION => 7.26 : WHILE
				SUB SECTION => 7.27 : GROPING FUNCTION
				SUB SECTION => 7.28 : RANKING FUNCTION
				SUB SECTION => 7.29 : IF ELSE & PRINT
				SUB SECTION => 7.30 : TRY CATCH
				SUB SECTION => 7.31 : GOTO
				SUB SECTION => 7.32 : WAITFOR
				SUB SECTION => 7.33 : sp_helptext
				SUB SECTION => 7.34 : TRANSACTION WITH SAVE POINT
*/

USE ETCS;
GO

/*
==============================  SECTION 01  ==============================
					INSERT DATA USING INSERT INTO KEYWORD
==========================================================================
*/

--============== Insert data by specifying column name ============--

-- 1. Designation
INSERT INTO Designation (DesignationName) VALUES ('Plaza Manager'), ('Toll Collector'), ('Security Guard'), ('Admin');
GO

-- 2. VehicleType
INSERT INTO VehicleType (TypeName) VALUES ('Motorcycle'), ('Private Car'), ('Bus'), ('Truck'), ('Trailer'), ('SUV'), ('Van'), ('Pickup'), ('CNG');
GO

-- 3. PaymentType
INSERT INTO PaymentType (TypeName) VALUES ('Cash'), ('Card'), ('Mobile Banking'), ('RFID Tag');
GO

-- 4. Location
INSERT INTO Location (LocationName, Latitude, Longitude, EntryPoint, ExitPoint)
VALUES 
('Meghna Bridge', 23.6050, 90.6100, 'Dhaka', 'Chittagong'),
('Padma Bridge', 23.4444, 90.2555, 'Mawa', 'Janjira'),
('Jamuna Bridge', 24.3990, 89.7780, 'Tangail', 'Sirajganj');
GO

-- 5. HR.Employees
INSERT INTO HR.Employees (FirstName, LastName, DesignationID, ContactNumber, Email, HireDate)
VALUES 
('Nakibul', 'Fahim', 1, '01550446262', 'nifahim4@etcs.com', '2023-01-01'),
('Omar', 'Faruk', 1, '01700000000', 'omar@etcs.com', '2023-01-01'),
('Rahim', 'Uddin', 2, '01711111111', 'rahim@etcs.com', '2023-01-01'),
('Karim', 'Ahmed', 2, '01722222222', 'karim@etcs.com', '2023-02-15'),
('Suma', 'Akter', 2, '01733333333', 'suma@etcs.com', '2023-03-10'),
('Jabbar', 'Ali', 3, '01744444444', 'jabbar@etcs.com', '2023-04-05');
GO


--============== Insert data by column sequence ============--

-- 6. Plaza (Order: Name, LocID, ManagerID, IsActive)
INSERT INTO Plaza VALUES 
('Meghna Toll Plaza', 1, 1, 1),
('Padma Toll Plaza', 2, 1, 1),
('Jamuna Toll Plaza', 3, 1, 1);
GO

-- 7. Driver (Skipping ID as it is Identity)
INSERT INTO Driver (FirstName, LastName, LicenseNumber, ContactNumber, Address)
VALUES 
('Nakibul', 'Fahim', 'DL-1000', '01550446262', 'Dhaka'),
('Omar', 'Faruk', 'DL-1005', '01700000000', 'Shajatpur'),
('Nofayel', 'Ahmed', 'DL-1004', '01800000000', 'Narayanganj'),
('Mohammed','Rami', 'DL-1006', '01900000000', 'Chadpur'),
('Ahsan', 'Hafeez', 'DL-1007', '01600000000', 'Satkhira'),
('Eshan', 'Ul-Karim', 'DL-1008', '01500000000', 'Barisal'),
('Salam', 'Khan', 'DL-1001', '01811111111', 'Dhaka'),
('Barkat', 'Hossain', 'DL-1002', '01822222222', 'Comilla'),
('Rafiq', 'Islam', 'DL-1003', '01833333333', 'Chittagong');
GO

-- 8. Vehicles
INSERT INTO Vehicles (VehicleRegNo, VehicleTypeID, Model, Color, DriverID)
VALUES 
('DHAKA-METRO-KA-11', 2, 'Toyota Corolla', 'White', 1),
('CHATTO-METRO-GHA-22', 4, 'Tata Truck', 'Yellow', 2),
('DHAKA-METRO-HA-33', 1, 'Yamaha R15', 'Blue', 3),
('KHULNA-METRO-TA-44', 3, 'Volvo Bus', 'Red', 4),
('RAJSHAHI-METRO-PA-55', 5, 'Hino Trailer', 'Green', 5),
('BARISAL-METRO-BA-66', 6, 'Ford Explorer', 'Black', 6),
('SYLHET-METRO-SA-77', 7, 'Nissan Van', 'Silver', 7),
('COMILLA-METRO-CA-88', 8, 'Mitsubishi Pickup', 'Grey', 8),
('CHITTAGONG-METRO-CHA-99', 9, 'Toyota CNG', 'White', 9),
('DHAKA-METRO-GA-99', 2, 'Honda Civic', 'Black', 1);
GO

-- 9. TollTicket
INSERT INTO TollTicket (VehicleTypeID, Amount)
VALUES 
(1, 100.00), -- Motorcycle
(2, 500.00), -- Private Car
(3, 1000.00), -- Bus
(4, 1500.00), -- Truck
(5, 2000.00), -- Trailer
(6, 1800.00), -- SUV
(7, 1600.00), -- Van
(8, 1700.00), -- Pickup
(9, 900.00);  -- CNG
GO

-- 10. PlazaLanes
INSERT INTO PlazaLanes (PlazaID, LaneNumber, LaneWidth)
VALUES 
(1, 1, 3.5),
(1, 2, 3.5),
(2, 1, 4.0),
(2, 2, 4.0),
(3, 1, 5.0),
(3, 2, 5.0),
(3, 3, 5.0);
GO

/*
==============================  SECTION 02  ==============================
					INSERT DATA THROUGH STORED PROCEDURE
==========================================================================
*/

-- Using the existing SP from DDL
EXEC sp_InsertVehicle 'DHAKA-METRO-GA-99', 2, 'Honda Civic', 'Black', 1;
GO


--============== 2.1 INSERT DATA THROUGH STORED PROCEDURE WITH AN OUTPUT PARAMETER ============--

-- Note: Ensure sp_InsertPaymentTypeWithID is created (See Part 1 of instructions)
DECLARE @PayID INT;

EXEC sp_InsertPaymentTypeWithID 'Crypto', @PayID OUTPUT;
GO

PRINT 'New Payment Type ID is: ' + CAST(@PayID AS VARCHAR);
GO


--============== 2.2 INSERT DATA USING SEQUENCE VALUE ============--

-- Inserting into Transactions manually using the Sequence for a custom receipt number or just logging it
-- Assuming we want to use the sequence for an Invoice Number simulation in a temp variable

DECLARE @InvoiceNum INT;

SET @InvoiceNum = NEXT VALUE FOR seq_InvoiceNum;
GO

INSERT INTO Transactions (VehicleRegNo, DriverID, PlazaID, TicketCode, AmountPaid, PaymentTypeID)
VALUES ('DHAKA-METRO-KA-11', 1, 1, 2, 500.00, 1);
GO

PRINT 'Transaction Logged with Simulated Invoice #: ' + CAST(@InvoiceNum AS VARCHAR);
GO


/*
==============================  SECTION 03  ==============================
			UPDATE DELETE DATA THROUGH STORED PROCEDURE
==========================================================================
*/


--============== 3.1 UPDATE DATA THROUGH STORED PROCEDURE ============--

EXEC sp_UpdateDriverAddress 1, 'New Address: Uttara, Dhaka';
GO


--============== 3.2 DELETE DATA THROUGH STORED PROCEDURE ============--

-- Deleting 'Security Guard' designation (ID 3)
-- Note: Ensure no employees are assigned to this ID before deleting to avoid FK conflicts
EXEC sp_DeleteDesignation 3;
GO


--============== 3.3 STORED PROCEDURE WITH TRY CATCH AND RAISE ERROR ============--

-- Note: Ensure sp_InsertDesignationSafe is created

EXEC sp_InsertDesignationSafe 'Plaza Manager'; -- Should trigger error (already exists)
GO

EXEC sp_InsertDesignationSafe 'Auditor';       -- Should succeed
GO


/*
==============================  SECTION 04  ==============================
					INSERT UPDATE DELETE DATA THROUGH VIEW
==========================================================================
*/

--============== 4.1 INSERT DATA through view ============--

-- This works because we have an INSTEAD OF INSERT trigger on this view

INSERT INTO v_DriverTransactionHistory (DriverID, DriverName, VehicleRegNo, PlazaName, AmountPaid)
VALUES (2, 'Barkat Hossain', 'CHATTO-METRO-GHA-22', 'Padma Toll Plaza', 1500.00);
GO


--============== 4.2 UPDATE DATA through view ============--

-- Updates the underlying Plaza table

UPDATE v_PlazaInfo
SET PlazaName = 'Padma Multipurpose Bridge Plaza'
WHERE PlazaID = 2;
GO


--============== 4.3 DELETE DATA through view ============--

-- This will delete from the underlying Plaza table

DELETE FROM v_PlazaInfo
WHERE PlazaID = 3;
GO


/*
==============================  SECTION 05  ==============================
						RETREIVE DATA USING FUNCTION
==========================================================================
*/

-- 1. Scalar Function

SELECT dbo.fn_CalculateTax(1000.00) AS TaxAmount;
GO


-- 2. Table Valued Function

SELECT * FROM dbo.fn_GetVehiclesByType(2);
GO


-- 3. Multi-statement Table Valued Function

SELECT * FROM dbo.fn_DriverStatus();
GO


/*
==============================  SECTION 06  ==============================
							   TEST TRIGGER
==========================================================================
*/

--============== FOR/AFTER TRIGGER ON TABLE ============--

-- Testing trg_AfterPlazaInsert

INSERT INTO Plaza (PlazaName, LocationID, ManagerID) VALUES ('Rupsha Bridge Plaza', 1, 2);
GO


-- Check Audit Table

SELECT * FROM PlazaAudit;
GO


/*
==============================  SECTION 07  ==============================
								  QUERY
==========================================================================
*/


--============== 7.01 A SELECT STATEMENT TO KNOW VEHICLE LIST FROM A TABLE ============--

SELECT * FROM Vehicles;
GO

--============== 7.02 A SELECT STATEMENT TO GET REVENUE INFO FROM A VIEW  ============--

SELECT * FROM v_TotalRevenue;
GO

--============== 7.03 SELECT INTO > SAVE TRANSACTION LIST TO A NEW TEMPORARY TABLE ============--

SELECT * INTO #TempTransactions FROM Transactions;
GO

SELECT * FROM #TempTransactions;
GO

--============== 7.04 IMPLICIT JOIN WITH WHERE BY CLAUSE, ORDER BY CLAUSE ============--

-- To know Vehicle Model and their Transaction Amount

SELECT V.Model, T.AmountPaid
FROM Vehicles V, Transactions T
WHERE V.VehicleRegNo = T.VehicleRegNo
ORDER BY T.AmountPaid DESC;
GO


--============== 7.05 INNER JOIN WITH GROUP BY CLAUSE ============--

-- To know Plaza Name and Total Collection

SELECT P.PlazaName, SUM(T.AmountPaid) AS TotalCollection
FROM Transactions T
INNER JOIN Plaza P ON T.PlazaID = P.PlazaID
GROUP BY P.PlazaName;
GO


--============== 7.06 OUTER JOIN ============--

-- Left Join: Show all drivers and their transactions (if any)

SELECT D.FirstName, T.TransactionID, T.AmountPaid
FROM Driver D
LEFT JOIN Transactions T ON D.DriverID = T.DriverID;
GO


--============== 7.07 CROSS JOIN ============--

-- All possible combinations of Plaza and Payment Types

SELECT P.PlazaName, PT.TypeName
FROM Plaza P
CROSS JOIN PaymentType PT;
GO

--============== 7.08 TOP CLAUSE WITH TIES ============--

-- Get the top 2 most expensive transactions (including ties)

SELECT TOP 2 WITH TIES TransactionID, AmountPaid
FROM Transactions
ORDER BY AmountPaid DESC;
GO


--============== 7.09 DISTINCT ============--

SELECT DISTINCT VehicleTypeID FROM Vehicles;
GO


--============== 7.10 COMPARISON, LOGICAL(AND OR NOT) & BETWEEN OPERATOR ============--

SELECT * FROM Transactions
WHERE AmountPaid BETWEEN 500 AND 2000
AND PaymentTypeID = 1; -- Cash
GO


--============== 7.11 LIKE, IN, NOT IN, OPERATOR & IS NULL CLAUSE ============--

SELECT * FROM Driver
WHERE FirstName LIKE 'R%' 
AND DriverID IN (1, 3);
GO

SELECT * FROM HR.Employees WHERE LastName IS NOT NULL;
GO


--============== 7.12 OFFSET FETCH ============--

-- Skip first 1 row, fetch next 2

SELECT * FROM Vehicles
ORDER BY VehicleRegNo
OFFSET 1 ROWS
FETCH NEXT 2 ROWS ONLY;
GO


--============== 7.13 UNION ============--

-- Combine Employee names and Driver names

SELECT FirstName, LastName, 'Employee' AS Type FROM HR.Employees
UNION
SELECT FirstName, LastName, 'Driver' AS Type FROM Driver;
GO


--============== 7.14 EXCEPT INTERSECT ============--

-- Drivers who are registered but haven't made a transaction

SELECT DriverID FROM Driver
EXCEPT
SELECT DriverID FROM Transactions;
GO


--============== 7.15 AGGREGATE FUNCTIONS ============--

SELECT 
    COUNT(*) AS TotalTrans,
    SUM(AmountPaid) AS TotalRevenue,
    AVG(AmountPaid) AS AvgTicketPrice,
    MAX(AmountPaid) AS MaxPaid,
    MIN(AmountPaid) AS MinPaid
FROM Transactions;
GO


--============== 7.16 GROUP BY & HAVING CLAUSE ============--

-- Plazas that have collected more than 1000 total

SELECT P.PlazaName, SUM(T.AmountPaid) AS Total
FROM Transactions T
JOIN Plaza P ON T.PlazaID = P.PlazaID
GROUP BY P.PlazaName
HAVING SUM(T.AmountPaid) > 1000;
GO


--============== 7.17 ROLLUP & CUBE OPERATOR ============--

-- Rollup provides subtotals for Plaza and Payment Type

SELECT PlazaID, PaymentTypeID, SUM(AmountPaid) AS Total
FROM Transactions
GROUP BY ROLLUP (PlazaID, PaymentTypeID);
GO


--============== 7.18 GROUPING SETS ============--

SELECT PlazaID, PaymentTypeID, SUM(AmountPaid) AS Total
FROM Transactions
GROUP BY GROUPING SETS (
    (PlazaID, PaymentTypeID),
    (PlazaID),
    ()
);
GO


--============== 7.19 SUB-QUERIES (INNER, CORRELATED) ============--

-- Inner: Vehicles that paid more than average

SELECT VehicleRegNo 
FROM Transactions 
WHERE AmountPaid > (SELECT AVG(AmountPaid) FROM Transactions);
GO

-- Correlated: Drivers who have made at least one transaction

SELECT FirstName 
FROM Driver D
WHERE EXISTS (SELECT 1 FROM Transactions T WHERE T.DriverID = D.DriverID);
GO


--============== 7.20 EXISTS ============--

SELECT * FROM Plaza P
WHERE EXISTS (SELECT 1 FROM Location L WHERE L.LocationID = P.LocationID AND L.LocationName LIKE '%Bridge%');
GO


--============== 7.21 CTE ============--

WITH PlazaRevenue_CTE AS (
    SELECT PlazaID, SUM(AmountPaid) as Total
    FROM Transactions
    GROUP BY PlazaID
)
SELECT P.PlazaName, CTE.Total
FROM Plaza P
JOIN PlazaRevenue_CTE CTE ON P.PlazaID = CTE.PlazaID;
GO


--============== 7.22 BUILT IN FUNCTION ============--

-- 1. Date

SELECT GETDATE();
GO

-- 2. String

SELECT UPPER(PlazaName) FROM Plaza;
GO

-- 3. String Length

SELECT LEN(FirstName) FROM Driver;
GO

-- 4. Conversion

SELECT CAST(AmountPaid AS VARCHAR) + ' Taka' FROM Transactions;
GO

-- 5. Math

SELECT ABS(-500);
GO

-- 6. Date Part

SELECT YEAR(GETDATE());
GO

-- 7. Format

SELECT FORMAT(GETDATE(), 'dd/MM/yyyy');
GO


--============== 7.23 CASE ============--

SELECT VehicleRegNo, AmountPaid,
CASE 
    WHEN AmountPaid >= 1000 THEN 'Heavy Vehicle'
    WHEN AmountPaid >= 500 THEN 'Medium Vehicle'
    ELSE 'Light Vehicle'
END AS VehicleClass
FROM Transactions;
GO


--============== 7.24 IIF ============--

SELECT PlazaName, IIF(IsActive = 1, 'Open', 'Closed') AS Status FROM Plaza;
GO


--============== 7.25 COALESCE & ISNULL ============--

SELECT FirstName, ISNULL(ContactNumber, 'No Phone') FROM Driver;
GO

SELECT COALESCE(Email, ContactNumber, 'No Contact Info') FROM HR.Employees;
GO


--============== 7.26 WHILE ============--

DECLARE @Counter INT = 1;
WHILE @Counter <= 5
BEGIN
    PRINT 'Processing Log #' + CAST(@Counter AS VARCHAR);
    SET @Counter = @Counter + 1;
END
GO


--============== 7.27 GROUPING FUNCTION ============--

SELECT 
    PlazaID, 
    SUM(AmountPaid) AS Total,
    GROUPING(PlazaID) AS IsGrandTotal
FROM Transactions
GROUP BY ROLLUP(PlazaID);
GO


--============== 7.28 RANKING FUNCTION ============--

SELECT 
    VehicleRegNo, 
    AmountPaid,
    RANK() OVER (ORDER BY AmountPaid DESC) AS RankVal,
    DENSE_RANK() OVER (ORDER BY AmountPaid DESC) AS DenseRankVal,
    ROW_NUMBER() OVER (ORDER BY AmountPaid DESC) AS RowNum
FROM Transactions;
GO


--============== 7.29 IF ELSE & PRINT ============--

DECLARE @TotalRev MONEY;
SELECT @TotalRev = SUM(AmountPaid) FROM Transactions;

IF @TotalRev > 10000
    PRINT 'Target Achieved!';
ELSE
    PRINT 'Target Not Achieved.';
GO

--============== 7.30 TRY CATCH ============--

BEGIN TRY

    -- Division by zero error

    SELECT 100/0;
END TRY
BEGIN CATCH
    PRINT 'Error Line: ' + CAST(ERROR_LINE() AS VARCHAR);
    PRINT 'Error Message: ' + ERROR_MESSAGE();
END CATCH
GO

--============== 7.31 GOTO ============--

DECLARE @Val INT = 1;
IF @Val = 1 GOTO JumpLabel;
GO

PRINT 'This will be skipped';
GO

JumpLabel:
PRINT 'Jumped to Label';
GO

--============== 7.32 WAITFOR ============--

-- Wait for 2 seconds
WAITFOR DELAY '00:00:02';
PRINT 'Resumed after 2 seconds';
GO

--============== 7.33 sp_helptext ============--

EXEC sp_helptext 'v_TotalRevenue';
GO

--============== 7.34 TRANSACTION WITH SAVE POINT ============--

BEGIN TRANSACTION;
    INSERT INTO VehicleType (TypeName) VALUES ('TestType1');
    SAVE TRANSACTION SavePoint1;
    GO

    INSERT INTO VehicleType (TypeName) VALUES ('TestType2');
    GO

    -- Rollback to SavePoint1 (TestType2 will be undone, TestType1 remains)

    ROLLBACK TRANSACTION SavePoint1;
	GO

COMMIT TRANSACTION;
GO

SELECT * FROM VehicleType WHERE TypeName LIKE 'Test%';
GO