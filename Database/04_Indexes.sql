USE TransLogisticDB;
GO

CREATE NONCLUSTERED INDEX IX_Orders_OrderDate_Status ON Orders(OrderDate, StatusId);
CREATE NONCLUSTERED INDEX IX_Orders_OriginCity_DestCity ON Orders(OriginCityId, DestCityId);
CREATE NONCLUSTERED INDEX IX_OrderAssignments_DriverId ON OrderAssignments(DriverId);
