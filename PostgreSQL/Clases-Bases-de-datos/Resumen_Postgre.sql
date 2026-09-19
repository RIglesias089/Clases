--Recordatorio de como funciona postgreSQL

/*Primero que nada lo que se realiza es la creacion de el docker con el que se
    trabajara durante el proyecto, el cual es un comando en la terminal:
    docker run --name "nombre de el contenedor" -e POSTGRES_PASSWORD="contrasena de el contenedor" -p 5432:5432 -d postgres:latest
    Con esto tendremos el contenedor de docker creado y listo para conectar en DBeaver
    Luego de eso podemos empezar hablando de lo que son
    ============================================================================================
    Creacion de tablas en las bases de datos
    Para empezar necesitamos el contenedor logico, donde viviran las tablas, para crear una
    tabla se usa el comando
    */

--despues de creada la base de datos, podemos crear tablas con restricciones avanzadas (UNIQUE, CHECK)
CREATE TABLE estudiantes(
estudiante_id SERIAL PRIMARY KEY, -- Genera un numero unico automaticamente
nombre VARCHAR(50) NOT NULL,    -- Estos llevan not null para que sea obligatorio el campo
apellido VARCHAR(50) NOT NULL,
email VARCHAR(100) UNIQUE,      -- Restriccion unique para que no se repita el correo
edad_real INT CHECK (edad_real >= 0), -- Restriccion check para asegurar edad valida
fecha_nacimiento DATE,
es_activo BOOLEAN DEFAULT TRUE,

-- Columna que calcula la edad automaticamente basado en la fecha actual y de nacimiento
edad INT GENERATED ALWAYS AS (EXTRACT(YEAR FROM CURRENT_DATE) - anio_nacimiento) STORED

);

--Ahora que tenemos una tabla, es importante saber como esta se puede poblar,
--no sirve de nada tener una tabla si no tiene datos, sin datos no podremos hacer consultas

--insertar un solo estudiante
insert into estudiantes (nombre, apellido, email, fecha_nacimiento, es_activo)
values ('Juan', 'Perez', 'juan.perez@email.com', '2002-05-15', true );

insert into estudiantes (nombre, apellido, email, fecha_nacimiento, es_activo)
values ('Pedro', 'trujillo', 'pedro.trujillo@email.com', '2007-05-14', false);

--insertados los datos ahora lo que queremos es ver todo lo que hay en la tabla
select * from estudiantes;

--Claramente no solo queremos meter datos si no que tambien vamos a querer
--poder modificar o incluso borrar datos (es importante decir que al borrar hay que tener cuidado)

--Cambiar estado de un estudiante
update estudiantes
set es_activo = false
where nombre = 'Juan';

-- Borrar un estudiante de la base de datos
delete from estudiantes
where nombre = 'Pedro';

--Ahora con ese hecho, debemos aprender como relacionar tablas (llaves foraneas)
--crearemos otra tabla
create table carreras(
carrera_id serial primary key,
nombre_carrera varchar(50) not null
);

--poblamos la tabla
insert into carreras (nombre_carrera)
values ('ingenieria informatica'), ('Medicina'), ('Disenio');

--para empezar debemos alterar la tabla de estudiantes, agregando una columna
alter table estudiantes add column carrera_id int;

--ahora establecemos la relacion (foreign key) para que apunte a la tabla de carreras
ALTER TABLE estudiantes
ADD CONSTRAINT fk_carrera
FOREIGN KEY (carrera_id) REFERENCES carreras(carrera_id);
--Ahora cuando vamos a el apartado de esquemas podremos ver que estudiantes apunta a carrera
--continuaremos poblando datos relacionados

--Actualizaremos estudiantes
insert into estudiantes (nombre, apellido, email, fecha_nacimiento, es_activo, carrera_id)
values ('Maria', 'Lopez', 'maria.lopez@email.com', '2001-04-21', true, 2);

insert into estudiantes (nombre, apellido, email, fecha_nacimiento, es_activo, carrera_id)
values ('Lucia', 'Magdalena', 'lucia.magdalena@email.com', '2004-04-19', false, 3);

--Para estudiantes ya existentes
update estudiantes
set carrera_id = 1
where nombre='Pedro';

select * from estudiantes;

--Si lo que queremos es imprimir datos especificos usando JOINS avanzados (INNER, LEFT, RIGHT, FULL)
--Ejemplo con INNER JOIN
select
estudiantes.nombre,
estudiantes.apellido,
carreras.nombre_carrera
from estudiantes
inner join carreras on estudiantes.carrera_id = carreras.carrera_id;

--Ejemplo con LEFT JOIN (trae todos los estudiantes, tengan o no carrera asignada)
select
estudiantes.nombre,
carreras.nombre_carrera
from estudiantes
left join carreras on estudiantes.carrera_id = carreras.carrera_id;

/*Cuando lo que queremos es hacer un backup de la base de datos, podemos hacerlo
    desde lo que vendria siendo la terminal, usando los siguientes comandos
    docker exec -t "nombre de el contenedor" pg_dump -U postgres(o el usuario) "nombre de la base de datos" > "ruta de guardado y nombre de el archivo".sql
    Ahora que pasara si lo que queremos es restaurar una base de datos, primero debemos
    crear la base de datos vacia con
    create database "nombre de la base de datos"
    luego haber creado eso vamos a la terminal y ponemos:
    cat C:\Users\TuUsuario\Desktop\respaldo_clase_1.sql | docker exec -i "nombre del contenedor" psql -U "usuario" -d "nombre de la base de datos destino"
    */
--Seleccion de datos avanzada, funciones de agregacion, HAVING y Subconsultas
--Iniciamos con filtrado y ordenado (where, and, or, order by)
--Buscamos un estudiante de la carrera 1 que sea mayor a 20 anos del mas joven al mayor

select nombre, apellido, edad
from estudiantes
where carrera_id = 1 and edad > 20
order by edad asc;

-- Contar cuantos estudiantes hay registrados por cada numero de carrera usando HAVING
SELECT carrera_id, COUNT() AS total_estudiantes
FROM estudiantes
GROUP BY carrera_id
HAVING COUNT() >= 1;

-- Subconsulta de ejemplo: Estudiantes cuya edad es mayor al promedio general
select nombre, apellido, edad
from estudiantes
where edad > (select AVG(edad) from estudiantes);

-- Vistas (Views): Crear una tabla virtual con una consulta compleja
create view vista_estudiantes_activos as
select nombre, apellido, email
from estudiantes
where es_activo = true;

-- Uso de la vista creada
select * from vista_estudiantes_activos;

-- Indices para mejorar el rendimiento de busqueda
create index idx_estudiantes_apellido on estudiantes(apellido);

-- Transacciones (BEGIN, COMMIT, ROLLBACK) para seguridad en operaciones criticas
BEGIN;
update estudiantes set es_activo = true where estudiante_id = 1;
-- Si todo sale bien confirmamos con COMMIT, si algo falla usamos ROLLBACK
COMMIT;

--Programacion con PL/pgSQL
CREATE OR REPLACE FUNCTION obtener_saludo_estudiante(id_buscado INT)
RETURNS TEXT AS $$ DECLARE     nombre_encontrado VARCHAR(50); BEGIN     -- Buscamos el nombre del estudiante segun el parametro recibido y lo guardamos en una variable     SELECT nombre INTO nombre_encontrado      FROM estudiantes      WHERE estudiante_id = id_buscado;          -- Retornamos el texto concatenado     RETURN 'Hola ' \vert{}\vert{} nombre_encontrado \vert{}\vert{} ', bienvenido a la clase de administracion!'; END; $$ LANGUAGE plpgsql;

-- Para probarla y ejecutarla haces una consulta normal:
SELECT obtener_saludo_estudiante(1);

--If, then, else
CREATE OR REPLACE FUNCTION evaluar_mayor_edad(id_buscado INT)
RETURNS TEXT AS $$ DECLARE     edad_estudiante INT; BEGIN     SELECT edad INTO edad_estudiante      FROM estudiantes      WHERE estudiante_id = id_buscado;          -- Logica condicional     IF edad_estudiante >= 18 THEN         RETURN 'El estudiante es mayor de edad';     ELSE         RETURN 'El estudiante es menor de edad';     END IF; END; $$ LANGUAGE plpgsql;

-- Ejecucion:
SELECT evaluar_mayor_edad(1);

--Implementacion real de un Trigger (Disparador) y su funcion asociada
--Primero creamos una tabla de auditoria para registrar cambios
CREATE TABLE auditoria_estudiantes (
auditoria_id SERIAL PRIMARY KEY,
accion VARCHAR(50),
fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--Segundo creamos la funcion que ejecutara el trigger
CREATE OR REPLACE FUNCTION registrar_auditoria_estudiante()
RETURNS TRIGGER AS $$ BEGIN     INSERT INTO auditoria_estudiantes (accion)      VALUES ('Se inserto un nuevo estudiante en la tabla');     RETURN NEW; END; $$ LANGUAGE plpgsql;

--Tercero creamos el trigger que se activa despues de insertar un registro
CREATE TRIGGER trg_auditoria_estudiantes
AFTER INSERT ON estudiantes
FOR EACH ROW
EXECUTE FUNCTION registrar_auditoria_estudiante();