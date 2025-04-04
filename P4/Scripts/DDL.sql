-- ========================================
-- DDL.sql - Table Creation Script for SQL Server
-- Team: 3
-- E-Commerce Database Management System
-- ========================================

CREATE DATABASE E_COMMERCE;
USE E_COMMERCE;


-- Country Table
CREATE TABLE Country (
    CountryID INT PRIMARY KEY,
    CountryName VARCHAR(100) NOT NULL
);

-- Address Table
CREATE TABLE Address (
    AddressID INT PRIMARY KEY,
    UnitNumber VARCHAR(10),
    StreetNumber VARCHAR(10),
    AddressLine1 VARCHAR(255),
    AddressLine2 VARCHAR(255),
    City VARCHAR(100),
    State VARCHAR(100),
    PostalCode VARCHAR(20),
    CountryID INT,
    FOREIGN KEY (CountryID) REFERENCES Country(CountryID)
);

-- Customer Table (with encrypted EncryptedPassword column)
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    CustomerName VARCHAR(100),
    EncryptedPassword VARBINARY(255),
    Email VARCHAR(255),
    PhoneNumber VARCHAR(20),
    RegistrationDate DATETIME
);

-- CustomerAddress Table
CREATE TABLE CustomerAddress (
    CustomerID INT,
    AddressID INT,
    IsDefault BIT,
    PRIMARY KEY (CustomerID, AddressID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (AddressID) REFERENCES Address(AddressID)
);

-- Category Table (Self-referencing FK)
CREATE TABLE Category (
    CategoryID INT PRIMARY KEY,
    ParentCategoryID INT,
    CategoryName VARCHAR(100),
    FOREIGN KEY (ParentCategoryID) REFERENCES Category(CategoryID)
);

-- Product Table
CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    CategoryID INT,
    ProductName VARCHAR(255),
    Description VARCHAR(MAX),
    ImageURL VARCHAR(255),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

-- ProductItem Table
CREATE TABLE ProductItem (
    ProductItemID INT PRIMARY KEY,
    ProductID INT,
    Price DECIMAL(10,2),
    SKU VARCHAR(100),
    StockQuantity INT,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- ShoppingCart Table
CREATE TABLE ShoppingCart (
    ShoppingCartID INT PRIMARY KEY,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- ShoppingCartItem Table
CREATE TABLE ShoppingCartItem (
    ShoppingCartItemID INT PRIMARY KEY,
    ShoppingCartID INT,
    ProductItemID INT,
    Quantity INT,
    FOREIGN KEY (ShoppingCartID) REFERENCES ShoppingCart(ShoppingCartID),
    FOREIGN KEY (ProductItemID) REFERENCES ProductItem(ProductItemID)
);

-- PaymentType Table
CREATE TABLE PaymentType (
    PaymentTypeID INT PRIMARY KEY,
    Value VARCHAR(50)
);

-- PaymentMethod Table
CREATE TABLE PaymentMethod (
    PaymentMethodID INT PRIMARY KEY,
    CustomerID INT,
    PaymentTypeID INT,
    Provider VARCHAR(100),
    AccountNumber VARCHAR(100),
    ExpirationDate DATE,
    IsDefault BIT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (PaymentTypeID) REFERENCES PaymentType(PaymentTypeID)
);

-- ShippingMethod Table
CREATE TABLE ShippingMethod (
    ShippingMethodID INT PRIMARY KEY,
    ShippingMethodName VARCHAR(100),
    Price DECIMAL(10,2)
);

-- OrderStatus Table
CREATE TABLE OrderStatus (
    OrderStatusID INT PRIMARY KEY,
    Status VARCHAR(100)
);

-- ShopOrder Table
CREATE TABLE ShopOrder (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    AddressID INT,
    PaymentID INT,
    OrderStatusID INT,
    ShippingMethodID INT,
    OrderTotal DECIMAL(10,2),
    OrderDate DATETIME,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (AddressID) REFERENCES Address(AddressID),
    FOREIGN KEY (PaymentID) REFERENCES PaymentMethod(PaymentMethodID),
    FOREIGN KEY (OrderStatusID) REFERENCES OrderStatus(OrderStatusID),
    FOREIGN KEY (ShippingMethodID) REFERENCES ShippingMethod(ShippingMethodID)
);

-- Coupon Table
CREATE TABLE Coupon (
    CouponID INT PRIMARY KEY,
    CouponName VARCHAR(100),
    Description VARCHAR(MAX),
    DiscountRate DECIMAL(5,2),
    StartDate DATE,
    EndDate DATE
);

-- CouponCategory Table
CREATE TABLE CouponCategory (
    CategoryID INT,
    CouponID INT,
    PRIMARY KEY (CategoryID, CouponID),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID),
    FOREIGN KEY (CouponID) REFERENCES Coupon(CouponID)
);

-- OrderLine Table
CREATE TABLE OrderLine (
    OrderLineID INT PRIMARY KEY,
    OrderID INT,
    ProductItemID INT,
    Quantity INT,
    Price DECIMAL(10,2),
    CouponID INT,
    FOREIGN KEY (OrderID) REFERENCES ShopOrder(OrderID),
    FOREIGN KEY (ProductItemID) REFERENCES ProductItem(ProductItemID),
    FOREIGN KEY (CouponID) REFERENCES Coupon(CouponID)
);

-- Review Table (with CHECK constraint)
CREATE TABLE Review (
    ReviewID INT PRIMARY KEY,
    CustomerID INT,
    OrderLineID INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment VARCHAR(MAX),
    ReviewDate DATETIME,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (OrderLineID) REFERENCES OrderLine(OrderLineID)
);

-- TicketStatus Table
CREATE TABLE TicketStatus (
    TicketStatusID INT PRIMARY KEY,
    Status VARCHAR(100)
);

-- CustomerSupportTicket Table
CREATE TABLE CustomerSupportTicket (
    TicketID INT PRIMARY KEY,
    CustomerID INT,
    OrderLineID INT,
    IssueDescription VARCHAR(MAX),
    TicketStatusID INT,
    CreatedDate DATETIME,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (OrderLineID) REFERENCES OrderLine(OrderLineID),
    FOREIGN KEY (TicketStatusID) REFERENCES TicketStatus(TicketStatusID)
);

