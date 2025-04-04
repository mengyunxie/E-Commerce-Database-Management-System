-- ========================================
-- StoredProcedure.sql - Inserts a new order into the ShopOrder table
-- Team: 3
-- E-Commerce Database Management System
-- ========================================

USE E_COMMERCE;


-- Insert ShopOrder data
CREATE PROCEDURE sp_InsertShopOrder
    @OrderID INT, 
    @CustomerID INT,
	@AddressID INT,
	@PaymentID INT,
	@OrderStatusID INT,
	@ShippingMethodID INT,
	@OrderTotal DECIMAL,
	@OrderDate DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if OrderID already exists
    IF EXISTS (SELECT 1 FROM ShopOrder WHERE OrderID = @OrderID)
    BEGIN
        PRINT 'Error: OrderID already exists.'
        RETURN;
    END

    -- Validate CustomerID exists in Customer table
    IF NOT EXISTS (SELECT 1 FROM Customer WHERE CustomerID = @CustomerID)
    BEGIN
        PRINT 'Error: Invalid CustomerID.'
        RETURN;
    END

    -- Validate AddressID exists in Address table
    IF NOT EXISTS (SELECT 1 FROM Address WHERE AddressID = @AddressID)
    BEGIN
        PRINT 'Error: Invalid AddressID.'
        RETURN;
    END
    
    -- Validate Address belongs to Customer
    IF NOT EXISTS (SELECT 1 FROM CustomerAddress WHERE CustomerID = @CustomerID AND AddressID = @AddressID)
    BEGIN
   		PRINT 'Error: Address does not belong to this customer.'
       	RETURN;
    END

    -- Validate PaymentID exists in PaymentMethod table
    IF NOT EXISTS (SELECT 1 FROM PaymentMethod WHERE PaymentMethodID = @PaymentID)
    BEGIN
        PRINT 'Error: Invalid PaymentID.'
        RETURN;
    END
    
    -- Validate Payment Method belongs to Customer
    IF NOT EXISTS (SELECT 1 FROM PaymentMethod WHERE PaymentMethodID = @PaymentID AND CustomerID = @CustomerID)
    BEGIN
        PRINT 'Error: Payment method does not belong to this customer.'
        RETURN;
    END
    
    
    -- Validate Payment Method is not expired
    IF EXISTS (SELECT 1 FROM PaymentMethod WHERE PaymentMethodID = @PaymentID AND ExpirationDate < @OrderDate)
    BEGIN
        PRINT 'Error: Payment method has expired.'
        RETURN;
    END

    -- Validate OrderStatusID exists in OrderStatus table
    IF NOT EXISTS (SELECT 1 FROM OrderStatus WHERE OrderStatusID = @OrderStatusID)
    BEGIN
        PRINT 'Error: Invalid OrderStatusID.'
        RETURN;
    END

    -- Validate ShippingMethodID exists in ShippingMethod table
    IF NOT EXISTS (SELECT 1 FROM ShippingMethod WHERE ShippingMethodID = @ShippingMethodID)
    BEGIN
        PRINT 'Error: Invalid ShippingMethodID.'
        RETURN;
    END

    -- Check if OrderDate is reasonable (cannot be in the future)
    IF @OrderDate > GETDATE()
    BEGIN
        PRINT 'Error: OrderDate cannot be in the future.'
        RETURN;
    END

    
    -- Declare the variable @ShippingCost
	DECLARE @ShippingCost DECIMAL(10, 2);

    -- Retrieve shipping cost from ShippingMethod table for initial OrderTotal
    SELECT @ShippingCost = Price 
    FROM ShippingMethod 
    WHERE ShippingMethodID = @ShippingMethodID;
    
    -- Set initial OrderTotal to shipping cost (order lines will be added later)
    SET @OrderTotal = @ShippingCost;
     
    -- Insert the ShopOrder record with initial OrderTotal
    INSERT INTO ShopOrder (
        OrderID,
        CustomerID,
        AddressID,
        PaymentID,
        OrderStatusID,
        ShippingMethodID,
        OrderTotal,
        OrderDate
    )
    VALUES (
        @OrderID,
        @CustomerID,
        @AddressID,
        @PaymentID,
        @OrderStatusID,
        @ShippingMethodID,
        @OrderTotal,
        @OrderDate
    );

    PRINT 'ShopOrder inserted successfully with OrderTotal: ' + CAST(@OrderTotal AS VARCHAR);
END;


-- Example of how to use the stored procedure:
EXEC sp_InsertShopOrder
	@OrderID = 5037, 
    @CustomerID = 1015,
	@AddressID = 5028,
	@PaymentID = 8028,
	@OrderStatusID = 304,
	@ShippingMethodID = 204,
	@OrderTotal = 0,
	@OrderDate = '2025-01-24';