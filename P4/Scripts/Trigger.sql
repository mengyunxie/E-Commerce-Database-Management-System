-- ========================================
-- Trigger.sql - Trigger Script
-- Team: 3
-- E-Commerce Database Management System
-- ========================================

USE E_COMMERCE;


/*
 * Trigger for OrderLine to calculate price when inserted or updated
 */
CREATE TRIGGER trg_OrderLine_CalculatePrice
ON OrderLine
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Update the Price field in OrderLine based on ProductItem price, discount, and quantity
    UPDATE ol
    SET ol.Price = pi.Price * (1 - ISNULL(c.DiscountRate, 0)/100) * ol.Quantity
    FROM OrderLine ol
    INNER JOIN inserted i ON ol.OrderLineID = i.OrderLineID
    INNER JOIN ProductItem pi ON ol.ProductItemID = pi.ProductItemID
    LEFT JOIN Coupon c ON ol.CouponID = c.CouponID;
    
    -- Now update the corresponding ShopOrder total
    UPDATE so
    SET so.OrderTotal = (SELECT SUM(ol.Price) FROM OrderLine ol WHERE ol.OrderID = so.OrderID) + 
                        (SELECT sm.Price FROM ShippingMethod sm WHERE sm.ShippingMethodID = so.ShippingMethodID)
    FROM ShopOrder so
    INNER JOIN inserted i ON so.OrderID = i.OrderID;
END;


/*
 * Trigger for OrderLine when items are deleted
 */
CREATE TRIGGER trg_OrderLine_Delete
ON OrderLine
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Update the ShopOrder total when OrderLine items are deleted
    UPDATE so
    SET so.OrderTotal = (SELECT ISNULL(SUM(ol.Price), 0) FROM OrderLine ol WHERE ol.OrderID = so.OrderID) + 
                        (SELECT sm.Price FROM ShippingMethod sm WHERE sm.ShippingMethodID = so.ShippingMethodID)
    FROM ShopOrder so
    INNER JOIN deleted d ON so.OrderID = d.OrderID;
END;

