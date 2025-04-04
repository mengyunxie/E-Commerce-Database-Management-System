-- ========================================
-- Test.sql - Test Scripts
-- Team: 3
-- E-Commerce Database Management System
-- ========================================


USE E_COMMERCE;

/*
 * Test case for TableLevelCheckConstraints - IsValidEmail
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



/*
 * Test case for TableLevelCheckConstraints - IsValidPhoneNumber
 */
-- Valid North American phone number with country code
SELECT dbo.IsValidPhoneNumber('+11234567890') AS Expected11; -- 1

-- Valid North American phone number without country code
SELECT dbo.IsValidPhoneNumber('1234567890') AS Expected12; -- 1

-- Test Case 4: Valid international phone number
SELECT dbo.IsValidPhoneNumber('+441632960961') AS Expected13; -- 1

-- Test Case 5: Invalid phone number with too few digits
SELECT dbo.IsValidPhoneNumber('12345') AS Expected14; -- 0

-- Test Case 6: Invalid phone number with letters
SELECT dbo.IsValidPhoneNumber('123-ABC-7890') AS Expected15; -- 0


/*
 * Test case for Trigger - UpdateOrderTotal
 */

-- Insert order lines (one with a coupon, one without)
INSERT INTO OrderLine (OrderLineID, OrderID, ProductItemID, Quantity, Price, CouponID)
VALUES (7100, 5035, 20071, 2, 915.96, 407);   -- This should get a 10% discount;

-- Check if the trigger updated OrderTotal correctly
SELECT * FROM ShopOrder WHERE OrderID = 5035; 
-- 1825.41

-- Update an OrderLine and check if OrderTotal updates
UPDATE OrderLine SET Quantity = 3 WHERE OrderLineID = 1;
SELECT * FROM ShopOrder WHERE OrderID = 1;

-- Delete an OrderLine and check OrderTotal
DELETE FROM OrderLine WHERE OrderLineID = 2;
SELECT * FROM ShopOrder WHERE OrderID = 1;

-- Expire the coupon and check if OrderTotal updates correctly
UPDATE Coupon SET EndDate = DATEADD(DAY, -1, GETDATE()) WHERE CouponID = 1;
UPDATE OrderLine SET Quantity = 2 WHERE OrderLineID = 1; -- Trigger recalculates total
SELECT * FROM ShopOrder WHERE OrderID = 1;
