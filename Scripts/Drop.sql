-- ========================================
-- Drop.sql - Drop Script
-- E-Commerce Database Management System
-- ========================================

-- Kill all active connections to the database
ALTER DATABASE DAMG SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

-- Drop the database
DROP DATABASE DAMG;

-- Use the new database (E_Commerce) after dropping the old one
USE E_Commerce;

--
DROP TABLE IF EXISTS CustomerSupportTicket;
DROP TABLE IF EXISTS TicketStatus;
DROP TABLE IF EXISTS Review;
DROP TABLE IF EXISTS OrderLine;
DROP TABLE IF EXISTS CouponCategory;
DROP TABLE IF EXISTS Coupon;
DROP TABLE IF EXISTS ShopOrder;
DROP TABLE IF EXISTS OrderStatus;
DROP TABLE IF EXISTS ShippingMethod;
DROP TABLE IF EXISTS PaymentMethod;
DROP TABLE IF EXISTS PaymentType;
DROP TABLE IF EXISTS ShoppingCartItem;
DROP TABLE IF EXISTS ShoppingCart;
DROP TABLE IF EXISTS ProductItem;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Category;
DROP TABLE IF EXISTS UserAddress;
DROP TABLE IF EXISTS Address;
DROP TABLE IF EXISTS Country;


-- Child tables first
DELETE FROM CustomerSupportTicket;
DELETE FROM Review;
DELETE FROM OrderLine;
DELETE FROM CouponCategory;
DELETE FROM ShopOrder;
DELETE FROM Coupon;
DELETE FROM PaymentMethod;
DELETE FROM ShoppingCartItem;
DELETE FROM ShoppingCart;
DELETE FROM ProductItem;
DELETE FROM Product;
DELETE FROM Category;
DELETE FROM CustomerAddress;
DELETE FROM Address;
DELETE FROM Customer;
DELETE FROM Country;
DELETE FROM OrderStatus;
DELETE FROM ShippingMethod;
DELETE FROM PaymentType;
DELETE FROM TicketStatus;