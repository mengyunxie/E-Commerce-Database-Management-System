-- ======================================================================
-- E-COMMERCE DATABASE STORED PROCEDURES FOR DATA INSERTION
-- ======================================================================
-- This file contains stored procedures to help populate the E-Commerce Database
-- with data. Each procedure handles validation, error handling, and related
-- operations for inserting data into the database.

USE E_Commerce_Database_Management_System;
GO

-- ======================================================================
-- SECTION 1: BASIC LOOKUP DATA INSERTION
-- ======================================================================

-- Insert Country data
CREATE PROCEDURE sp_InsertCountry
    @CountryName VARCHAR(100),
    @CountryID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Check if country already exists
    IF EXISTS (SELECT 1 FROM Country WHERE CountryName = @CountryName)
    BEGIN
        SELECT @CountryID = CountryID FROM Country WHERE CountryName = @CountryName;
        RETURN;
    END
    
    -- Get the next available ID if not provided
    DECLARE @NextID INT;
    SELECT @NextID = ISNULL(MAX(CountryID), 0) + 1 FROM Country;
    
    -- Insert the new country
    INSERT INTO Country (CountryID, CountryName)
    VALUES (@NextID, @CountryName);
    
    SET @CountryID = @NextID;
END
GO

-- Insert Category with hierarchical support
CREATE PROCEDURE sp_InsertCategory
    @CategoryName VARCHAR(100),
    @ParentCategoryID INT = NULL,
    @CategoryID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Check if category already exists
    IF EXISTS (SELECT 1 FROM Category WHERE CategoryName = @CategoryName AND 
              ((@ParentCategoryID IS NULL AND ParentCategoryID IS NULL) OR 
               ParentCategoryID = @ParentCategoryID))
    BEGIN
        SELECT @CategoryID = CategoryID FROM Category 
        WHERE CategoryName = @CategoryName AND 
              ((@ParentCategoryID IS NULL AND ParentCategoryID IS NULL) OR 
               ParentCategoryID = @ParentCategoryID);
        RETURN;
    END
    
    -- Validate parent category if provided
    IF @ParentCategoryID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Category WHERE CategoryID = @ParentCategoryID)
    BEGIN
        RAISERROR('Parent category does not exist', 16, 1);
        RETURN;
    END
    
    -- Get the next available ID
    DECLARE @NextID INT;
    SELECT @NextID = ISNULL(MAX(CategoryID), 0) + 1 FROM Category;
    
    -- Insert the new category
    INSERT INTO Category (CategoryID, ParentCategoryID, CategoryName)
    VALUES (@NextID, @ParentCategoryID, @CategoryName);
    
    SET @CategoryID = @NextID;
END
GO

-- Insert Payment Type
CREATE PROCEDURE sp_InsertPaymentType
    @Value VARCHAR(50),
    @PaymentTypeID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Check if payment type already exists
    IF EXISTS (SELECT 1 FROM PaymentType WHERE Value = @Value)
    BEGIN
        SELECT @PaymentTypeID = PaymentTypeID FROM PaymentType WHERE Value = @Value;
        RETURN;
    END
    
    -- Get the next available ID
    DECLARE @NextID INT;
    SELECT @NextID = ISNULL(MAX(PaymentTypeID), 0) + 1 FROM PaymentType;
    
    -- Insert the payment type
    INSERT INTO PaymentType (PaymentTypeID, Value)
    VALUES (@NextID, @Value);
    
    SET @PaymentTypeID = @NextID;
END
GO

-- Insert Shipping Method
CREATE PROCEDURE sp_InsertShippingMethod
    @ShippingMethodName VARCHAR(100),
    @Price DECIMAL(10,2),
    @ShippingMethodID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Check if shipping method already exists
    IF EXISTS (SELECT 1 FROM ShippingMethod WHERE ShippingMethodName = @ShippingMethodName)
    BEGIN
        SELECT @ShippingMethodID = ShippingMethodID FROM ShippingMethod 
        WHERE ShippingMethodName = @ShippingMethodName;
        RETURN;
    END
    
    -- Get the next available ID
    DECLARE @NextID INT;
    SELECT @NextID = ISNULL(MAX(ShippingMethodID), 0) + 1 FROM ShippingMethod;
    
    -- Insert the shipping method
    INSERT INTO ShippingMethod (ShippingMethodID, ShippingMethodName, Price)
    VALUES (@NextID, @ShippingMethodName, @Price);
    
    SET @ShippingMethodID = @NextID;
END
GO

-- Insert Order Status
CREATE PROCEDURE sp_InsertOrderStatus
    @Status VARCHAR(100),
    @OrderStatusID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Check if order status already exists
    IF EXISTS (SELECT 1 FROM OrderStatus WHERE Status = @Status)
    BEGIN
        SELECT @OrderStatusID = OrderStatusID FROM OrderStatus WHERE Status = @Status;
        RETURN;
    END
    
    -- Get the next available ID
    DECLARE @NextID INT;
    SELECT @NextID = ISNULL(MAX(OrderStatusID), 0) + 1 FROM OrderStatus;
    
    -- Insert the order status
    INSERT INTO OrderStatus (OrderStatusID, Status)
    VALUES (@NextID, @Status);
    
    SET @OrderStatusID = @NextID;
END
GO

-- Insert Ticket Status
CREATE PROCEDURE sp_InsertTicketStatus
    @Status VARCHAR(100),
    @TicketStatusID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Check if ticket status already exists
    IF EXISTS (SELECT 1 FROM TicketStatus WHERE Status = @Status)
    BEGIN
        SELECT @TicketStatusID = TicketStatusID FROM TicketStatus WHERE Status = @Status;
        RETURN;
    END
    
    -- Get the next available ID
    DECLARE @NextID INT;
    SELECT @NextID = ISNULL(MAX(TicketStatusID), 0) + 1 FROM TicketStatus;
    
    -- Insert the ticket status
    INSERT INTO TicketStatus (TicketStatusID, Status)
    VALUES (@NextID, @Status);
    
    SET @TicketStatusID = @NextID;
END
GO

-- ======================================================================
-- SECTION 2: CUSTOMER & ADDRESS MANAGEMENT
-- ======================================================================


-- Insert Customer with Password Encryption
CREATE PROCEDURE sp_InsertCustomer
    @FirstName VARCHAR(100),
    @LastName VARCHAR(100),
    @CustomerName VARCHAR(100),
    @Password VARCHAR(100),
    @Email VARCHAR(255),
    @PhoneNumber VARCHAR(20),
    @CustomerID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validate inputs
    IF @FirstName IS NULL OR @LastName IS NULL OR @CustomerName IS NULL OR 
       @Password IS NULL OR @Email IS NULL
    BEGIN
        RAISERROR('Required fields cannot be NULL', 16, 1);
        RETURN;
    END
    
    -- Validate email format
    IF dbo.fn_IsValidEmail(@Email) = 0
    BEGIN
        RAISERROR('Invalid email format', 16, 1);
        RETURN;
    END
    
    -- Check if email already exists
    IF EXISTS (SELECT 1 FROM Customer WHERE Email = @Email)
    BEGIN
        RAISERROR('Email address already registered', 16, 1);
        RETURN;
    END
    
    -- Validate password complexity
    IF dbo.fn_IsValidPassword(@Password) = 0
    BEGIN
        RAISERROR('Password does not meet complexity requirements', 16, 1);
        RETURN;
    END
    
    -- Encrypt password
    -- In a real system, use a stronger encryption method and salting
    DECLARE @EncryptedPassword VARBINARY(255);
    
    -- Enable advanced options to create certificates (might need admin rights)
    -- EXEC sp_configure 'show advanced options', 1;
    -- RECONFIGURE;
    -- EXEC sp_configure 'Ole Automation Procedures', 1;
    -- RECONFIGURE;
    
    -- Simple encryption for demo purposes - replace with proper encryption in production
    SET @EncryptedPassword = HASHBYTES('SHA2_256', @Password);
    
    -- Get the next available ID
    DECLARE @NextID INT;
    SELECT @NextID = ISNULL(MAX(CustomerID), 0) + 1 FROM Customer;
    
    -- Insert the customer
    INSERT INTO Customer (
        CustomerID,
        FirstName, 
        LastName, 
        CustomerName, 
        EncryptedPassword, 
        Email, 
        PhoneNumber, 
        RegistrationDate
    )
    VALUES (
        @NextID,
        @FirstName, 
        @LastName, 
        @CustomerName, 
        @EncryptedPassword, 
        @Email, 
        @PhoneNumber, 
        GETDATE()
    );
    
    SET @CustomerID = @NextID;
END
GO

-- Insert Address
CREATE PROCEDURE sp_InsertAddress
    @UnitNumber VARCHAR(10) = NULL,
    @StreetNumber VARCHAR(10),
    @AddressLine1 VARCHAR(255),
    @AddressLine2 VARCHAR(255) = NULL,
    @City VARCHAR(100),
    @State VARCHAR(100),
    @PostalCode VARCHAR(20),
    @CountryID INT,
    @AddressID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validate required fields
    IF @StreetNumber IS NULL OR @AddressLine1 IS NULL OR @City IS NULL OR 
       @State IS NULL OR @PostalCode IS NULL
    BEGIN
        RAISERROR('Required address fields cannot be NULL', 16, 1);
        RETURN;
    END
    
    -- Validate country exists
    IF NOT EXISTS (SELECT 1 FROM Country WHERE CountryID = @CountryID)
    BEGIN
        RAISERROR('Invalid country ID', 16, 1);
        RETURN;
    END
    
    -- Validate postal code format
    IF dbo.fn_IsValidPostalCode(@PostalCode, @CountryID) = 0
    BEGIN
        RAISERROR('Invalid postal code format for the specified country', 16, 1);
        RETURN;
    END
    
    -- Check if address already exists to avoid duplication
    IF EXISTS (
        SELECT 1 FROM Address 
        WHERE ISNULL(UnitNumber, '') = ISNULL(@UnitNumber, '')
        AND StreetNumber = @StreetNumber
        AND AddressLine1 = @AddressLine1
        AND ISNULL(AddressLine2, '') = ISNULL(@AddressLine2, '')
        AND City = @City
        AND State = @State
        AND PostalCode = @PostalCode
        AND CountryID = @CountryID
    )
    BEGIN
        -- Return existing address ID
        SELECT @AddressID = AddressID 
        FROM Address 
        WHERE ISNULL(UnitNumber, '') = ISNULL(@UnitNumber, '')
        AND StreetNumber = @StreetNumber
        AND AddressLine1 = @AddressLine1
        AND ISNULL(AddressLine2, '') = ISNULL(@AddressLine2, '')
        AND City = @City
        AND State = @State
        AND PostalCode = @PostalCode
        AND CountryID = @CountryID;
        
        RETURN;
    END
    
    -- Get the next available ID
    DECLARE @NextID INT;
    SELECT @NextID = ISNULL(MAX(AddressID), 0) + 1 FROM Address;
    
    -- Insert the address
    INSERT INTO Address (
        AddressID,
        UnitNumber, 
        StreetNumber, 
        AddressLine1, 
        AddressLine2, 
        City, 
        State, 
        PostalCode, 
        CountryID
    )
    VALUES (
        @NextID,
        @UnitNumber, 
        @StreetNumber, 
        @AddressLine1, 
        @AddressLine2, 
        @City, 
        @State, 
        @PostalCode, 
        @CountryID
    );
    
    SET @AddressID = @NextID;
END
GO

-- Link Customer to Address
CREATE PROCEDURE sp_LinkCustomerAddress
    @CustomerID INT,
    @AddressID INT,
    @IsDefault BIT = 0
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validate customer exists
    IF NOT EXISTS (SELECT 1 FROM Customer WHERE CustomerID = @CustomerID)
    BEGIN
        RAISERROR('Invalid customer ID', 16, 1);
        RETURN;
    END
    
    -- Validate address exists
    IF NOT EXISTS (SELECT 1 FROM Address WHERE AddressID = @AddressID)
    BEGIN
        RAISERROR('Invalid address ID', 16, 1);
        RETURN;
    END
    
    -- Check if this customer-address link already exists
    IF EXISTS (SELECT 1 FROM CustomerAddress WHERE CustomerID = @CustomerID AND AddressID = @AddressID)
    BEGIN
        -- Update the default status if needed
        IF @IsDefault = 1
        BEGIN
            -- First, set all addresses for this customer to non-default
            UPDATE CustomerAddress
            SET IsDefault = 0
            WHERE CustomerID = @CustomerID;
            
            -- Then set this one as default
            UPDATE CustomerAddress
            SET IsDefault = 1
            WHERE CustomerID = @CustomerID AND AddressID = @AddressID;
        END
        
        RETURN;
    END
    
    -- If this will be the default address, update existing defaults
    IF @IsDefault = 1
    BEGIN
        UPDATE CustomerAddress
        SET IsDefault = 0
        WHERE CustomerID = @CustomerID;
    END
    
    -- If this is the customer's first address, make it default regardless
    IF NOT EXISTS (SELECT 1 FROM CustomerAddress WHERE CustomerID = @CustomerID)
    BEGIN
        SET @IsDefault = 1;
    END
    
    -- Insert the customer-address link
    INSERT INTO CustomerAddress (CustomerID, AddressID, IsDefault)
    VALUES (@CustomerID, @AddressID, @IsDefault);
END
GO

-- Insert Payment Method for Customer
CREATE PROCEDURE sp_InsertPaymentMethod
    @CustomerID INT,
    @PaymentTypeID INT,
    @Provider VARCHAR(100),
    @AccountNumber VARCHAR(100),
    @ExpirationDate DATE,
    @IsDefault BIT = 0,
    @PaymentMethodID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validate required fields
    IF @CustomerID IS NULL OR @PaymentTypeID IS NULL OR @Provider IS NULL OR 
       @AccountNumber IS NULL OR @ExpirationDate IS NULL
    BEGIN
        RAISERROR('Required payment fields cannot be NULL', 16, 1);
        RETURN;
    END
    
    -- Validate customer exists
    IF NOT EXISTS (SELECT 1 FROM Customer WHERE CustomerID = @CustomerID)
    BEGIN
        RAISERROR('Invalid customer ID', 16, 1);
        RETURN;
    END
    
    -- Validate payment type exists
    IF NOT EXISTS (SELECT 1 FROM PaymentType WHERE PaymentTypeID = @PaymentTypeID)
    BEGIN
        RAISERROR('Invalid payment type ID', 16, 1);
        RETURN;
    END
    
    -- Validate expiration date is in the future
    IF @ExpirationDate <= GETDATE()
    BEGIN
        RAISERROR('Expiration date must be in the future', 16, 1);
        RETURN;
    END
    
    -- Get the next available ID
    DECLARE @NextID INT;
    SELECT @NextID = ISNULL(MAX(PaymentMethodID), 0) + 1 FROM PaymentMethod;
    
    -- If this will be the default payment method, update existing defaults
    IF @IsDefault = 1
    BEGIN
        UPDATE PaymentMethod
        SET IsDefault = 0
        WHERE CustomerID = @CustomerID;
    END
    
    -- If this is the customer's first payment method, make it default regardless
    IF NOT EXISTS (SELECT 1 FROM PaymentMethod WHERE CustomerID = @CustomerID)
    BEGIN
        SET @IsDefault = 1;
    END
    
    -- Mask account number for security (store only last 4 digits)
    DECLARE @MaskedAccountNumber VARCHAR(100);
    SET @MaskedAccountNumber = '************' + RIGHT(@AccountNumber, 4);
    
    -- Insert the payment method
    INSERT INTO PaymentMethod (
        PaymentMethodID,
        CustomerID,
        PaymentTypeID,
        Provider,
        AccountNumber,
        ExpirationDate,
        IsDefault
    )
    VALUES (
        @NextID,
        @CustomerID,
        @PaymentTypeID,
        @Provider,
        @MaskedAccountNumber,
        @ExpirationDate,
        @IsDefault
    );
    
    SET @PaymentMethodID = @NextID;
END
GO

-- ======================================================================
-- SECTION 3: PRODUCT MANAGEMENT
-- ======================================================================

-- Insert Product
CREATE PROCEDURE sp_InsertProduct
    @CategoryID INT,
    @ProductName VARCHAR(255),
    @Description VARCHAR(MAX),
    @ImageURL VARCHAR(255) = NULL,
    @ProductID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validate required fields
    IF @CategoryID IS NULL OR @ProductName IS NULL
    BEGIN
        RAISERROR('Category ID and Product Name are required', 16, 1);
        RETURN;
    END
    
    -- Validate category exists
    IF NOT EXISTS (SELECT 1 FROM Category WHERE CategoryID = @CategoryID)
    BEGIN
        RAISERROR('Invalid category ID', 16, 1);
        RETURN;
    END
    
    -- Check if product with same name in same category already exists
    IF EXISTS (SELECT 1 FROM Product WHERE ProductName = @ProductName AND CategoryID = @CategoryID)
    BEGIN
        RAISERROR('A product with this name already exists in the specified category', 16, 1);
        RETURN;
    END
    
    -- Get the next available ID
    DECLARE @NextID INT;
    SELECT @NextID = ISNULL(MAX(ProductID), 0) + 1 FROM Product;
    
    -- Insert the product
    INSERT INTO Product (
        ProductID,
        CategoryID,
        ProductName,
        Description,
        ImageURL
    )
    VALUES (
        @NextID,
        @CategoryID,
        @ProductName,
        @Description,
        @ImageURL
    );
    
    SET @ProductID = @NextID;
END
GO

-- Insert Product Item (Variant)
CREATE PROCEDURE sp_InsertProductItem
    @ProductID INT,
    @Price DECIMAL(10,2),
    @SKU VARCHAR(100),
    @StockQuantity INT,
    @ProductItemID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validate required fields
    IF @ProductID IS NULL OR @Price IS NULL OR @SKU IS NULL OR @StockQuantity IS NULL
    BEGIN
        RAISERROR('ProductID, Price, SKU, and StockQuantity are required', 16, 1);
        RETURN;
    END
    
    -- Validate product exists
    IF NOT EXISTS (SELECT 1 FROM Product WHERE ProductID = @ProductID)
    BEGIN
        RAISERROR('Invalid product ID', 16, 1);
        RETURN;
    END
    
    -- Validate price is positive
    IF @Price <= 0
    BEGIN
        RAISERROR('Price must be greater than zero', 16, 1);
        RETURN;
    END
    
    -- Validate stock quantity is non-negative
    IF @StockQuantity < 0
    BEGIN
        RAISERROR('Stock quantity cannot be negative', 16, 1);
        RETURN;
    END
    
    -- Check if SKU already exists
    IF EXISTS (SELECT 1 FROM ProductItem WHERE SKU = @SKU)
    BEGIN
        RAISERROR('SKU already exists', 16, 1);
        RETURN;
    END
    
    -- Get the next available ID
    DECLARE @NextID INT;
    SELECT @NextID = ISNULL(MAX(ProductItemID), 0) + 1 FROM ProductItem;
    
    -- Insert the product item
    INSERT INTO ProductItem (
        ProductItemID,
        ProductID,
        Price,
        SKU,
        StockQuantity
    )
    VALUES (
        @NextID,
        @ProductID,
        @Price,
        @SKU,
        @StockQuantity
    );
    
    SET @ProductItemID = @NextID;
END
GO

-- Insert Coupon
CREATE PROCEDURE sp_InsertCoupon
    @CouponName VARCHAR(100),
    @Description VARCHAR(MAX) = NULL,
    @DiscountRate DECIMAL(5,2),
    @StartDate DATE,
    @EndDate DATE,
    @CouponID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validate required fields
    IF @CouponName IS NULL OR @DiscountRate IS NULL OR @StartDate IS NULL OR @EndDate IS NULL
    BEGIN
        RAISERROR('CouponName, DiscountRate, StartDate, and EndDate are required', 16, 1);
        RETURN;
    END
    
    -- Validate discount rate is between 0 and 100
    IF @DiscountRate <= 0 OR @DiscountRate > 100
    BEGIN
        RAISERROR('Discount rate must be between 0 and 100', 16, 1);
        RETURN;
    END
    
    -- Validate end date is after start date
    IF @EndDate <= @StartDate
    BEGIN
        RAISERROR('End date must be after start date', 16, 1);
        RETURN;
    END
    
    -- Check if coupon with same name already exists
    IF EXISTS (SELECT 1 FROM Coupon WHERE CouponName = @CouponName)
    BEGIN
        RAISERROR('A coupon with this name already exists', 16, 1);
        RETURN;
    END
    
    -- Get the next available ID
    DECLARE @NextID INT;
    SELECT @NextID = ISNULL(MAX(CouponID), 0) + 1 FROM Coupon;
    
    -- Insert the coupon
    INSERT INTO Coupon (
        CouponID,
        CouponName,
        Description,
        DiscountRate,
        StartDate,
        EndDate
    )
    VALUES (
        @NextID,
        @CouponName,
        @Description,
        @DiscountRate,
        @StartDate,
        @EndDate
    );
    
    SET @CouponID = @NextID;
END
GO

-- Link Coupon to Category
CREATE PROCEDURE sp_LinkCouponCategory
    @CategoryID INT,
    @CouponID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validate category exists
    IF NOT EXISTS (SELECT 1 FROM Category WHERE CategoryID = @CategoryID)
    BEGIN
        RAISERROR('Invalid category ID', 16, 1);
        RETURN;
    END
    
    -- Validate coupon exists
    IF NOT EXISTS (SELECT 1 FROM Coupon WHERE CouponID = @CouponID)
    BEGIN
        RAISERROR('Invalid coupon ID', 16, 1);
        RETURN;
    END
    
    -- Check if this link already exists
    IF EXISTS (SELECT 1 FROM CouponCategory WHERE CategoryID = @CategoryID AND CouponID = @CouponID)
    BEGIN
        RETURN; -- Already linked, no error needed
    END
    
    -- Insert the coupon-category link
    INSERT INTO CouponCategory (CategoryID, CouponID)
    VALUES (@CategoryID, @CouponID);
END
GO

-- ======================================================================
-- SECTION 4: SHOPPING CART & ORDER MANAGEMENT
-- ======================================================================

-- Create Shopping Cart for Customer
CREATE PROCEDURE sp_CreateShoppingCart
    @CustomerID INT,
    @ShoppingCartID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validate customer exists
    IF NOT EXISTS (SELECT 1 FROM Customer WHERE CustomerID = @CustomerID)
    BEGIN
        RAISERROR('Invalid customer ID', 16, 1);
        RETURN;
    END
    
    -- Check if customer already has a shopping cart
    IF EXISTS (SELECT 1 FROM ShoppingCart WHERE CustomerID = @CustomerID)
    BEGIN
        -- Return existing cart ID
        SELECT @ShoppingCartID = ShoppingCartID FROM ShoppingCart WHERE CustomerID = @CustomerID;
        RETURN;
    END
    
    -- Get the next available ID
    DECLARE @NextID INT;
    SELECT @NextID = ISNULL(MAX(ShoppingCartID), 0) + 1 FROM ShoppingCart;
    
    -- Create new shopping cart
    INSERT INTO ShoppingCart (ShoppingCartID, CustomerID)
    VALUES (@NextID, @CustomerID);
    
    SET @ShoppingCartID = @NextID;
END
GO

-- Add Item to Shopping Cart
CREATE PROCEDURE sp_AddItemToCart
    @ShoppingCartID INT,
    @ProductItemID INT,
    @Quantity INT = 1
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        -- Start a transaction for consistent cart updates
        BEGIN TRANSACTION;
        
        -- Validate shopping cart exists
        IF NOT EXISTS (SELECT 1 FROM ShoppingCart WHERE ShoppingCartID = @ShoppingCartID)
        BEGIN
            RAISERROR('Invalid shopping cart ID', 16, 1);
            ROLLBACK;
            RETURN;
        END
        
        -- Validate product item exists
        IF NOT EXISTS (SELECT 1 FROM ProductItem WHERE ProductItemID = @ProductItemID)
        BEGIN
            RAISERROR('Invalid product item ID', 16, 1);
            ROLLBACK;
            RETURN;
        END
        
        -- Validate quantity is positive
        IF @Quantity <= 0
        BEGIN
            RAISERROR('Quantity must be greater than zero', 16, 1);
            ROLLBACK;
            RETURN;
        END
        
        -- Check if enough stock is available
        DECLARE @AvailableStock INT;
        SELECT @AvailableStock = StockQuantity FROM ProductItem WHERE ProductItemID = @ProductItemID;
        
        IF @AvailableStock < @Quantity
        BEGIN
            RAISERROR('Not enough stock available. Only %d items in stock.', 16, 1, @AvailableStock);
            ROLLBACK;
            RETURN;
        END
        
        -- Get the next available ID for cart item
        DECLARE @NextItemID INT;
        DECLARE @ExistingCartItemID INT = NULL;
        
        -- Check if the product is already in the cart
        SELECT @ExistingCartItemID = ShoppingCartItemID
        FROM ShoppingCartItem
        WHERE ShoppingCartID = @ShoppingCartID AND ProductItemID = @ProductItemID;
        
        IF @ExistingCartItemID IS NOT NULL
        BEGIN
            -- Update quantity of existing cart item
            UPDATE ShoppingCartItem
            SET Quantity = Quantity + @Quantity
            WHERE ShoppingCartItemID = @ExistingCartItemID;
        END
        ELSE
        BEGIN
            -- Add new item to cart
            SELECT @NextItemID = ISNULL(MAX(ShoppingCartItemID), 0) + 1 FROM ShoppingCartItem;
            
            INSERT INTO ShoppingCartItem (
                ShoppingCartItemID,
                ShoppingCartID,
                ProductItemID,
                Quantity
            )
            VALUES (
                @NextItemID,
                @ShoppingCartID,
                @ProductItemID,
                @Quantity
            );
        END
        
        COMMIT;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK;
            
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END
GO

-- Create Order
CREATE PROCEDURE sp_CreateOrder
    @CustomerID INT,
    @AddressID INT,
    @PaymentID INT,
    @ShippingMethodID INT,
    @OrderStatusID INT = 1, -- Default to "Pending"
    @OrderID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        -- Start a transaction for order creation
        BEGIN TRANSACTION;
        
        -- Validate customer exists
        IF NOT EXISTS (SELECT 1 FROM Customer WHERE CustomerID = @CustomerID)
        BEGIN
            RAISERROR('Invalid customer ID', 16, 1);
            ROLLBACK;
            RETURN;
        END
        
        -- Validate address exists and belongs to customer
        IF NOT EXISTS (
            SELECT 1 FROM CustomerAddress 
            WHERE CustomerID = @CustomerID AND AddressID = @AddressID
        )
        BEGIN
            RAISERROR('Invalid address or address does not belong to this customer', 16, 1);
            ROLLBACK;
            RETURN;
        END
        
        -- Validate payment