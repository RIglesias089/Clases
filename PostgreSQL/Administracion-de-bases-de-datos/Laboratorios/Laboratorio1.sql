--Restauracion de la base de datos 
RESTORE DATABASE AdventureWorks2022
FROM DISK = '/var/opt/mssql/backup/AdventureWorks2022.bak'
WITH 
    MOVE 'AdventureWorks2022' 
    TO '/var/opt/mssql/data/AdventureWorks2022.mdf',

    MOVE 'AdventureWorks2022_Log' 
    TO '/var/opt/mssql/data/AdventureWorks2022_log.ldf',

    REPLACE,
    RECOVERY;

use AdventureWorks2022


--Ejercicio 1
select
    BusinessEntityID,
    Name,
    CreditRating,
    ActiveFlag,
    avg(cast(CreditRating as decimal(9,6))) over (partition by ActiveFlag) as PromedioCreditRatingPorEstado
from Purchasing.Vendor
order by ActiveFlag, BusinessEntityID;

--Ejercicio 2
select 
    CustomerID, 
    PersonID, 
    StoreID, 
    count(*) over () as TotalClientesRegistrados 
from Sales.Customer 
order by CustomerID;

--Ejercicio 3
select
    p.ProductID,
    p.Name,
    p.ProductSubcategoryID,
    p.ListPrice
from Production.Product as p
where
    p.ProductSubcategoryID IS NOT NULL
    AND p.ListPrice > (
        select avg(p2.ListPrice)
        from Production.Product as p2
        where p2.ProductSubcategoryID = p.ProductSubcategoryID
    )
order by p.ProductSubcategoryID, p.ProductID;

--ejercicio 4
select 
    CustomerID, 
    SalesOrderID, 
    OrderDate, 
    lag(OrderDate) over (partition by CustomerID order by OrderDate) as PreviousOrderDate, 
    datediff(day, lag(OrderDate) over (partition by CustomerID order by OrderDate), OrderDate) as DaysSinceLastOrder 
from Sales.SalesOrderHeader 
order by  
    CustomerID, 
    OrderDate;

--ejercicio 5
select
    CustomerID, 
    SalesOrderID, 
    OrderDate as CurrentOrderDate, 
    lead(OrderDate) over (partition by CustomerID order by OrderDate) as NextOrderDate 
from Sales.SalesOrderHeader 
order by 
    CustomerID, 
    OrderDate;