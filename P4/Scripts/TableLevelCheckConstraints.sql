-- ========================================
-- TableLevelCheckConstraints.sql - Apply table constraints
-- Team: 3
-- E-Commerce Database Management System
-- ========================================

USE E_Commerce_Database_Management_System;

/*
 * Validate Email Format
 * Ensures valid email addresses are stored in the database, improving communication reliability.
 * Must contain exactly one @ symbol
 * Must have at least one character before the @
 * Must have at least one character between @ and .
 * Must have at least one . after the @ symbol
 * Must have at least two characters after the last .
 * Cannot contain consecutive dots (..)
 * Cannot have whitespace
 */
-- Create a function to validate email format
CREATE FUNCTION dbo.IsValidEmail(@Email VARCHAR(255))
RETURNS BIT
AS
BEGIN
    RETURN CASE 
        WHEN @Email IS NULL THEN 0
        WHEN @Email LIKE '%_@__%.__%' 
             AND @Email NOT LIKE '%@%@%'
             AND @Email NOT LIKE '%..%'
             AND @Email NOT LIKE '%@.%'
             AND @Email NOT LIKE '%.@%'
             AND @Email NOT LIKE '% %'
        THEN 1
        ELSE 0
    END;
END;

-- Apply the constraint
ALTER TABLE Customer
ADD CONSTRAINT CHK_ValidEmail
CHECK (dbo.IsValidEmail(Email) = 1);



/*
 * Validate Phone Number Format
 * Ensures consistent phone number formatting, which improves data quality for customer communications.
 * For US/North American numbers:
 * 10 digits minimum (excluding country code)
 * May contain formatting characters like -, ., (, ), or spaces
 * May include country code (e.g., +1)
 * Valid formats: (123) 456-7890, 123-456-7890, 123.456.7890, +1 123-456-7890
 * 
 * For international numbers:
 * Should start with + followed by country code
 * Minimum overall length of 8 digits
 * May contain spaces, hyphens, or parentheses
 */
-- Create a function to validate phone number format
CREATE FUNCTION dbo.IsValidPhoneNumber(@PhoneNumber VARCHAR(20))
RETURNS BIT
AS
BEGIN
    DECLARE @StrippedNumber VARCHAR(20);
    DECLARE @IsValid BIT = 0;
    
    -- Remove common formatting characters
    SET @StrippedNumber = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
                          @PhoneNumber, '(', ''), ')', ''), '-', ''), ' ', ''), '.', '');
    
    -- Check for North American format (with or without country code)
    IF (@StrippedNumber LIKE '+1[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' OR
        @StrippedNumber LIKE '1[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' OR
        @StrippedNumber LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
        SET @IsValid = 1;
    -- International format (starts with + and has minimum length)
    ELSE IF @PhoneNumber LIKE '+%' 
    	AND LEN(@StrippedNumber) >= 8
    	AND @StrippedNumber NOT LIKE '%[^0-9+]%'  -- Ensures only digits after +
        SET @IsValid = 1;
    
    RETURN @IsValid;
END;

-- Apply the constraint
ALTER TABLE Customer
ADD CONSTRAINT CHK_ValidPhoneNumber
CHECK (dbo.IsValidPhoneNumber(PhoneNumber) = 1);

