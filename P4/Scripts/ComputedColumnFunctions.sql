-- ========================================
-- ComputedColumnFunctions.sql - Computed Columns based on functions
-- Team: 3
-- E-Commerce Database Management System
-- ========================================

USE E_COMMERCE;

-- Function: Get the full name of a customer
CREATE FUNCTION dbo.GetCustomerFullName (@CustomerID INT)
RETURNS VARCHAR(201)
AS
BEGIN
    DECLARE @FullName VARCHAR(201);

    SELECT @FullName = FirstName + ' ' + LastName
    FROM Customer
    WHERE CustomerID = @CustomerID;

    RETURN @FullName;
END;
-- Use Case:
SELECT dbo.GetCustomerFullName(1001) AS FullName;

-- Function: Formatted a Customer's Address to (AddressLine1, City, State, PostalCode)
CREATE FUNCTION dbo.GetCustomerFormattedAddress (@CustomerID INT)
RETURNS VARCHAR(512)
AS
BEGIN
    DECLARE @FormattedAddress VARCHAR(512);

    SELECT @FormattedAddress = 
        A.AddressLine1 + ', ' + A.City + ', ' + A.State + ' ' + A.PostalCode
    FROM CustomerAddress CA
    JOIN Address A ON CA.AddressID = A.AddressID
    WHERE CA.CustomerID = @CustomerID AND CA.IsDefault = 1;

    RETURN @FormattedAddress;
END;
--Use Case 1:
SELECT 
    CustomerID,
    dbo.GetCustomerFormattedAddress(CustomerID) AS DefaultAddress
FROM Customer;
--Use Case 2:
SELECT dbo.GetCustomerFormattedAddress(1001) AS FULLAddress;


-- Function: Get Total Stock for a Product
CREATE FUNCTION dbo.GetTotalStock (@ProductID INT)
RETURNS INT
AS
BEGIN
    DECLARE @TotalStock INT;

    SELECT @TotalStock = SUM(StockQuantity)
    FROM ProductItem
    WHERE ProductID = @ProductID;

    RETURN ISNULL(@TotalStock, 0);  -- return 0 if no matching items
END;
-- Use Case:
SELECT dbo.GetTotalStock(2001) AS TotalStock;

-- Function: Get stock status (like “Low Stock”, “Out of Stock”)
CREATE FUNCTION dbo.GetStockStatus (@ProductID INT)
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @TotalStock INT;

    SELECT @TotalStock = SUM(StockQuantity)
    FROM ProductItem
    WHERE ProductID = @ProductID;

    SET @TotalStock = ISNULL(@TotalStock, 0);

    RETURN
        CASE 
            WHEN @TotalStock = 0 THEN 'Out of Stock'
            WHEN @TotalStock < 10 THEN 'Low Stock'
            ELSE 'In Stock'
        END;
END;
-- Use Case:
SELECT 
    P.ProductID,
    P.ProductName,
    dbo.GetTotalStock(P.ProductID) AS TotalStock,
    dbo.GetStockStatus(P.ProductID) AS StockStatus
FROM Product P;

-- Function: Get Top 5 Best seller
CREATE FUNCTION dbo.GetTop5BestSellers()
RETURNS TABLE
AS
RETURN
(
    SELECT TOP 5 
        P.ProductID,
        P.ProductName,
        SUM(OL.Quantity) AS TotalSold
    FROM OrderLine OL
    JOIN ProductItem PI ON OL.ProductItemID = PI.ProductItemID
    JOIN Product P ON PI.ProductID = P.ProductID
    GROUP BY P.ProductID, P.ProductName
    ORDER BY TotalSold DESC
);
-- Use Case:
SELECT * FROM dbo.GetTop5BestSellers();

-- Calculates the Grand Total for a given OrderID, applying any coupon discounts on individual order lines if applicable
CREATE FUNCTION dbo.GetOrderGrandTotal (@OrderID INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @Total DECIMAL(10, 2);

    SELECT @Total = SUM(
        OL.Price * OL.Quantity * 
        (1 - ISNULL(C.DiscountRate, 0) / 100.0)
    )
    FROM OrderLine OL
    LEFT JOIN Coupon C ON OL.CouponID = C.CouponID
    WHERE OL.OrderID = @OrderID;

    RETURN ISNULL(@Total, 0);
END;
--Use Case:
SELECT dbo.GetOrderGrandTotal(5000) AS GrandTotal;

-- Get all unsolved ticket
CREATE FUNCTION dbo.GetUnsolvedTickets()
RETURNS TABLE
AS
RETURN
(
    SELECT 
        CST.TicketID,
        CST.CustomerID,
        C.FirstName + ' ' + C.LastName AS CustomerName,
        CST.IssueDescription,
        TS.Status AS TicketStatus,
        CST.CreatedDate
    FROM CustomerSupportTicket CST
    JOIN TicketStatus TS ON CST.TicketStatusID = TS.TicketStatusID
    JOIN Customer C ON CST.CustomerID = C.CustomerID
    WHERE TS.Status NOT IN ('Cancelled', 'Closed', 'Invalid')
);
--Use Case:
SELECT * FROM dbo.GetUnsolvedTickets();






