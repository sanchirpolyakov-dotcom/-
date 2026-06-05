USE TransLogisticDB;
GO

INSERT INTO DriverStatuses (Name) VALUES ('Свободен'), ('На заказе'), ('Не работает');
INSERT INTO BodyTypes (Name) VALUES ('Тент'), ('Фургон'), ('Борт'), ('Рефрижератор'), ('Изотерм');
INSERT INTO CargoTypes (Name) VALUES ('Стройматериалы'), ('Продукты'), ('Мебель'), ('Оборудование'), ('Личные вещи'), ('Опасный груз');
INSERT INTO OrderStatuses (Name, SortOrder) VALUES 
    ('Поиск машины', 1), ('Машина назначена', 2), ('В пути', 3), ('Завершен', 4), ('Отменен', 5);
