-- ========================================
-- Trigger.sql - Trigger Script for updating order totals
-- Team: 3
-- E-Commerce Database Management System
-- ========================================

USE E_COMMERCE;

CREATE TRIGGER trg_UpdateOrderTotal 
ON OrderLine 
AFTER INSERT, UPDATE, DELETE AS 
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Temporary table to store affected OrderIDs
        DECLARE @AffectedOrders TABLE (OrderID INT);
        
        -- Collect affected OrderIDs from inserted and deleted rows
        INSERT INTO @AffectedOrders (OrderID)
        SELECT DISTINCT OrderID FROM inserted
        UNION
        SELECT DISTINCT OrderID FROM deleted
        WHERE OrderID IS NOT NULL;
        
        -- Update OrderTotal in ShopOrder for affected orders
        UPDATE so
        SET OrderTotal = (
            SELECT COALESCE(SUM(ol.Quantity * ol.Price * 
                   (1 - COALESCE(c.DiscountRate, 0))), 0)
            FROM OrderLine ol
            LEFT JOIN Coupon c ON ol.CouponID = c.CouponID
                AND CAST(GETDATE() AS DATE) BETWEEN c.StartDate AND c.EndDate
            WHERE ol.OrderID = so.OrderID
        )
        FROM ShopOrder so
        WHERE so.OrderID IN (SELECT OrderID FROM @AffectedOrders);
    END TRY
    BEGIN CATCH
        PRINT 'Error for updating order totals'
        THROW;
    END CATCH
END;
