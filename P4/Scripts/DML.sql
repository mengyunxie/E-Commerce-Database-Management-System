-- Country
INSERT INTO Country (CountryID, CountryName) VALUES (1, 'United States');
INSERT INTO Country (CountryID, CountryName) VALUES (2, 'Canada');
INSERT INTO Country (CountryID, CountryName) VALUES (3, 'United Kingdom');
INSERT INTO Country (CountryID, CountryName) VALUES (4, 'Germany');
INSERT INTO Country (CountryID, CountryName) VALUES (5, 'France');
INSERT INTO Country (CountryID, CountryName) VALUES (6, 'Australia');
INSERT INTO Country (CountryID, CountryName) VALUES (7, 'Japan');
INSERT INTO Country (CountryID, CountryName) VALUES (8, 'India');
INSERT INTO Country (CountryID, CountryName) VALUES (9, 'Brazil');
INSERT INTO Country (CountryID, CountryName) VALUES (10, 'South Korea');

-- Customer
INSERT INTO Customer (CustomerID, FirstName, LastName, CustomerName, Password, Email, PhoneNumber, RegistrationDate) VALUES
(1, 'First1', 'Last1', 'user1', 0x456e6372797074656450617373776f726431, 'user1@example.com', '123-456-7891', '2024-10-03 11:32:14'),
(2, 'First2', 'Last2', 'user2', 0x456e6372797074656450617373776f726432, 'user2@example.com', '123-456-7892', '2024-09-03 11:32:14'),
(3, 'First3', 'Last3', 'user3', 0x456e6372797074656450617373776f726433, 'user3@example.com', '123-456-7893', '2024-08-04 11:32:14'),
(4, 'First4', 'Last4', 'user4', 0x456e6372797074656450617373776f726434, 'user4@example.com', '123-456-7894', '2024-07-05 11:32:14'),
(5, 'First5', 'Last5', 'user5', 0x456e6372797074656450617373776f726435, 'user5@example.com', '123-456-7895', '2024-06-05 11:32:14'),
(6, 'First6', 'Last6', 'user6', 0x456e6372797074656450617373776f726436, 'user6@example.com', '123-456-7896', '2024-05-06 11:32:14'),
(7, 'First7', 'Last7', 'user7', 0x456e6372797074656450617373776f726437, 'user7@example.com', '123-456-7897', '2024-04-06 11:32:14'),
(8, 'First8', 'Last8', 'user8', 0x456e6372797074656450617373776f726438, 'user8@example.com', '123-456-7898', '2024-03-07 11:32:14'),
(9, 'First9', 'Last9', 'user9', 0x456e6372797074656450617373776f726439, 'user9@example.com', '123-456-7899', '2024-02-06 11:32:14'),
(10, 'First10', 'Last10', 'user10', 0x456e6372797074656450617373776f72643130, 'user10@example.com', '123-456-7890', '2024-01-07 11:32:14');

--Address
INSERT INTO Address (AddressID, UnitNumber, StreetNumber, AddressLine1, AddressLine2, City, State, PostalCode, CountryID) VALUES
(1, 'Unit1', '101', '1 Main Street', 'Apt 1', 'CityX', 'StateY', '10001', 1),
(2, 'Unit2', '102', '2 Main Street', 'Apt 2', 'CityX', 'StateY', '10002', 2),
(3, 'Unit3', '103', '3 Main Street', 'Apt 3', 'CityX', 'StateY', '10003', 3),
(4, 'Unit4', '104', '4 Main Street', 'Apt 4', 'CityX', 'StateY', '10004', 4),
(5, 'Unit5', '105', '5 Main Street', 'Apt 5', 'CityX', 'StateY', '10005', 5),
(6, 'Unit6', '106', '6 Main Street', 'Apt 6', 'CityX', 'StateY', '10006', 6),
(7, 'Unit7', '107', '7 Main Street', 'Apt 7', 'CityX', 'StateY', '10007', 7),
(8, 'Unit8', '108', '8 Main Street', 'Apt 8', 'CityX', 'StateY', '10008', 8),
(9, 'Unit9', '109', '9 Main Street', 'Apt 9', 'CityX', 'StateY', '10009', 9),
(10, 'Unit10', '110', '10 Main Street', 'Apt 10', 'CityX', 'StateY', '10010', 10);

-- CustomerAddress
INSERT INTO CustomerAddress (CustomerID, AddressID, IsDefault) VALUES
(1, 1, 1),
(2, 2, 0),
(3, 3, 1),
(4, 4, 0),
(5, 5, 1),
(6, 6, 0),
(7, 7, 1),
(8, 8, 0),
(9, 9, 1),
(10, 10, 0);

-- Category
INSERT INTO Category (CategoryID, ParentCategoryID, CategoryName) VALUES
(1, NULL, 'Electronics'),
(2, 1, 'Laptops'),
(3, 1, 'Smartphones'),
(4, 1, 'Tablets'),
(5, 1, 'Headphones'),
(6, 1, 'Cameras'),
(7, 1, 'Wearables'),
(8, 1, 'Gaming Consoles'),
(9, 1, 'Monitors'),
(10, 1, 'Accessories');

--Product
INSERT INTO Product (ProductID, CategoryID, ProductName, Description, ImageURL) VALUES
(1, 2, 'MacBook Pro', 'Apple laptop with M2 chip', 'http://example.com/images/macbookpro.jpg'),
(2, 3, 'iPhone 15', 'Latest iPhone with advanced camera', 'http://example.com/images/iphone15.jpg'),
(3, 4, 'iPad Air', 'Lightweight tablet for work and play', 'http://example.com/images/ipadair.jpg'),
(4, 5, 'Sony WH-1000XM5', 'Noise-cancelling wireless headphones', 'http://example.com/images/sonyheadphones.jpg'),
(5, 6, 'Canon EOS R10', 'Mirrorless camera with 24MP sensor', 'http://example.com/images/canonr10.jpg'),
(6, 7, 'Apple Watch Series 9', 'Smartwatch with health tracking features', 'http://example.com/images/applewatch.jpg'),
(7, 8, 'PlayStation 5', 'Next-gen Sony gaming console', 'http://example.com/images/ps5.jpg'),
(8, 9, 'Dell UltraSharp 27"', 'High-resolution monitor for professionals', 'http://example.com/images/dellmonitor.jpg'),
(9, 10, 'Logitech MX Master 3', 'Wireless ergonomic mouse', 'http://example.com/images/logitechmouse.jpg'),
(10, 10, 'Anker USB-C Hub', '7-in-1 USB-C hub for MacBook and more', 'http://example.com/images/ankerhub.jpg');

--ProductItem
INSERT INTO ProductItem (ProductItemID, ProductID, Price, SKU, StockQuantity) VALUES
(1, 1, 1999.99, 'SKU-MBP-M2-001', 50),
(2, 2, 999.99, 'SKU-IPHONE15-002', 100),
(3, 3, 599.99, 'SKU-IPADAIR-003', 75),
(4, 4, 349.99, 'SKU-SONYXM5-004', 120),
(5, 5, 899.99, 'SKU-CANONR10-005', 30),
(6, 6, 429.99, 'SKU-AWATCH9-006', 80),
(7, 7, 499.99, 'SKU-PS5-007', 60),
(8, 8, 379.99, 'SKU-DELL27-008', 40),
(9, 9, 99.99, 'SKU-LOGIMX3-009', 150),
(10, 10, 59.99, 'SKU-ANKERHUB-010', 200);

--ShoppingCart
INSERT INTO ShoppingCart (ShoppingCartID, CustomerID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

--ShoppingCartItem
INSERT INTO ShoppingCartItem (ShoppingCartItemID, ShoppingCartID, ProductItemID, Quantity) VALUES
(1, 1, 1, 1),
(2, 2, 2, 2),
(3, 3, 3, 1),
(4, 4, 4, 3),
(5, 5, 5, 1),
(6, 6, 6, 2),
(7, 7, 7, 1),
(8, 8, 8, 2),
(9, 9, 9, 4),
(10, 10, 10, 1);

--PaymentType
INSERT INTO PaymentType (PaymentTypeID, Value) VALUES
(1, 'Credit Card'),
(2, 'Debit Card'),
(3, 'PayPal'),
(4, 'Apple Pay'),
(5, 'Google Pay'),
(6, 'Bank Transfer'),
(7, 'Crypto'),
(8, 'Cash on Delivery'),
(9, 'Gift Card'),
(10, 'Other');

--PaymentMethod
INSERT INTO PaymentMethod (PaymentMethodID, CustomerID, PaymentTypeID, Provider, AccountNumber, ExpirationDate, IsDefault) VALUES
(1, 1, 1, 'Visa', '4111111111111111', '2026-01-01', 1),
(2, 2, 2, 'Mastercard', '5500000000000004', '2025-12-31', 1),
(3, 3, 3, 'PayPal', 'user3@paypal.com', NULL, 1),
(4, 4, 4, 'Apple', 'apple_user4', NULL, 1),
(5, 5, 5, 'Google', 'google_user5', NULL, 1),
(6, 6, 6, 'Chase Bank', '12345678', '2026-06-30', 1),
(7, 7, 7, 'Coinbase', '0xABCDEF...', NULL, 1),
(8, 8, 8, 'COD', 'N/A', NULL, 1),
(9, 9, 9, 'Amazon', 'GFT-123-456', '2025-11-30', 1),
(10, 10, 10, 'OtherPay', 'ALT-001', NULL, 1);

--ShippingMethod
INSERT INTO ShippingMethod (ShippingMethodID, ShippingMethodName, Price) VALUES
(1, 'Standard Shipping', 5.00),
(2, 'Express Shipping', 15.00),
(3, 'Next-Day Delivery', 25.00),
(4, 'Store Pickup', 0.00),
(5, 'International Shipping', 30.00),
(6, 'Weekend Delivery', 10.00),
(7, 'Eco Shipping', 3.00),
(8, 'Drone Delivery', 50.00),
(9, 'Two-Day Shipping', 12.00),
(10, 'Same-Day Delivery', 40.00);

--OrderStatus
INSERT INTO OrderStatus (OrderStatusID, Status) VALUES
(1, 'Pending'),
(2, 'Processing'),
(3, 'Shipped'),
(4, 'Out for Delivery'),
(5, 'Delivered'),
(6, 'Cancelled'),
(7, 'Refund Requested'),
(8, 'Refunded'),
(9, 'On Hold'),
(10, 'Failed');

--ShopOrder
INSERT INTO ShopOrder (OrderID, CustomerID, AddressID, PaymentID, OrderStatusID, ShippingMethodID, OrderTotal, OrderDate) VALUES
(1, 1, 1, 1, 1, 1, 2004.99, '2025-04-01'),
(2, 2, 2, 2, 2, 2, 1004.99, '2025-04-01'),
(3, 3, 3, 3, 3, 3, 604.99, '2025-04-01'),
(4, 4, 4, 4, 4, 4, 354.99, '2025-04-01'),
(5, 5, 5, 5, 5, 5, 904.99, '2025-04-01'),
(6, 6, 6, 6, 6, 6, 434.99, '2025-04-01'),
(7, 7, 7, 7, 7, 7, 504.99, '2025-04-01'),
(8, 8, 8, 8, 8, 8, 384.99, '2025-04-01'),
(9, 9, 9, 9, 9, 9, 103.99, '2025-04-01'),
(10, 10, 10, 10, 10, 10, 64.99, '2025-04-01');


--Coupon
INSERT INTO Coupon (CouponID, CouponName, Description, DiscountRate, StartDate, EndDate) VALUES
(1, 'WELCOME10', '10% off on first purchase', 10.00, '2025-04-01', '2025-06-30'),
(2, 'SPRING15', 'Spring Sale: 15% off', 15.00, '2025-04-01', '2025-05-15'),
(3, 'FREESHIP', 'Free shipping on orders over $50', 0.00, '2025-04-01', '2025-07-01'),
(4, 'ELECTRO5', '5% off on electronics', 5.00, '2025-04-01', '2025-06-01'),
(5, 'GAMER20', '20% off on gaming products', 20.00, '2025-04-01', '2025-05-31'),
(6, 'CAMERA15', '15% off on cameras', 15.00, '2025-04-01', '2025-06-30'),
(7, 'TABLET10', '10% off on tablets', 10.00, '2025-04-01', '2025-06-30'),
(8, 'ACCESSORY5', '5% off accessories', 5.00, '2025-04-01', '2025-05-31'),
(9, 'FLASH25', 'Flash Sale: 25% off everything', 25.00, '2025-04-01', '2025-04-10'),
(10, 'LOYALTY30', 'Loyalty bonus: 30% off', 30.00, '2025-04-01', '2025-12-31');

--CouponCategory
INSERT INTO CouponCategory (CategoryID, CouponID) VALUES
(1, 4),   -- Electronics → ELECTRO5
(2, 1),   -- Laptops → WELCOME10
(3, 9),   -- Smartphones → FLASH25
(4, 7),   -- Tablets → TABLET10
(5, 8),   -- Headphones → ACCESSORY5
(6, 6),   -- Cameras → CAMERA15
(7, 10),  -- Wearables → LOYALTY30
(8, 5),   -- Gaming Consoles → GAMER20
(9, 2),   -- Monitors → SPRING15
(10, 3);  -- Accessories → FREESHIP

--OrderLine
INSERT INTO OrderLine (OrderLineID, OrderID, ProductItemID, Quantity, Price, CouponID) VALUES
(1, 1, 1, 1, 1999.99, 1),
(2, 2, 2, 2, 1999.98, 2),
(3, 3, 3, 1, 599.99, 3),
(4, 4, 4, 1, 349.99, 4),
(5, 5, 5, 1, 899.99, 5),
(6, 6, 6, 1, 429.99, 6),
(7, 7, 7, 1, 499.99, 7),
(8, 8, 8, 1, 379.99, 8),
(9, 9, 9, 1, 99.99, 9),
(10, 10, 10, 1, 59.99, 10);

--Review
INSERT INTO Review (ReviewID, CustomerID, OrderLineID, Rating, Comment, ReviewDate) VALUES
(1, 1, 1, 5, 'Excellent product and fast delivery!', '2025-04-01'),
(2, 2, 2, 4, 'Very good, but packaging could be better.', '2025-04-01'),
(3, 3, 3, 5, 'Totally worth the price.', '2025-04-01'),
(4, 4, 4, 3, 'Average experience, item arrived late.', '2025-04-01'),
(5, 5, 5, 5, 'Great quality and smooth checkout.', '2025-04-01'),
(6, 6, 6, 4, 'Good value for money.', '2025-04-01'),
(7, 7, 7, 5, 'Amazing performance!', '2025-04-01'),
(8, 8, 8, 2, 'Not as expected.', '2025-04-01'),
(9, 9, 9, 1, 'Item was defective. Disappointed.', '2025-04-01'),
(10, 10, 10, 3, 'Decent for the price.', '2025-04-01');


--TicketStatus
INSERT INTO TicketStatus (TicketStatusID, Status) VALUES
(1, 'Open'),
(2, 'In Progress'),
(3, 'Awaiting Customer Response'),
(4, 'Escalated'),
(5, 'On Hold'),
(6, 'Resolved'),
(7, 'Closed'),
(8, 'Reopened'),
(9, 'Cancelled'),
(10, 'Invalid');

--CustomerSupportTicket
INSERT INTO CustomerSupportTicket (TicketID, CustomerID, OrderLineID, IssueDescription, TicketStatusID, CreatedDate) VALUES
(1, 1, 1, 'Received wrong item in the package.', 1, '2025-04-01'),
(2, 2, 2, 'Payment was deducted twice.', 2, '2025-04-01'),
(3, 3, 3, 'Product stopped working after a week.', 3, '2025-04-01'),
(4, 4, 4, 'Delivery was delayed beyond the promised date.', 4, '2025-04-01'),
(5, 5, 5, 'Requesting return for a defective item.', 5, '2025-04-01'),
(6, 6, 6, 'Need invoice for the order.', 6, '2025-04-01'),
(7, 7, 7, 'Received an empty box.', 7, '2025-04-01'),
(8, 8, 8, 'Tracking number is not working.', 8, '2025-04-01'),
(9, 9, 9, 'Refund not processed.', 9, '2025-04-01'),
(10, 10, 10, 'Item marked as delivered but not received.', 10, '2025-04-01');





