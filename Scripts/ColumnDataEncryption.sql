-- ========================================
-- ColumnDataEncryption.sql - Column Data Encryption
-- E-Commerce Database Management System
-- ========================================

USE E_Commerce;

-- Create Master Key
CREATE MASTER KEY
ENCRYPTION BY PASSWORD = 'e_commerce';

-- Create Certificate
CREATE CERTIFICATE TestCertificate
WITH SUBJECT = 'Protect e_commerce data';

-- Create Symmetric Key
CREATE SYMMETRIC KEY TestSymmetricKey
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE TestCertificate;


