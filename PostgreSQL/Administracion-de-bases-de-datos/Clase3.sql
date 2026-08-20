--Subconsultas 
/*Para poder usar una subconsulta con where, not in, y*/
--Mostrar productos donde le precio unitario es mayor al precio de el catalogo
select ProductName,CategoryName, unitPrice
from Products p join Categories c on p.CategoryID=c.CategoryID
where UnitPrice > (
select avg(unitprice) from Products p1
where p1.CategoryID = p.CategoryID
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
where OrderID is NULL; --Forma de ordenar para poder verificar los que no tienen pareja 

--Si nos ponemos a ver cual es mejor, tenemos que entregar la solicitud ams optima no la mas larga, es cuestion de ver pasos no solo tiempo

--Ahora haremos una consulta en la que tengan almenos un proudcto descontinuado 
select CategoryName
from Categories
where CategoryID in --Si llegamos a usar el operador all, nos sirve para comparar conjuntos, por lo que al ser una lsita nos dara error
(
	select CategoryID from Products where Discontinued = 1
);

--con join busamos ver cuantos son , habra una manera mejor en las correlacionadas
select distinct CategoryName,  count(*) productos_descontinuados
from Categories c join Products p
on c.CategoryID = p.CategoryID
where p.Discontinued = 1
group by CategoryName


--