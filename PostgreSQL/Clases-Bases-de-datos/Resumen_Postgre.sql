--Recordatorio de como funciona postgreSQL

/*Primero qu enada lo que se realiza es la creacion de el docker con el que se
 * trabajara durante el proyecto, el cual es un comando en la terminal:
 * 
 * docker run --name "nombre de el contenedor" -e POSTGRES_PASSWORD="contrasena de el contenedor" -p 5432:5432 -d postgres:latest
 *
 * Con esto tendremos el contenedor de docker creado y listo para conectar en DBeaver
 * Luego de eso podemos empezar hablando de lo que son 
 * 
 * ============================================================================================
 * Creacion de tablas en las bases de datos
 * 
 * Para empezar necesitamso el contenedor logico, donde viviran las tablas, para crear una 
 * tabla se usa el comando
 *  */

--despues de creada la base de datos, podemos crear tablas
CREATE TABLE estudiantes(
    estudiante_id SERIAL PRIMARY KEY, -- Genera un número único automáticamente
    nombre VARCHAR(50) NOT NULL,    -- Estos llevan not null para que sea obligatorio el campo
    apellido VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE,
    es_activo BOOLEAN DEFAULT TRUE, -- ¡Aquí faltaba la coma al final de esta línea!
    
    -- Columna que calcula la edad automáticamente basado en la fecha actual y de nacimiento
    edad INT GENERATED ALWAYS AS (EXTRACT(YEAR FROM CURRENT_DATE) - anio_nacimiento) STORED
);

--Ahora que tenemos una tabla, es importante saber como esta se puede poblar, 
--no sirve denada tener un atabla si no tiene datos, sin datos no podremos hacer consultas

--insertar un solo estudiante
insert into estudiantes (nombre, apellido, fecha_nacimiento, es_activo)
values ('Juan', 'Perez', '2002-05-15', true );

insert into estudiantes (nombre, apellido, fecha_nacimiento, es_activo)
values ('Pedro', 'trujillo', '2007-05-14', false)

--insertados los datos ahora lo que queremos es ver todo lo que hay en al tabla
select * from estudiantes;

--Claramente no solo queremos meter datos si no que tambien vamos a querer
--poder modificar o incluso borrar datos (es importante decir que al borrar hay que tener cuidado)

--Cambiar estado de un estudainte
update estudiantes
set es_activo = false
where nombre = 'Juan';

-- Borrar un estudainte de la base de datos
delete from estudiantes 
where nombre = 'Pedro'

--Ahora con eso hecho, debemos aprender como relacionar tablas (llaves foraneas)
--crearemos otra tabla 
create table carreras(
carrera_id serial primary key,
nombre_carrera varchar(50) not null 
);

--poblamos la tabla 
insert into carreras (nombre_carrera)
values ('ingenieria inrformatica'), ('Medicina'), ('Disenio');

--para empezar debemos alterar la tabla de estudiantes, agregando una columna 
alter table estudiantes add column carrera_id int;

--ahora establecemos la relacion (foreign key) para que apunte a ala tabla de carreras
ALTER TABLE estudiantes 
ADD CONSTRAINT fk_carrera 
FOREIGN KEY (carrera_id) REFERENCES carreras(carrera_id);
--Ahora cuando vamos a el apartado de esquemas podremos ver que estudiantes apunta a carera
--contuinuaremos poblando datos relacionados

--Actualizaremos estudiantes
insert into estudiantes (nombre, apellido, fecha_nacimiento, es_activo, carrera_id)
values ('Maria', 'Lopez', '2001-04-21', true, 2);

insert into estudiantes (nombre, apellido, fecha_nacimiento, es_activo, carrera_id)
values ('Lucia', 'Magdalena', '2004-04-19', false, 3);

--Para estudaintes ya existentes
update estudiantes 
set carrera_id = 1
where nombre='Pedro';

--Si lo que queremos es imprimir datos especificos podemos usar la consulta

select 
	estudiantes.nombre,
	estudiantes.apellido,
	carreras.nombre_carrera
from estudiantes
inner join carreras on estudiantes.carrera_id = carreras.carrera_id

/*Cuando lo que queremos es hacer un backup de la base de datos, podemos hacerlo 
 * desde lo que vendria siendo la terminal, usando los siguientes comandos
 * 
 * docker exec -t "nombre de el contenedor" pg_dump -U postgres(o el usuario) "nombre de la base de datos > "ruta de guardado y nombre de el archivo".sql
 * 
 * 
 * Ahora que pasara si lo que queremos es restaura una base de datos, primero debemos
 * crear la base de datos vacia con 
 * 
 * create database "nombre de la base de datos"
 * 
 * luego haber creado eso vamos a la terminal y ponemos: 
 * 
 * cat C:\Users\TuUsuario\Desktop\respaldo_clase_1.sql | docker exec -i "nombre del contenedor" psql -U "usuario" -d "nombre de la base de datos destino"
 * */

------------------------------------------------------------------------------------------------

--Ahora una vez visto todo esto dominamos parte de DDL y DML, ahora haremos Selecion de datos avanzada y programcion en la base de datos
--Iniciamos con filstrado y ordenado (where, and, or, order by)
--Buscamos un estudiante de la carrera 1 que sea mayor a 15 años de el mas joven al mayor

select  nombre, apellido, edad
from estudiantes
where carrera_id= 1 and edad > 20
order by edad asc;

-- Contar cuántos estudiantes hay registrados por cada número de carrera
SELECT carrera_id, COUNT(*) AS total_estudiantes
FROM estudiantes
GROUP BY carrera_id;

--Programcion con PL/pgSQL
CREATE OR REPLACE FUNCTION obtener_saludo_estudiante(id_buscado INT) 
RETURNS TEXT AS $$
DECLARE
    nombre_encontrado VARCHAR(50);
BEGIN
    -- Buscamos el nombre del estudiante según el parámetro recibido y lo guardamos en una variable
    SELECT nombre INTO nombre_encontrado 
    FROM estudiantes 
    WHERE estudiante_id = id_buscado;
    
    -- Retornamos el texto concatenado
    RETURN 'Hola ' || nombre_encontrado || ', ¡bienvenido a la clase de administración!';
END;
$$ LANGUAGE plpgsql;

-- Para probarla y ejecutarla haces una consulta normal:
SELECT obtener_saludo_estudiante(1);

--If, then, else
CREATE OR REPLACE FUNCTION evaluar_mayor_edad(id_buscado INT) 
RETURNS TEXT AS $$
DECLARE
    edad_estudiante INT;
BEGIN
    SELECT edad INTO edad_estudiante 
    FROM estudiantes 
    WHERE estudiante_id = id_buscado;
    
    -- Lógica condicional
    IF edad_estudiante >= 18 THEN
        RETURN 'El estudiante es mayor de edad';
    ELSE
        RETURN 'El estudiante es menor de edad';
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Ejecución:
SELECT evaluar_mayor_edad(1);

--por ultimo el trigger
/*Un trigger es un script que se activa automáticamente cuando ocurre un evento específico en 
 * una tabla (por ejemplo, justo antes o después de que alguien intente hacer un INSERT, UPDATE o DELETE). 
 * Se usa mucho para auditorías o validaciones automáticas de seguridad.
 * */
