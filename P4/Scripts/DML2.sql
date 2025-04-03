USE E_COMMERCE;

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

OPEN SYMMETRIC KEY TestSymmetricKey
DECRYPTION BY CERTIFICATE TestCertificate;

-- Insert ten countries 
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


-- Insert 15 Customers
INSERT INTO Customer (
    CustomerID, FirstName, LastName, CustomerName, EncryptedPassword, Email, PhoneNumber, RegistrationDate
) VALUES
(1001, 'Laura', 'Martin', 'sheltonbianca', EncryptByKey(Key_GUID('TestSymmetricKey'), CONVERT(VARBINARY, '_Wi_3+AhX_87')), 'laura.martin@hotmail.com', '(998) 730-3619', '2024-03-23 02:11:15'),
(1002, 'Victoria', 'Erickson', 'mariahayes', EncryptByKey(Key_GUID('TestSymmetricKey'), CONVERT(VARBINARY, '3&f6Qhy!6!4U')), 'victoria.erickson@yahoo.com', '(540) 460-7681', '2023-04-28 04:47:14'),
(1003, 'Amanda', 'Price', 'kennethwallace', EncryptByKey(Key_GUID('TestSymmetricKey'), CONVERT(VARBINARY, '@@LYEPoMoh25')), 'amanda.price@hotmail.com', '(476) 442-5289', '2022-08-09 13:34:14'),
(1004, 'Jonathan', 'Washington', 'zbaker', EncryptByKey(Key_GUID('TestSymmetricKey'), CONVERT(VARBINARY, '7e+aKGfkIux0')), 'jonathan.washington@gmail.com', '(823) 709-5393', '2021-06-18 08:18:26'),
(1005, 'Grace', 'Gomez', 'lortiz', EncryptByKey(Key_GUID('TestSymmetricKey'), CONVERT(VARBINARY, '@0ZHfqb908)b')), 'grace.gomez@gmail.com', '(289) 771-8419', '2021-02-11 01:26:09'),
(1006, 'Matthew', 'Morgan', 'johnkeith', EncryptByKey(Key_GUID('TestSymmetricKey'), CONVERT(VARBINARY, '!C*SAA&d9%u6')), 'matthew.morgan@hotmail.com', '(672) 467-9943', '2021-06-15 22:08:42'),
(1007, 'Gary', 'Bush', 'castroallen', EncryptByKey(Key_GUID('TestSymmetricKey'), CONVERT(VARBINARY, '4ZPnXZ!mw5$4')), 'gary.bush@gmail.com', '(302) 517-2357', '2023-03-31 01:53:10'),
(1008, 'Melvin', 'Rowe', 'natashamccullough', EncryptByKey(Key_GUID('TestSymmetricKey'), CONVERT(VARBINARY, ')*f41VwhS#IM')), 'melvin.rowe@yahoo.com', '(858) 223-7099', '2024-01-13 11:57:11'),
(1009, 'Ashley', 'Jones', 'donnaball', EncryptByKey(Key_GUID('TestSymmetricKey'), CONVERT(VARBINARY, '%3hg!CnqiIed')), 'ashley.jones@hotmail.com', '(887) 767-7634', '2025-03-20 21:17:46'),
(1010, 'Dawn', 'James', 'justinbonilla', EncryptByKey(Key_GUID('TestSymmetricKey'), CONVERT(VARBINARY, 'bJEeymnVW_7I')), 'dawn.james@hotmail.com', '(200) 842-8125', '2022-06-15 10:30:08'),
(1011, 'Benjamin', 'Gonzales', 'rcollins', EncryptByKey(Key_GUID('TestSymmetricKey'), CONVERT(VARBINARY, 'mO)*5#EfaztK')), 'benjamin.gonzales@gmail.com', '(539) 436-7172', '2020-03-15 16:19:59'),
(1012, 'Larry', 'Schmidt', 'timothyhuang', EncryptByKey(Key_GUID('TestSymmetricKey'), CONVERT(VARBINARY, '+4CM%Jm4vYS3')), 'larry.schmidt@gmail.com', '(876) 319-8759', '2022-05-28 17:03:05'),
(1013, 'Adrian', 'Parker', 'johnsonbradley', EncryptByKey(Key_GUID('TestSymmetricKey'), CONVERT(VARBINARY, ')0XWa2*O#Npr')), 'adrian.parker@hotmail.com', '(373) 681-2331', '2024-12-24 02:45:06'),
(1014, 'Devon', 'Watson', 'fdixon', EncryptByKey(Key_GUID('TestSymmetricKey'), CONVERT(VARBINARY, '6TLHAq&W+xgv')), 'devon.watson@hotmail.com', '(718) 235-5065', '2020-10-19 20:30:23'),
(1015, 'Jonathan', 'Maldonado', 'denisetaylor', EncryptByKey(Key_GUID('TestSymmetricKey'), CONVERT(VARBINARY, '0%m4yEb_62(b')), 'jonathan.maldonado@gmail.com', '(701) 952-8928', '2021-01-25 20:17:39');

--Insert 22 Address
INSERT INTO Address (
    AddressID, UnitNumber, StreetNumber, AddressLine1, AddressLine2, City, State, PostalCode, CountryID
) VALUES
(5001, '1454', '3212', '14485 Alyssa Gateway', 'Apt. 164', 'Aprilshire', 'North Dakota', '82701', 8),
(5002, '81686', '4565', '5922 Heidi Light Suite 972', 'Suite 576', 'South Tracy', 'North Carolina', '42213', 2),
(5003, '0742', '8119', '305 Myers Branch', 'Apt. 160', 'Blaketown', 'Louisiana', '84436', 5),
(5004, '432', '9386', '16756 Mark Rue Suite 272', 'Suite 232', 'Baileyfurt', 'Nevada', '64982', 9),
(5005, '3373', '9610', '0312 Brown Route', 'Apt. 394', 'Lake Mistyport', 'Wyoming', '46778', 5),
(5006, '7088', '7056', '4735 Williams Center Apt. 504', 'Apt. 216', 'New Randy', 'Iowa', '59968', 2),
(5007, '59191', '5227', '754 Alejandra Field Suite 138', 'Suite 334', 'Larryfurt', 'Kentucky', '63688', 9),
(5008, '3048', '1186', '7706 Stevens Crest', 'Apt. 131', 'South Nicole', 'Indiana', '58256', 6),
(5009, '168', '6464', '37324 Flores Mews', 'Apt. 849', 'Lake Kenneth', 'New Hampshire', '67876', 9),
(5010, '784', '4466', '19126 Jeffery Street', 'Apt. 886', 'North Paulview', 'Delaware', '97138', 4),
(5011, '538', '4624', '318 Leonard Fort', 'Suite 749', 'East Lisa', 'Oklahoma', '66672', 10),
(5012, '5902', '6482', '81237 Joe Curve', 'Apt. 659', 'Lake Vernon', 'Connecticut', '81243', 9),
(5013, '89577', '5058', '82778 Padilla Common', 'Suite 296', 'Port Leslie', 'Maine', '50844', 10),
(5014, '30535', '7229', '5240 Berry Centers', 'Apt. 507', 'North Johntown', 'Iowa', '86205', 5),
(5015, '1056', '2226', '6254 Debra Stream', 'Suite 606', 'Amandamouth', 'Wisconsin', '05998', 8),
(5016, '166', '2807', '298 Christopher Freeway', 'Apt. 302', 'Lake Christian', 'Rhode Island', '14087', 2),
(5017, '729', '9863', '5600 Davis Highway', 'Apt. 738', 'Francisfurt', 'Michigan', '35869', 10),
(5018, '6048', '4723', '89840 Foster Crest Suite 570', 'Apt. 404', 'Wandaborough', 'Wisconsin', '69873', 7),
(5019, '564', '3424', '539 Martin Ways', 'Apt. 509', 'New Ericstad', 'Mississippi', '38667', 6),
(5020, '457', '6614', '02907 Matthew Branch Suite 493', 'Apt. 864', 'New Geoffrey', 'Texas', '84307', 10),
(5021, '91889', '6303', '4406 Shah Plain Suite 536', 'Apt. 082', 'Wardton', 'Oklahoma', '54455', 4),
(5022, '930', '5935', '357 Jessica Gateway', 'Apt. 426', 'New Shanemouth', 'North Carolina', '92905', 5);

INSERT INTO Address (AddressID, UnitNumber, StreetNumber, AddressLine1, AddressLine2, City, State, PostalCode, CountryID)
VALUES
(5023, '1726', '052', '0043 Jennifer Rest Suite 973', 'Apt. 579', 'Reginachester', 'North Dakota', '39182', 7),
(5024, '4791', '004', '630 Duncan Pine Apt. 573', 'Suite 859', 'Lake Austinmouth', 'Nebraska', '65628', 5),
(5025, '9104', '13895', '76150 Eric Vista', 'Apt. 167', 'Thompsonfort', 'Alaska', '70262', 4),
(5026, '5932', '8944', '8514 Clark Springs', 'Suite 510', 'Bensontown', 'Kansas', '10073', 5),
(5027, '194', '0419', '85327 Amber Summit Apt. 828', 'Apt. 732', 'Michelleburgh', 'Rhode Island', '01048', 5),
(5028, '6038', '72377', '1439 Lopez Corners', 'Apt. 163', 'Alexisstad', 'North Dakota', '29316', 10);

--Connect Customer and Address using CustomerAddress
INSERT INTO CustomerAddress (CustomerID, AddressID, IsDefault)
VALUES
(1001, 5014, 0),
(1001, 5013, 1),
(1001, 5015, 0),
(1002, 5016, 0),
(1002, 5022, 1),
(1003, 5010, 1),
(1004, 5005, 0),
(1004, 5017, 1),
(1004, 5009, 0),
(1005, 5011, 1),
(1006, 5018, 0),
(1006, 5020, 1),
(1006, 5008, 0),
(1007, 5019, 1),
(1008, 5021, 0),
(1008, 5006, 1),
(1009, 5007, 1),
(1009, 5001, 0),
(1009, 5002, 0),
(1010, 5004, 0),
(1010, 5012, 0),
(1010, 5003, 1);

INSERT INTO CustomerAddress (CustomerID, AddressID, IsDefault)
VALUES
(1011, 5023, 1),
(1012, 5024, 1),
(1013, 5025, 1),
(1014, 5026, 1),
(1015, 5027, 1),
(1015, 5028, 0);

-- Category
INSERT INTO Category (CategoryID, ParentCategoryID, CategoryName) VALUES
-- Parent categories
(1, NULL, 'Electronics'),
(2, NULL, 'Home & Kitchen'),
(3, NULL, 'Clothing'),
-- Subcategories under Electronics
(11, 1, 'Laptops'),
(12, 1, 'Smartphones'),
(13, 1, 'Cameras'),
-- Subcategories under Home & Kitchen
(21, 2, 'Furniture'),
(22, 2, 'Appliances'),
-- Subcategories under Clothing
(31, 3, 'Men'),
(32, 3, 'Women');

--Product: Each subcategory has 4-5 products
INSERT INTO Product (ProductID, CategoryID, ProductName, Description, ImageURL)
VALUES
(2001, 11, 'Dell XPS 13', '13-inch ultra-portable laptop with Intel Core i7 and 16GB RAM.', 'https://dummyimage.com/231x773'),
(2002, 11, 'MacBook Pro 14', 'Apple M2 Pro chip, Liquid Retina XDR display, 512GB SSD.', 'https://placeimg.com/73/427/any'),
(2003, 11, 'HP Spectre x360', '2-in-1 convertible laptop with touch display and pen support.', 'https://dummyimage.com/690x467'),
(2004, 11, 'Lenovo ThinkPad X1 Carbon', 'Lightweight business laptop with excellent keyboard and security.', 'https://dummyimage.com/1005x976'),
(2005, 11, 'ASUS ROG Zephyrus', 'High-performance gaming laptop with RTX 4060 graphics.', 'https://dummyimage.com/224x273'),
(2006, 12, 'iPhone 15 Pro', 'Latest Apple flagship with A17 chip and titanium frame.', 'https://dummyimage.com/555x649'),
(2007, 12, 'Samsung Galaxy S23 Ultra', '200MP camera, S Pen, and 120Hz AMOLED display.', 'https://dummyimage.com/85x768'),
(2008, 12, 'Google Pixel 8', 'Android 14 with best-in-class computational photography.', 'https://www.lorempixel.com/768/951'),
(2009, 12, 'OnePlus 11', 'Smooth performance with Snapdragon 8 Gen 2 and fast charging.', 'https://placekitten.com/526/958'),
(2010, 13, 'Canon EOS R5', '45MP full-frame mirrorless camera with 8K video.', 'https://placeimg.com/626/799/any'),
(2011, 13, 'Sony Alpha a7 IV', 'Hybrid mirrorless camera for photo and video.', 'https://placeimg.com/132/859/any'),
(2012, 13, 'Nikon Z6 II', '24MP mirrorless camera with dual processors.', 'https://www.lorempixel.com/623/508'),
(2013, 13, 'Fujifilm X-T5', 'Stylish APS-C camera with film simulation modes.', 'https://placeimg.com/852/601/any'),
(2014, 21, 'IKEA MALM Bed Frame', 'Queen-sized bed frame with storage drawers underneath.', 'https://placekitten.com/988/790'),
(2015, 21, 'West Elm Axel Sofa', 'Mid-century modern leather sofa, 82 inches wide.', 'https://placekitten.com/716/261'),
(2016, 21, 'Wayfair L-Shaped Desk', 'Corner computer desk with storage shelves.', 'https://dummyimage.com/630x943'),
(2017, 21, 'Ashley Dining Table', 'Farmhouse-style dining table made of solid wood.', 'https://www.lorempixel.com/419/629'),
(2018, 22, 'Dyson V15 Detect', 'Cordless vacuum with laser dust detection.', 'https://placekitten.com/936/286'),
(2019, 22, 'Instant Pot Pro Plus', '10-in-1 electric pressure cooker with smart features.', 'https://placekitten.com/238/336'),
(2020, 22, 'Samsung Family Hub Refrigerator', 'Smart fridge with touch screen and cameras.', 'https://dummyimage.com/977x83'),
(2021, 22, 'LG Front Load Washer', '5.0 cu. ft. high-efficiency washing machine.', 'https://placekitten.com/858/411'),
(2022, 31, 'Nike Air Force 1', 'Classic low-top sneakers in all-white leather.', 'https://www.lorempixel.com/19/717'),
(2023, 31, 'Levi\s 511 Slim Jeans', 'Slim-fit denim jeans with stretch.', 'https://www.lorempixel.com/652/673'),
(2024, 31, 'Hanes Crewneck T-Shirt', 'Soft cotton tagless t-shirt, 3-pack.', 'https://placeimg.com/393/184/any'),
(2025, 31, 'Columbia Fleece Jacket', 'Warm zip-up fleece for outdoor wear.', 'https://placekitten.com/85/793'),
(2026, 32, 'Lululemon Align Leggings', 'High-rise buttery soft leggings for yoga or lounge.', 'https://www.lorempixel.com/503/258'),
(2027, 32, 'ZARA Midi Dress', 'Flowy floral midi dress for spring.', 'https://dummyimage.com/708x428'),
(2028, 32, 'Everlane Tote Bag', 'Structured leather tote for daily use.', 'https://placeimg.com/844/331/any'),
(2029, 32, 'H&M Knit Sweater', 'Cozy oversized knit sweater.', 'https://placekitten.com/39/562');


--ProductItem: Each product have 1-3 product items
INSERT INTO ProductItem (ProductItemID, ProductID, Price, SKU, StockQuantity)
VALUES
(20011, 2001, 1820.05, 'SKU-2001-01', 65),
(20012, 2001, 694.04, 'SKU-2001-02', 48),
(20013, 2001, 274.91, 'SKU-2001-03', 19),
(20021, 2002, 1010.53, 'SKU-2002-01', 9),
(20022, 2002, 624.74, 'SKU-2002-02', 99),
(20023, 2002, 1383.60, 'SKU-2002-03', 24),
(20031, 2003, 1264.67, 'SKU-2003-01', 53),
(20041, 2004, 201.23, 'SKU-2004-01', 15),
(20042, 2004, 420.13, 'SKU-2004-02', 33),
(20043, 2004, 150.47, 'SKU-2004-03', 6),
(20051, 2005, 805.79, 'SKU-2005-01', 71),
(20061, 2006, 913.62, 'SKU-2006-01', 67),
(20062, 2006, 1582.92, 'SKU-2006-02', 96),
(20071, 2007, 457.98, 'SKU-2007-01', 15),
(20072, 2007, 755.60, 'SKU-2007-02', 38),
(20073, 2007, 1182.89, 'SKU-2007-03', 26),
(20081, 2008, 408.12, 'SKU-2008-01', 19),
(20082, 2008, 155.79, 'SKU-2008-02', 94),
(20091, 2009, 1808.92, 'SKU-2009-01', 62),
(20101, 2010, 427.32, 'SKU-2010-01', 68),
(20102, 2010, 813.96, 'SKU-2010-02', 31),
(20103, 2010, 1292.75, 'SKU-2010-03', 32),
(20111, 2011, 318.31, 'SKU-2011-01', 30),
(20112, 2011, 933.05, 'SKU-2011-02', 51),
(20113, 2011, 1106.38, 'SKU-2011-03', 24),
(20121, 2012, 1977.71, 'SKU-2012-01', 67),
(20131, 2013, 1140.88, 'SKU-2013-01', 86),
(20141, 2014, 863.77, 'SKU-2014-01', 71),
(20142, 2014, 1005.94, 'SKU-2014-02', 46),
(20143, 2014, 1672.05, 'SKU-2014-03', 68),
(20151, 2015, 1350.02, 'SKU-2015-01', 30),
(20152, 2015, 1099.32, 'SKU-2015-02', 33),
(20153, 2015, 49.11, 'SKU-2015-03', 95),
(20161, 2016, 1801.04, 'SKU-2016-01', 46),
(20162, 2016, 99.86, 'SKU-2016-02', 23),
(20163, 2016, 1752.72, 'SKU-2016-03', 82),
(20171, 2017, 1689.39, 'SKU-2017-01', 79),
(20181, 2018, 1444.71, 'SKU-2018-01', 65),
(20182, 2018, 160.72, 'SKU-2018-02', 15),
(20191, 2019, 1741.71, 'SKU-2019-01', 10),
(20192, 2019, 160.71, 'SKU-2019-02', 21),
(20193, 2019, 110.04, 'SKU-2019-03', 6),
(20201, 2020, 681.26, 'SKU-2020-01', 25),
(20202, 2020, 1607.26, 'SKU-2020-02', 88),
(20211, 2021, 1938.13, 'SKU-2021-01', 69),
(20212, 2021, 782.99, 'SKU-2021-02', 72),
(20221, 2022, 96.22, 'SKU-2022-01', 16),
(20222, 2022, 1366.78, 'SKU-2022-02', 71),
(20223, 2022, 1522.95, 'SKU-2022-03', 14),
(20231, 2023, 869.93, 'SKU-2023-01', 31),
(20232, 2023, 600.63, 'SKU-2023-02', 81),
(20233, 2023, 853.14, 'SKU-2023-03', 66),
(20241, 2024, 1226.63, 'SKU-2024-01', 34),
(20242, 2024, 1707.08, 'SKU-2024-02', 7),
(20251, 2025, 1773.94, 'SKU-2025-01', 99),
(20252, 2025, 388.47, 'SKU-2025-02', 69),
(20253, 2025, 1153.42, 'SKU-2025-03', 47),
(20261, 2026, 1002.20, 'SKU-2026-01', 38),
(20271, 2027, 1551.78, 'SKU-2027-01', 54),
(20272, 2027, 1625.76, 'SKU-2027-02', 12),
(20281, 2028, 1292.73, 'SKU-2028-01', 21),
(20291, 2029, 595.55, 'SKU-2029-01', 47);

--ShoppingCart
INSERT INTO ShoppingCart (ShoppingCartID, CustomerID)
VALUES
(6001, 1001),
(6002, 1002),
(6003, 1003),
(6004, 1004),
(6005, 1005),
(6006, 1006),
(6007, 1007),
(6008, 1008),
(6009, 1009),
(6010, 1010),
(6011, 1011),
(6012, 1012),
(6013, 1013),
(6014, 1014),
(6015, 1015);

--ShoppingCartItem
INSERT INTO ShoppingCartItem (ShoppingCartItemID, ShoppingCartID, ProductItemID, Quantity)
VALUES
(7001, 6001, 20281, 1),
(7002, 6002, 20131, 5),
(7003, 6002, 20043, 1),
(7004, 6002, 20152, 2),
(7005, 6002, 20253, 3),
(7006, 6003, 20013, 4),
(7007, 6003, 20191, 1),
(7008, 6003, 20143, 1),
(7009, 6003, 20113, 4),
(7010, 6004, 20012, 5),
(7011, 6004, 20013, 5),
(7012, 6005, 20192, 1),
(7013, 6005, 20102, 5),
(7014, 6006, 20062, 4),
(7015, 6006, 20113, 1),
(7016, 6006, 20232, 1),
(7017, 6007, 20191, 1),
(7018, 6007, 20192, 5),
(7019, 6007, 20272, 3),
(7020, 6007, 20103, 2),
(7021, 6008, 20233, 1),
(7022, 6008, 20091, 5),
(7023, 6008, 20271, 2),
(7024, 6008, 20222, 1),
(7025, 6009, 20142, 4),
(7026, 6009, 20112, 3),
(7027, 6009, 20223, 1),
(7028, 6009, 20062, 1),
(7029, 6010, 20152, 3),
(7030, 6011, 20281, 5),
(7031, 6012, 20072, 5),
(7032, 6012, 20023, 5),
(7033, 6013, 20153, 2),
(7034, 6013, 20101, 4),
(7035, 6013, 20281, 5),
(7036, 6013, 20041, 4),
(7037, 6014, 20272, 1),
(7038, 6015, 20022, 2),
(7039, 6015, 20031, 1),
(7040, 6015, 20131, 4),
(7041, 6015, 20231, 4);

--PaymentType
INSERT INTO PaymentType (PaymentTypeID, Value) VALUES
(100, 'Credit Card'),
(101, 'Debit Card'),
(102, 'PayPal'),
(103, 'Apple Pay'),
(104, 'Google Pay'),
(105, 'Bank Transfer'),
(106, 'Crypto'),
(107, 'Cash on Delivery'),
(108, 'Gift Card'),
(109, 'Other');

--PaymentMethod: Each customer have one default paymentmethod 
INSERT INTO PaymentMethod (PaymentMethodID, CustomerID, PaymentTypeID, Provider, AccountNumber, ExpirationDate, IsDefault)
VALUES
(8001, 1001, 100, 'Google', '5174450609039025', '2025-08-14', 0),
(8002, 1001, 105, 'Chase', '4651135122832', '2028-04-01', 1),
(8003, 1001, 101, 'PayPal', '30169838548672', '2025-09-19', 0),
(8004, 1002, 105, 'Visa', '3561548005213585', '2028-10-16', 1),
(8005, 1003, 102, 'Visa', '639058393518', '2028-12-10', 0),
(8006, 1003, 103, 'PayPal', '4015766755027183', '2026-09-15', 1),
(8007, 1004, 103, 'Visa', '4507692577359908', '2028-02-17', 1),
(8008, 1005, 100, 'Chase', '3581319267349913', '2025-04-10', 1),
(8009, 1006, 109, 'Discover', '30002072362031', '2025-12-14', 1),
(8010, 1006, 102, 'Amex', '213131280368792', '2025-04-17', 0),
(8011, 1007, 107, 'PayPal', '3586407273137052', '2028-08-02', 1),
(8012, 1007, 104, 'Amex', '6011626986426845', '2029-02-15', 0),
(8013, 1008, 105, 'PayPal', '4615087469775783', '2027-05-28', 1),
(8014, 1009, 104, 'Coinbase', '4533446644201', '2026-04-13', 0),
(8015, 1009, 105, 'Amex', '4388770987009133', '2027-09-13', 1),
(8016, 1010, 101, 'Coinbase', '2703269423499745', '2026-06-12', 1),
(8017, 1010, 109, 'Chase', '4386330824953431', '2028-11-14', 0),
(8018, 1010, 102, 'Apple', '3589174830566788', '2026-11-06', 0),
(8019, 1011, 103, 'PayPal', '6548459400516591', '2027-05-17', 1),
(8020, 1012, 103, 'Amex', '30582206931231', '2026-07-16', 1),
(8021, 1012, 104, 'PayPal', '4943408239559371744', '2026-02-11', 0),
(8022, 1012, 106, 'Visa', '6506061735027870', '2028-02-20', 0),
(8023, 1013, 106, 'MasterCard', '6011223710180086', '2026-08-20', 1),
(8024, 1014, 102, 'Apple', '4503781934403725', '2028-06-26', 1),
(8025, 1014, 104, 'Coinbase', '4007586008022', '2027-08-06', 0),
(8026, 1014, 106, 'Amex', '2247888303702028', '2027-03-07', 0),
(8027, 1015, 104, 'PayPal', '4158697933143', '2028-05-17', 0),
(8028, 1015, 101, 'Discover', '6562449403337013', '2028-10-22', 1),
(8029, 1015, 107, 'PayPal', '6517057704943292', '2028-10-31', 0);

--ShippingMethod
INSERT INTO ShippingMethod (ShippingMethodID, ShippingMethodName, Price) VALUES
(200, 'Standard Shipping', 5.00),
(201, 'Express Shipping', 15.00),
(202, 'Next-Day Delivery', 25.00),
(203, 'Store Pickup', 0.00),
(204, 'International Shipping', 30.00),
(205, 'Weekend Delivery', 10.00),
(206, 'Eco Shipping', 3.00),
(207, 'Drone Delivery', 50.00),
(208, 'Two-Day Shipping', 12.00),
(209, 'Same-Day Delivery', 40.00);

--OrderStatus
INSERT INTO OrderStatus (OrderStatusID, Status) VALUES
(300, 'Pending'),
(301, 'Processing'),
(302, 'Shipped'),
(303, 'Out for Delivery'),
(304, 'Delivered'),
(305, 'Cancelled'),
(306, 'Refund Requested'),
(307, 'Refunded'),
(308, 'On Hold'),
(309, 'Failed');

--Coupon
INSERT INTO Coupon (CouponID, CouponName, Description, DiscountRate, StartDate, EndDate) VALUES
(400, 'WELCOME10', '10% off for first-time customers', 10.00, '2024-01-01', '2025-12-31'),
(401, 'FREESHIP50', 'Free shipping on orders over $50', 5.00, '2024-06-01', '2025-06-01'),
(402, 'SUMMER20', 'Summer Sale - 20% off select categories', 20.00, '2024-06-15', '2024-09-15'),
(403, 'BULKBUY15', '15% off when you buy 3 or more items', 15.00, '2024-03-01', '2025-03-01'),
(404, 'HOLIDAY25', 'Holiday special - 25% off storewide', 25.00, '2024-12-01', '2025-01-10'),
(405, 'APPONLY5', '5% off for mobile app users', 5.00, '2024-01-01', '2025-12-31'),
(406, 'FLASH30', 'Flash Deal - 30% off electronics for 48 hours', 30.00, '2025-04-01', '2025-04-03'),
(407, 'STUDENT10', '10% off for students with valid ID', 10.00, '2024-09-01', '2025-09-01'),
(408, 'VIP20', 'Exclusive 20% discount for VIP members', 20.00, '2024-02-01', '2025-02-01'),
(409, 'WEEKEND15', '15% off every weekend', 15.00, '2024-01-01', '2025-12-31');

--CouponCategory
INSERT INTO CouponCategory (CategoryID, CouponID)
VALUES
(11, 400),
(11, 401),
(11, 404),
(11, 405),
(11, 406),
(11, 407),
(11, 408),
(11, 409),
(12, 400),
(12, 401),
(12, 405),
(12, 406),
(12, 407),
(12, 408),
(12, 409),
(13, 400),
(13, 401),
(13, 405),
(13, 406),
(13, 407),
(13, 408),
(13, 409),
(21, 400),
(21, 401),
(21, 402),
(21, 405),
(21, 407),
(21, 408),
(21, 409),
(22, 400),
(22, 401),
(22, 402),
(22, 405),
(22, 407),
(22, 408),
(22, 409),
(31, 400),
(31, 401),
(31, 403),
(31, 405),
(31, 407),
(31, 408),
(31, 409),
(32, 400),
(32, 401),
(32, 403),
(32, 405),
(32, 407),
(32, 408),
(32, 409);

--ShopOrder
INSERT INTO ShopOrder (OrderID, CustomerID, AddressID, PaymentID, OrderStatusID, ShippingMethodID, OrderTotal, OrderDate)
VALUES
(5000, 1001, 5014, 8002, 306, 201, 10175.8, '2025-03-03'),
(5001, 1001, 5013, 8001, 300, 204, 13188.29, '2024-04-13'),
(5002, 1001, 5014, 8002, 309, 204, 420.63, '2024-08-31'),
(5003, 1002, 5022, 8004, 304, 203, 5627.37, '2025-03-05'),
(5004, 1003, 5010, 8006, 302, 202, 4732.66, '2024-04-16'),
(5005, 1003, 5010, 8005, 309, 202, 4467.69, '2024-05-25'),
(5006, 1004, 5017, 8007, 305, 207, 6645.23, '2024-05-12'),
(5007, 1004, 5009, 8007, 302, 200, 509.3, '2024-05-25'),
(5008, 1005, 5011, 8008, 302, 205, 2073.05, '2024-12-26'),
(5009, 1005, 5011, 8008, 309, 203, 3747.48, '2024-05-01'),
(5010, 1005, 5011, 8008, 302, 208, 8646.04, '2024-09-22'),
(5011, 1006, 5008, 8009, 309, 201, 3888.04, '2025-03-15'),
(5012, 1006, 5008, 8010, 306, 204, 3808.99, '2024-08-22'),
(5013, 1006, 5018, 8010, 304, 204, 8297.64, '2024-06-24'),
(5014, 1007, 5019, 8012, 303, 206, 4905.58, '2024-11-29'),
(5015, 1007, 5019, 8011, 309, 206, 41.74, '2025-03-17'),
(5016, 1007, 5019, 8012, 309, 203, 2646.92, '2024-06-05'),
(5017, 1008, 5021, 8013, 305, 207, 2168.82, '2024-12-27'),
(5018, 1008, 5021, 8013, 304, 202, 2256.09, '2025-01-01'),
(5019, 1009, 5007, 8015, 303, 207, 1292.86, '2024-12-24'),
(5020, 1009, 5002, 8014, 303, 202, 6270.31, '2024-07-14'),
(5021, 1010, 5012, 8018, 306, 204, 6911.02, '2025-02-13'),
(5022, 1011, 5023, 8019, 304, 200, 972.36, '2025-02-28'),
(5023, 1011, 5023, 8019, 306, 206, 907.18, '2024-05-03'),
(5024, 1012, 5024, 8022, 300, 209, 1466.76, '2025-02-27'),
(5025, 1012, 5024, 8022, 304, 205, 1254.19, '2024-12-12'),
(5026, 1012, 5024, 8021, 308, 202, 2507.1, '2024-12-24'),
(5027, 1013, 5025, 8023, 300, 201, 3606.88, '2024-09-10'),
(5028, 1013, 5025, 8023, 300, 205, 6011.21, '2024-08-04'),
(5029, 1013, 5025, 8023, 306, 202, 6524.73, '2025-01-05'),
(5030, 1014, 5026, 8025, 302, 209, 7312.52, '2024-07-23'),
(5031, 1014, 5026, 8026, 300, 202, 3371.89, '2024-12-10'),
(5032, 1014, 5026, 8025, 300, 208, 366.38, '2024-08-01'),
(5033, 1015, 5028, 8027, 305, 209, 6192.55, '2024-11-08'),
(5034, 1015, 5027, 8029, 302, 204, 4307.15, '2024-10-31'),
(5035, 1015, 5028, 8028, 304, 204, 1825.41, '2025-01-24');

INSERT INTO OrderLine (OrderLineID, OrderID, ProductItemID, Quantity, Price, CouponID)
VALUES
(7000, 5000, 20043, 3, 451.41, NULL),
(7001, 5000, 20231, 2, 1739.86, 401),
(7002, 5000, 20253, 2, 2306.84, 408),
(7003, 5001, 20181, 2, 2889.42, NULL),
(7004, 5001, 20113, 3, 3319.14, 405),
(7005, 5002, 20163, 2, 3505.44, 408),
(7006, 5002, 20131, 2, 2281.76, NULL),
(7007, 5002, 20221, 1, 96.22, NULL),
(7008, 5002, 20042, 1, 420.13, 407),
(7009, 5003, 20051, 1, 805.79, NULL),
(7010, 5003, 20171, 2, 3378.78, NULL),
(7011, 5003, 20022, 3, 1874.22, 408),
(7012, 5004, 20162, 3, 299.58, 401),
(7013, 5004, 20043, 1, 150.47, 405),
(7014, 5004, 20012, 3, 2082.12, 409),
(7015, 5004, 20111, 3, 954.93, NULL),
(7016, 5005, 20212, 2, 1565.98, 409),
(7017, 5005, 20291, 2, 1191.1, NULL),
(7018, 5005, 20261, 1, 1002.2, NULL),
(7019, 5006, 20192, 3, 482.13, NULL),
(7020, 5006, 20162, 3, 299.58, 405),
(7021, 5006, 20222, 3, 4100.34, NULL),
(7022, 5007, 20073, 2, 2365.78, NULL),
(7023, 5007, 20113, 2, 2212.76, NULL),
(7024, 5007, 20291, 2, 1191.1, NULL),
(7025, 5007, 20241, 1, 1226.63, 401),
(7026, 5008, 20011, 3, 5460.15, 405),
(7027, 5008, 20182, 3, 482.16, 402),
(7028, 5008, 20211, 3, 5814.39, 405),
(7029, 5009, 20023, 1, 1383.6, 401),
(7030, 5009, 20261, 2, 2004.4, NULL),
(7031, 5009, 20102, 1, 813.96, NULL),
(7032, 5009, 20112, 3, 2799.15, NULL),
(7033, 5010, 20201, 2, 1362.52, 401),
(7034, 5010, 20163, 3, 5258.16, 409),
(7035, 5011, 20251, 3, 5321.82, 400),
(7036, 5011, 20241, 3, 3679.89, 407),
(7037, 5011, 20131, 3, 3422.64, 406),
(7038, 5011, 20212, 3, 2348.97, NULL),
(7039, 5012, 20081, 1, 408.12, 406),
(7040, 5012, 20051, 2, 1611.58, 408),
(7041, 5012, 20272, 1, 1625.76, NULL),
(7042, 5012, 20103, 1, 1292.75, NULL),
(7043, 5013, 20013, 2, 549.82, 406),
(7044, 5013, 20242, 3, 5121.24, NULL),
(7045, 5014, 20163, 3, 5258.16, NULL),
(7046, 5014, 20151, 2, 2700.04, 401),
(7047, 5014, 20162, 2, 199.72, 402),
(7048, 5015, 20251, 3, 5321.82, 405),
(7049, 5015, 20022, 1, 624.74, NULL),
(7050, 5016, 20121, 3, 5933.13, NULL),
(7051, 5016, 20163, 1, 1752.72, NULL),
(7052, 5016, 20151, 1, 1350.02, 402),
(7053, 5016, 20043, 2, 300.94, 404),
(7054, 5017, 20201, 1, 681.26, 407),
(7055, 5017, 20163, 1, 1752.72, 400),
(7056, 5018, 20252, 2, 776.94, NULL),
(7057, 5018, 20212, 3, 2348.97, 405),
(7058, 5018, 20163, 2, 3505.44, NULL),
(7059, 5019, 20252, 1, 388.47, 401),
(7060, 5019, 20072, 2, 1511.2, NULL),
(7061, 5020, 20082, 1, 155.79, 406),
(7062, 5020, 20111, 3, 954.93, NULL),
(7063, 5020, 20023, 1, 1383.6, NULL),
(7064, 5020, 20171, 2, 3378.78, 408),
(7065, 5021, 20112, 2, 1866.1, 401),
(7066, 5021, 20091, 1, 1808.92, NULL),
(7067, 5022, 20201, 2, 1362.52, NULL),
(7068, 5022, 20113, 3, 3319.14, 409),
(7069, 5022, 20231, 1, 869.93, NULL),
(7070, 5022, 20111, 3, 954.93, NULL),
(7071, 5023, 20072, 3, 2266.8, NULL),
(7072, 5023, 20192, 2, 321.42, NULL),
(7073, 5023, 20082, 2, 311.58, NULL),
(7074, 5023, 20231, 3, 2609.79, NULL),
(7075, 5024, 20252, 1, 388.47, NULL),
(7076, 5024, 20261, 2, 2004.4, 405),
(7077, 5025, 20043, 2, 300.94, 404),
(7078, 5025, 20272, 2, 3251.52, NULL),
(7079, 5025, 20072, 1, 755.6, NULL),
(7080, 5026, 20113, 2, 2212.76, NULL),
(7081, 5026, 20272, 3, 4877.28, 408),
(7082, 5027, 20121, 3, 5933.13, NULL),
(7083, 5027, 20152, 1, 1099.32, NULL),
(7084, 5027, 20161, 3, 5403.12, 400),
(7085, 5027, 20151, 2, 2700.04, NULL),
(7086, 5028, 20261, 1, 1002.2, NULL),
(7087, 5028, 20021, 3, 3031.59, 408),
(7088, 5028, 20023, 2, 2767.2, 407),
(7089, 5028, 20061, 1, 913.62, 409),
(7090, 5029, 20211, 2, 3876.26, 401),
(7091, 5029, 20281, 1, 1292.73, 405),
(7092, 5029, 20162, 1, 99.86, 400),
(7093, 5030, 20241, 3, 3679.89, 400),
(7094, 5030, 20222, 2, 2733.56, 409),
(7095, 5031, 20011, 3, 5460.15, NULL),
(7096, 5032, 20022, 3, 1874.22, 405),
(7097, 5033, 20072, 2, 1511.2, NULL),
(7098, 5034, 20151, 1, 1350.02, NULL),
(7099, 5035, 20071, 2, 915.96, 407);

--Review
INSERT INTO Review (ReviewID, CustomerID, OrderLineID, Rating, Comment, ReviewDate)
VALUES
(9100, 1001, 7089, 4, 'Would recommend', '2024-11-17'),
(9101, 1002, 7003, 5, 'Really liked it', '2024-07-02'),
(9102, 1003, 7022, 4, 'Exactly what I wanted', '2024-11-09'),
(9103, 1004, 7001, 5, 'Would recommend', '2025-02-04'),
(9104, 1005, 7076, 4, 'Impressed!', '2024-10-17'),
(9105, 1006, 7068, 5, 'Product matched description', '2025-01-21'),
(9106, 1007, 7034, 3, 'Product matched description', '2025-02-18'),
(9107, 1008, 7045, 4, 'No issues at all', '2024-12-25'),
(9108, 1009, 7026, 5, 'Fantastic experience', '2025-01-02'),
(9109, 1010, 7049, 5, 'Exactly what I wanted', '2025-01-01'),
(9110, 1001, 7025, 3, 'Product matched description', '2025-03-27'),
(9111, 1002, 7040, 3, 'Exactly what I wanted', '2025-02-02'),
(9112, 1003, 7023, 4, 'Product matched description', '2025-01-04'),
(9113, 1004, 7097, 4, 'Would recommend', '2024-07-27'),
(9114, 1005, 7063, 5, 'Impressed!', '2025-02-16'),
(9115, 1006, 7084, 5, 'Product matched description', '2024-06-05'),
(9116, 1007, 7019, 3, 'Awesome service', '2024-08-10'),
(9117, 1008, 7078, 3, 'Great quality!', '2024-12-15'),
(9118, 1009, 7075, 4, 'Awesome service', '2024-11-08'),
(9119, 1010, 7064, 5, 'Exactly what I wanted', '2024-07-14'),
(9120, 1001, 7052, 5, 'Great quality!', '2025-03-24'),
(9121, 1002, 7081, 5, 'Really liked it', '2024-06-25'),
(9122, 1003, 7029, 3, 'Great quality!', '2024-06-15'),
(9123, 1004, 7000, 3, 'Great quality!', '2024-08-07'),
(9124, 1005, 7006, 5, 'Would recommend', '2024-12-26'),
(9125, 1006, 7055, 4, 'No issues at all', '2024-06-29'),
(9126, 1007, 7004, 5, 'Fantastic experience', '2025-03-05'),
(9127, 1008, 7017, 3, 'No issues at all', '2024-08-05'),
(9128, 1009, 7080, 5, 'Really liked it', '2024-08-26'),
(9129, 1010, 7010, 3, 'Fantastic experience', '2024-10-26');


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
INSERT INTO CustomerSupportTicket (TicketID, CustomerID, OrderLineID, IssueDescription, TicketStatusID, CreatedDate)
VALUES
(10000, 1008, 7054, 'Delivery took longer than expected', 5, '2025-03-01'),
(10001, 1010, 7065, 'Payment went through twice', 2, '2025-02-28'),
(10002, 1003, 7016, 'Wrong item delivered', 6, '2025-02-27'),
(10003, 1001, 7005, 'Item missing from package', 3, '2025-03-01'),
(10004, 1006, 7041, 'Need replacement due to damage', 4, '2025-02-20'),
(10005, 1004, 7022, 'Product quality not as described', 6, '2025-01-26'),
(10006, 1015, 7099, 'Return request', 1, '2025-01-30'),
(10007, 1010, 7064, 'Package was tampered with', 7, '2025-01-29'),
(10008, 1012, 7077, 'Item was already opened', 6, '2025-02-15'),
(10009, 1014, 7094, 'Need refund process update', 8, '2025-02-10'),
(10010, 1002, 7009, 'Did not receive full order', 10, '2025-03-02'),
(10011, 1007, 7050, 'Change shipping address', 3, '2025-02-24'),
(10012, 1014, 7091, 'Customer changed mind', 9, '2025-01-20'),
(10013, 1007, 7042, 'Broken upon arrival', 2, '2025-02-01'),
(10014, 1011, 7066, 'Incorrect billing info', 4, '2025-01-18'),
(10015, 1007, 7047, 'Still waiting for resolution', 1, '2025-01-25'),
(10016, 1012, 7073, 'Product color not as shown', 5, '2025-02-07'),
(10017, 1012, 7075, 'Wrong delivery address', 6, '2025-01-27'),
(10018, 1007, 7044, 'Instructions were missing', 2, '2025-02-22'),
(10019, 1014, 7096, 'Package lost in transit', 4, '2025-01-30'),
(10020, 1009, 7059, 'Defective item', 6, '2025-02-05'),
(10021, 1006, 7040, 'Asked for earlier delivery', 8, '2025-02-11'),
(10022, 1012, 7072, 'Charged wrong amount', 2, '2025-01-30'),
(10023, 1011, 7067, 'Did not apply coupon discount', 3, '2025-02-14'),
(10024, 1011, 7071, 'Support hasn’t responded', 5, '2025-01-17'),
(10025, 1001, 7000, 'Tracking number invalid', 4, '2025-02-09'),
(10026, 1003, 7017, 'Warranty request', 7, '2025-02-21'),
(10027, 1001, 7002, 'App crashed during checkout', 1, '2025-02-19'),
(10028, 1005, 7027, 'Size not matching description', 6, '2025-02-20'),
(10029, 1001, 7004, 'Delayed refund', 5, '2025-03-02');
