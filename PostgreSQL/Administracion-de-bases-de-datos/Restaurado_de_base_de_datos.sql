select @@VERSION

--Copiamos la base d edatos directamente (esto en donde se encuentre el .yml dentro de una terminal)
docker cp "shared\backup\AdventureWorks2022.bak" sqlserver-2025:/var/opt/mssql/backup/AdventureWorks2022.bak

--Una ve tenemos el bak en el contenedor, podemos empezar a ver de restaurar la base de datos en sql manager
RESTORE DATABASE Northwind
FROM DISK = '/var/opt/mssql/backup/Northwind.bak'
WITH
    MOVE 'Northwind'
    TO '/var/opt/mssql/data/Northwind.mdf',

    MOVE 'Northwind_log'
    TO '/var/opt/mssql/data/Northwind_log.ldf',

    RECOVERY;


--Ahora que ya esta restaurada debemos usarlo
USE Northwind;

SELECT *
FROM Customers;

RESTORE FILELISTONLY
FROM DISK = '/var/opt/mssql/backup/Northwind.bak';

