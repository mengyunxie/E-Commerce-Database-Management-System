-- ========================================
-- StoredProcedure.sql - Stored Procedure
-- Team: 3
-- E-Commerce Database Management System
-- ========================================

USE E_COMMERCE;

/*
 * Stored Procedure for Insert ShopOrder
 * Insert ShopOrder data
 */
CREATE PROCEDURE InsertShopOrder
    @OrderID INT = NULL,           -- Optional parameter, can be NULL 
    @CustomerID INT,
	@AddressID INT,
	@PaymentID INT,
	@OrderStatusID INT,
	@ShippingMethodID INT,
	@OrderDate DATETIME = NULL    -- Optional parameter, can be NULL 
AS
BEGIN
    SET NOCOUNT ON;

	-- If OrderID is NULL, generate a new one
        IF @OrderID IS NULL
        BEGIN
            SELECT @OrderID = ISNULL(MAX(OrderID), 0) + 1 FROM ShopOrder;
        END
        
    -- If OrderDate is NULL, generate a new one
        IF @OrderDate IS NULL
        BEGIN
            SELECT @OrderDate = GETDATE();  -- Gets the current system date and time
        END

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
        0,
        @OrderDate
    );

    PRINT 'ShopOrder inserted successfully with OrderID: ' + CAST(@OrderID AS VARCHAR);
END;

--Example of Insert data by InsertShopOrder
EXEC InsertShopOrder
    @CustomerID = 1015,
	@AddressID = 5028,
	@PaymentID = 8028,
	@OrderStatusID = 304,
	@ShippingMethodID = 204;



/*
 * Stored Procedure for Insert OrderLine
 * Insert OrderLine data
 */ 
CREATE PROCEDURE InsertOrderLine
    @OrderLineID INT = NULL,           -- Optional parameter, can be NULL
    @OrderID INT,                      -- Required: The order this line belongs to
    @ProductItemID INT,                -- Required: The product being ordered
    @Quantity INT,                     -- Required: Quantity of the item
    @CouponID INT = NULL               -- Optional: Coupon applied to this line item
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- If OrderLineID is NULL, generate a new one
        IF @OrderLineID IS NULL
        BEGIN
            SELECT @OrderLineID = ISNULL(MAX(OrderLineID), 0) + 1 FROM OrderLine;
        END
        
        -- Validate that the OrderID exists in the ShopOrder table
        IF NOT EXISTS (SELECT 1 FROM ShopOrder WHERE OrderID = @OrderID)
        BEGIN
            PRINT 'Error: The specified OrderID does not exist.'
        	RETURN;
        END
        
        -- Validate that the ProductItemID exists in the ProductItem table
        IF NOT EXISTS (SELECT 1 FROM ProductItem WHERE ProductItemID = @ProductItemID)
        BEGIN
            PRINT 'Error: The specified ProductItemID does not exist.'
            RETURN;
        END
        
        -- Validate that the CouponID exists in the Coupon table if provided
        IF @CouponID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Coupon WHERE CouponID = @CouponID)
        BEGIN
            PRINT 'Error: The specified CouponID does not exist.'
            RETURN;
        END
        
        -- Check if there's enough stock
        DECLARE @AvailableStock INT;
        SELECT @AvailableStock = StockQuantity 
        FROM ProductItem 
        WHERE ProductItemID = @ProductItemID;
        
        IF ISNULL(@AvailableStock, 0) < @Quantity
        BEGIN
            PRINT 'Error: Not enough stock available for this product.'
            RETURN;
        END
        

        -- Insert into OrderLine with Price = 0, actual value will be updated by trigger
        INSERT INTO OrderLine (OrderLineID, OrderID, ProductItemID, Quantity, Price, CouponID)
        VALUES (@OrderLineID, @OrderID, @ProductItemID, @Quantity, 0, @CouponID);
        PRINT 'OrderLine inserted successfully with OrderLineID: ' + CAST(@OrderLineID AS VARCHAR);
        
        -- Update the product stock quantity
        UPDATE ProductItem
        SET StockQuantity = StockQuantity - @Quantity
        WHERE ProductItemID = @ProductItemID;
        PRINT 'ProductItem updated successfully with ProductItemID: ' + CAST(@ProductItemID AS VARCHAR);
    END TRY
    BEGIN CATCH
        PRINT 'Error inserting into OrderLine';
        THROW;
    END CATCH
END;

--Example of Insert data by InsertOrderLine
EXEC InsertOrderLine 
    @OrderID = 5036, 
    @ProductItemID = 20071, 
    @Quantity = 1, 
    @CouponID = 407;


/*
 * Stored Procedure for Stock Management
 * Delete OrderLine data
 */
CREATE PROCEDURE DeleteOrderLine
    @OrderLineID INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        DECLARE @ProductItemID INT, @Quantity INT;

        -- Get ProductItemID and Quantity for the line to be deleted
        SELECT @ProductItemID = ProductItemID,
               @Quantity = Quantity
        FROM OrderLine
        WHERE OrderLineID = @OrderLineID;

        -- If OrderLine doesn't exist, abort
        IF @ProductItemID IS NULL
        BEGIN
            PRINT 'Error: The specified OrderLineID does not exist.';
            RETURN;
        END

        -- Delete the order line
        DELETE FROM OrderLine WHERE OrderLineID = @OrderLineID;
        PRINT 'OrderLine deleted successfully with OrderLineID: ' + CAST(@OrderLineID AS VARCHAR);

        -- Restore stock
        UPDATE ProductItem
        SET StockQuantity = StockQuantity + @Quantity
        WHERE ProductItemID = @ProductItemID;
        PRINT 'ProductItem updated successfully with ProductItemID: ' + CAST(@ProductItemID AS VARCHAR);
    END TRY
    BEGIN CATCH
        PRINT 'Error deleting order line.';
        THROW;
    END CATCH
END;

--Example of Delete data by DeleteOrderLine
EXEC DeleteOrderLine @OrderLineID = 7102;
