--Subconsultas 
/*Para poder usar una subconsulta con where, not in, y*/


select ProductName, unitPrice
from Products
where UnitPrice > (
select avg(unitprice) from Products
);


--clientes, los cuales nunca han realizado un pedido 
select CompanyName, country
from customers
where CustomerID not in 
(
	select CustomerID from Orders
);

--resolvido con left join
select CompanyName, country
from Customers c left join Orders o 
on c.CustomerID = o.CustomerID
where OrderID is NULL; --Forma de ordenar para que se vean priemro los null

--Si nos ponemos a ver cual es mejor, 