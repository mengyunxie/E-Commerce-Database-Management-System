

/*
 * View: CustomerPurchaseHistory
 * This helps customer service representatives quickly view a customer's complete purchase history 
 * when handling support calls. It combines data from multiple tables into a single, easy-to-query view.
 */
CREATE VIEW CustomerPurchaseHistory AS
SELECT 
    c.CustomerID,
    c.FirstName + ' ' + c.LastName AS CustomerName,
    c.Email,
    o.OrderID,
    o.OrderDate,
    os.Status AS OrderStatus,
    p.ProductName,
    pi.SKU,
    ol.Quantity,
    ol.Price AS UnitPrice,
    (ol.Quantity * ol.Price) AS LineTotal
FROM Customer c
JOIN ShopOrder o ON c.CustomerID = o.CustomerID
JOIN OrderStatus os ON o.OrderStatusID = os.OrderStatusID
JOIN OrderLine ol ON o.OrderID = ol.OrderID
JOIN ProductItem pi ON ol.ProductItemID = pi.ProductItemID
JOIN Product p ON pi.ProductID = p.ProductID;

-- Usage CustomerPurchaseHistory View
SELECT * FROM CustomerPurchaseHistory ORDER BY CustomerID, OrderDate DESC;



/*
 * View: ProductSalesPerformance
 * Marketing and product teams use this view to identify top-performing products, analyze sales patterns, 
 * and make inventory decisions. The view combines sales data with customer reviews to provide a comprehensive performance picture.
 */
CREATE VIEW ProductSalesPerformance AS
SELECT 
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    COUNT(DISTINCT o.OrderID) AS NumberOfOrders,
    SUM(ol.Quantity) AS TotalQuantitySold,
    SUM(ol.Quantity * ol.Price) AS Revenue,
    AVG(r.Rating) AS AverageRating,
    COUNT(r.ReviewID) AS NumberOfReviews
FROM Product p
JOIN Category c ON p.CategoryID = c.CategoryID
JOIN ProductItem pi ON p.ProductID = pi.ProductID
LEFT JOIN OrderLine ol ON pi.ProductItemID = ol.ProductItemID
LEFT JOIN ShopOrder o ON ol.OrderID = o.OrderID
LEFT JOIN Review r ON ol.OrderLineID = r.OrderLineID
GROUP BY p.ProductID, p.ProductName, c.CategoryName;

-- Usage ProductSalesPerformance View
SELECT * FROM ProductSalesPerformance ORDER BY AverageRating DESC;




/*
 * View: OrderFulfillmentStatus
 * Warehouse and shipping teams use this view to manage order fulfillment priorities 
 * and track processing times. It provides a complete picture of orders that need to be processed, 
 * packed, and shipped.
 */

CREATE VIEW OrderFulfillmentStatus AS
SELECT 
    o.OrderID,
    o.OrderDate,
    c.FirstName + ' ' + c.LastName AS CustomerName,
    os.Status AS OrderStatus,
    CONCAT(a.AddressLine1, ', ', a.City, ', ', a.State, ' ', a.PostalCode) AS ShippingAddress,
    sm.ShippingMethodName,
    SUM(ol.Quantity) AS TotalItems,
    o.OrderTotal AS OrderValue,
    DATEDIFF(day, o.OrderDate, GETDATE()) AS DaysSinceOrder
FROM ShopOrder o
JOIN Customer c ON o.CustomerID = c.CustomerID
JOIN OrderStatus os ON o.OrderStatusID = os.OrderStatusID
JOIN Address a ON o.AddressID = a.AddressID
JOIN ShippingMethod sm ON o.ShippingMethodID = sm.ShippingMethodID
JOIN OrderLine ol ON o.OrderID = ol.OrderID
GROUP BY o.OrderID, o.OrderDate, c.FirstName, c.LastName, os.Status, 
         a.AddressLine1, a.City, a.State, a.PostalCode, sm.ShippingMethodName, 
         o.OrderTotal;

-- Usage OrderFulfillmentStatus View
SELECT * FROM OrderFulfillmentStatus ORDER BY OrderValue DESC;




/*
 * View: CustomerSupportDashboard
 * Customer support representatives use this view to manage and prioritize support tickets. 
 * It provides essential context about customers and their issues, 
 * helping to streamline the support process.
 */

CREATE VIEW CustomerSupportDashboard AS
SELECT 
    cst.TicketID,
    FORMAT(cst.CreatedDate, 'yyyy-MM-dd hh:mm tt') AS CreatedDate,
    ts.Status AS TicketStatus,
    c.CustomerID,
    c.FirstName + ' ' + c.LastName AS CustomerName,
    c.Email,
    c.PhoneNumber,
    o.OrderID,
    p.ProductName,
    cst.IssueDescription,
    DATEDIFF(hour, cst.CreatedDate, GETDATE()) AS HoursOpen
FROM CustomerSupportTicket cst
JOIN Customer c ON cst.CustomerID = c.CustomerID
JOIN TicketStatus ts ON cst.TicketStatusID = ts.TicketStatusID
LEFT JOIN OrderLine ol ON cst.OrderLineID = ol.OrderLineID
LEFT JOIN ShopOrder o ON ol.OrderID = o.OrderID
LEFT JOIN ProductItem pi ON ol.ProductItemID = pi.ProductItemID
LEFT JOIN Product p ON pi.ProductID = p.ProductID;

-- Usage CustomerSupportDashboard View
SELECT * FROM CustomerSupportDashboard ORDER BY CreatedDate DESC;




/*
 * View: CustomerPublicInfo
 * This view provides limited customer data to departments that need basic information 
 * but shouldn't have access to sensitive details like phone numbers or address information. 
 * Instead of granting access to the full Customer table, you can grant access to this view.
 */
CREATE VIEW CustomerPublicInfo AS
SELECT 
    CustomerID,
    FirstName,
    LastName,
    Email,
    FORMAT(RegistrationDate, 'yyyy-MM-dd hh:mm tt') AS RegistrationDate
FROM Customer;

-- Usage CustomerPublicInfo View
SELECT * FROM CustomerPublicInfo ORDER BY CustomerID DESC;




/*
 * View: SecurePaymentInfo
 * Customer service representatives need to see payment methods to help customers 
 * but should not have access to complete account numbers. This view masks sensitive 
 * information while providing necessary context.
 */
CREATE VIEW SecurePaymentInfo AS
SELECT 
    PaymentMethodID,
    CustomerID,
    PaymentTypeID,
    Provider,
    -- Mask account number to show only last 4 digits
    'xxxx-xxxx-xxxx-' + RIGHT(AccountNumber, 4) AS MaskedAccountNumber,
    FORMAT(ExpirationDate, 'yyyy-MM-dd hh:mm tt') AS ExpirationDate,
    IsDefault
FROM PaymentMethod;

-- Usage SecurePaymentInfo View
SELECT * FROM SecurePaymentInfo ORDER BY CustomerID DESC;
