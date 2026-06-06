# ТрансЛогистСервис — курсовой проект (ТЗ № 45/19-КП)

Информационная система автоматизации поиска попутных грузов для ООО «ТрансЛогистСервис».

## Состав решения

| Компонент | Технология | Папка |
|-----------|------------|-------|
| База данных MS SQL Server | SQL, Views, SP | `Database/` |
| Административный модуль (диспетчер) | C# WinForms + **ADO.NET** | `src/Dispatcher/` |
| Клиентский модуль (водитель) | C# WinForms + **Entity Framework Core** | `src/Driver/` |
| Исходные данные | CSV, JSON | `Data/` |

## Требования

- Windows 10/11
- **Visual Studio 2022** (рабочая нагрузка «Разработка классических приложений .NET»)
- **SQL Server** или **LocalDB** (входит в Visual Studio)
- .NET SDK 8+ (в проекте используется .NET 10)

## Быстрый старт

### 1. Создание базы данных

В PowerShell из корня проекта:

```powershell
cd Database
.\Deploy.ps1
```

Либо в **SQL Server Management Studio** по очереди выполните файлы:
`01_CreateDatabase.sql` → `02_Schema.sql` → `03_Indexes_Views_Procedures.sql` → `04_SeedData.sql`

### 2. Открытие в Visual Studio

Откройте файл `TransLogistService.sln`.

Строка подключения (по умолчанию LocalDB):

```
Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=TransLogistDB;Integrated Security=True;TrustServerCertificate=True
```

При использовании полного SQL Server измените `Data\config.json` → `connection_strings.default`.

### 3. Запуск приложений

| Проект | Назначение |
|--------|------------|
| **TransLogistService.Dispatcher** | Диспетчер: CRUD, заказы, SQL-консоль, отчёты |
| **TransLogistService.Driver** | Водитель: биржа грузов, личный кабинет, бронирование |

**Учётные записи водителей** (пароль для всех: `12345`):

| Логин | Водитель |
|-------|----------|
| driver01 | Сидоров И.П. (DR001) |
| driver02 | Петров А.И. |
| driver04 | Алиев Р.М. |

## Функции по ТЗ

### Диспетчер
- Просмотр водителей, транспорта, клиентов
- Создание заявок (`sp_CreateOrder`)
- Назначение водителя (`sp_AssignDriverToOrder`)
- Смена статуса заказа
- SQL-консоль для произвольных запросов
- Отчёты: выполненные заказы, финансы по направлениям

### Водитель
- Биржа грузов (представление `vw_ExchangeOrders`) с фильтрами
- Поиск попутных грузов (`sp_FindMatchingLoads`)
- Кнопка «Взять заказ» (`sp_TakeOrder`)
- Личный кабинет: активные заказы, баланс, завершение рейса
- Срочные заказы подсвечиваются красным

### База данных
- Нормализация до 3НФ: `Drivers`, `Vehicles`, `Orders`, `Clients`, справочники
- CHECK-ограничения на вес, объём, цену, рейтинг
- Индексы по дате и статусу
- Представления: `vw_CompletedOrdersReport`, `vw_DriverActivity`, `vw_ExchangeOrders`, `vw_FinancialSummary`

## Структура ER (кратко)

```
Clients ──< Orders >── Drivers
              │              │
              │              └── Vehicles (BodyTypes)
              └── CargoTypes, OrderStatuses
Orders ──< OrderBookings, TripHistory
```

## Документация для защиты

Для пояснительной записки используйте:
- ER-диаграмму по таблицам из `02_Schema.sql`
- Use Case: акторы **Диспетчер** и **Водитель**
- Скриншоты форм после запуска приложений

## Устранение неполадок

- **Ошибка подключения** — проверьте, что LocalDB запущен: `sqllocaldb info MSSQLLocalDB`
- **sqlcmd не найден** — установите [SQL Server Command Line Utilities](https://learn.microsoft.com/sql/tools/sqlcmd/sqlcmd-utility)
- Смена сервера: отредактируйте `Data/config.json`
