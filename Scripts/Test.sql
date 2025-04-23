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

