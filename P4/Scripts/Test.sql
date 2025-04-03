-- ========================================
-- Test.sql - Run test case
-- Team: 3
-- E-Commerce Database Management System
-- ========================================


USE E_Commerce_Database_Management_System;

/*
 * Test case for TableLevelCheckConstraints
 */
-- Test valid emails
SELECT dbo.IsValidEmail('test@example.com') AS Expected1;  -- 1
SELECT dbo.IsValidEmail('user.name@domain.co.uk') AS Expected2;  -- 1
SELECT dbo.IsValidEmail('email@sub.domain.com') AS Expected3;  -- 1

-- Test invalid emails
SELECT dbo.IsValidEmail('invalidemail.com') AS Expected4;  -- 0 (No @)
SELECT dbo.IsValidEmail('user@@domain.com') AS Expected5;  -- 0 (Multiple @)
SELECT dbo.IsValidEmail('user@.domain.com') AS Expected6;  -- 0 (@. pattern)
SELECT dbo.IsValidEmail('user@domain..com') AS Expected7;  -- 0 (Consecutive dots)
SELECT dbo.IsValidEmail('user@domain.c') AS Expected8;  -- 0 (TLD < 2 chars)
SELECT dbo.IsValidEmail('user@ domain.com') AS Expected9;  -- 0 (Whitespace)
SELECT dbo.IsValidEmail('user@domain.') AS Expected10;  -- 0 (No TLD)