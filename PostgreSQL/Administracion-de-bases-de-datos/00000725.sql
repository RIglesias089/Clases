--Restauramos la base de datos
RESTORE DATABASE Northwind_modificado --No recorde la indicacion de el nombre de la base de datos :( por eso puse mi nombre y carnet abajo
FROM DISK = '/var/opt/mssql/backup/Northwind_modificado.bak'
WITH
    MOVE 'Northwind'
    TO '/var/opt/mssql/data/Northwind_modificado.mdf',

    MOVE 'Northwind_log'
    TO '/var/opt/mssql/data/Northwind_modificado.ldf',

    RECOVERY;

--Estudiante: Ricardo Ernesto Iglesias Flores, Carnet: 00000725

--Ejercicio 1:
select OrderID, CustomerID, OrderDate, Freight, case --seleccionamos los campos que evaluaremos 
        when Freight < 30 then 'Bajo' --si freight es menor a 30 se presentara el mensaje de bajo
        when Freight BETWEEN 30 AND 100 then 'Medio' -- si freight esta entre 30 y 100, se presentara el mensaje de medio
        when Freight > 100 then 'Alto' -- Si freight es mayor a 100 este presentara el mensaje de alto 
    end as FreightCategory
from Orders
where CustomerID IS NOT NULL
order by Freight desc, OrderID asc; --En otro caso ordenamos de su amnera respectica

--Ejercicio 2:
select s.CompanyName, p.ProductID, p.ProductName, p.UnitPrice,
    row_number() over (
        partition by s.SupplierID
        order by p.UnitPrice desc, p.ProductID asc
    ) as Position
from Products p
inner join Suppliers s
    on p.SupplierID = s.SupplierID
order by s.CompanyName asc, Position asc;

--Ejercicio 3:
with EmployeeSales as (
    select e.EmployeeID, e.FirstName + ' ' + e.LastName as EmployeeName,
        sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) as TotalSales
    from Employees e
    inner join Orders o
        on e.EmployeeID = o.EmployeeID
    inner join [Order Details] od
        on o.OrderID = od.OrderID
    group by e.EmployeeID, e.FirstName, e.LastName
)
select EmployeeID, EmployeeName,
    cast(TotalSales as decimal(10,2)) as TotalSales
from EmployeeSales
where TotalSales > (select avg(TotalSales) from EmployeeSales)
order by TotalSales desc;

--Ejercicio 4:
select Country, [1996], [1997], [1998]
from (
    select c.Country, year(o.OrderDate) as OrderYear,
           od.UnitPrice * od.Quantity * (1 - od.Discount) as TotalSale
    from Orders o
    inner join Customers c on o.CustomerID = c.CustomerID
    inner join [Order Details] od on o.OrderID = od.OrderID
    where year(o.OrderDate) in (1996, 1997, 1998)
) as Sales
pivot (sum(TotalSale) for OrderYear in ([1996], [1997], [1998])
) as PivotTable
order by Country asc;

--Ejercicio 5:
select EmployeeID, OrderID, OrderDate,
    lag(OrderDate) over (
        partition by EmployeeID
        order by OrderDate, OrderID
    ) as PreviousOrderDate,
    datediff( day, lag(OrderDate) over (
            partition by EmployeeID
            order by OrderDate, OrderID), OrderDate ) as daysSincePreviousOrder
from Orders
order by EmployeeID, OrderDate, OrderID;