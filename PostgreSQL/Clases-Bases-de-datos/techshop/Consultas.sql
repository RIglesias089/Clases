-- Aseguramos que la pestaña apunte al esquema donde están tus datos
SET search_path TO public;

select count(*) as cantidad from productos p;

--Aca hacemos una consulta para que me diga la cantidad que hay por categoria
SELECT p.id_categorias, COUNT(*) AS cantidad  --selecciona las categorias y cuenta la cantidad de cada una
FROM productos p --viniendo de productos claro
GROUP BY p.id_categorias --ahroa agrupa las categorias 
ORDER BY cantidad asc;--ordena el resultado de la cantidad de forma asc

--hagamos una consulta para saber el numero de cada cliente que a comprado en la tienda 
select count(*) as ventas from ventas v;

select v.id_ventas, count(*) as clientes
from ventas v
group by v.id_ventas 
order by clientes desc;