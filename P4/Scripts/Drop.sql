-- ========================================
-- Drop.sql - Drop functions
-- Team: 3
-- E-Commerce Database Management System
-- ========================================

-- Kill all active connections to the database
ALTER DATABASE DAMG SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

-- Drop the database 
DROP DATABASE DAMG;



USE E_Commerce_Database_Management_System;
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