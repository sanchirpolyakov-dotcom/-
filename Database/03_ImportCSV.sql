-- Импорт городов (уникальные из orders_raw)
INSERT INTO Cities (Name)
SELECT DISTINCT TRIM(SUBSTRING(Откуда, 1, CHARINDEX(',', Откуда + ',') - 1)) FROM OpenRowSet(...)
-- Для простоты можно вставить вручную
INSERT INTO Cities (Name) VALUES ('Москва'), ('Тверь'), ('Подольск'), ('Калуга'), ('Рязань'), ('Тула'), ('Химки');

-- Импорт водителей
INSERT INTO Drivers (Id, FullName, Phone, Rating, DriverStatusId)
VALUES 
('DR001', 'Сидоров Иван Петрович', '+7(900)111-22-33', 4.8, (SELECT Id FROM DriverStatuses WHERE Name = 'Свободен')),
('DR002', 'Петров Алексей Иванович', '+7(900)222-33-44', 4.5, (SELECT Id FROM DriverStatuses WHERE Name = 'На заказе')),
('DR003', 'Коваленко Дмитрий Сергеевич', '+7(900)333-44-55', 5.0, (SELECT Id FROM DriverStatuses WHERE Name = 'Не работает')),
('DR004', 'Алиев Руслан Магомедович', '+7(900)444-55-66', 4.2, (SELECT Id FROM DriverStatuses WHERE Name = 'Свободен')),
('DR005', 'Миронов Сергей Витальевич', '+7(900)555-66-77', 4.9, (SELECT Id FROM DriverStatuses WHERE Name = 'На заказе'));

-- Импорт транспорта
INSERT INTO Vehicles (DriverId, Make, LicensePlate, CapacityTon, VolumeM3, BodyTypeId, HasCenterPass)
SELECT 
    d.Id, 
    CASE d.Id 
        WHEN 'DR001' THEN 'Газель Некст'
        WHEN 'DR002' THEN 'Ford Transit'
        WHEN 'DR003' THEN 'Hyundai Porter'
        WHEN 'DR004' THEN 'Scania R420'
        WHEN 'DR005' THEN 'Lada Largus'
    END,
    CASE d.Id 
        WHEN 'DR001' THEN 'А123АА77'
        WHEN 'DR002' THEN 'В456ВВ77'
        WHEN 'DR003' THEN 'С789СС77'
        WHEN 'DR004' THEN 'Е012ЕЕ77'
        WHEN 'DR005' THEN 'К345КК77'
    END,
    CASE d.Id 
        WHEN 'DR001' THEN 1.5 WHEN 'DR002' THEN 2.0 WHEN 'DR003' THEN 1.0 WHEN 'DR004' THEN 20.0 WHEN 'DR005' THEN 0.5
    END,
    CASE d.Id 
        WHEN 'DR001' THEN 18 WHEN 'DR002' THEN 12 WHEN 'DR003' THEN 8 WHEN 'DR004' THEN 90 WHEN 'DR005' THEN 2
    END,
    (SELECT Id FROM BodyTypes WHERE Name = 
        CASE d.Id 
            WHEN 'DR001' THEN 'Тент' WHEN 'DR002' THEN 'Фургон' WHEN 'DR003' THEN 'Рефрижератор' 
            WHEN 'DR004' THEN 'Еврофура' WHEN 'DR005' THEN 'Фургон'
        END),
    0
FROM Drivers d;

-- Импорт заказов (аналогично, упрощённо)
INSERT INTO Orders (Id, OrderDate, OriginCityId, DestCityId, CargoTypeId, WeightKg, VolumeM3, Price, StatusId)
VALUES 
('ORD101', '2023-10-25', (SELECT Id FROM Cities WHERE Name = 'Москва'), (SELECT Id FROM Cities WHERE Name = 'Тверь'),
 (SELECT Id FROM CargoTypes WHERE Name = 'Стройматериалы'), 1200, 4, 8000, (SELECT Id FROM OrderStatuses WHERE Name = 'В работе')),
('ORD102', '2023-10-25', (SELECT Id FROM Cities WHERE Name = 'Подольск'), (SELECT Id FROM Cities WHERE Name = 'Калуга'),
 (SELECT Id FROM CargoTypes WHERE Name = 'Оборудование'), 500, 2, 4500, (SELECT Id FROM OrderStatuses WHERE Name = 'Поиск машины')),
...
