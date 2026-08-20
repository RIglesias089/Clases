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
create table estudiantes(
estudiante_id serial primary key, --Genera un numero unico automaticamente
nombre varchar(50) not null,	-- estos llevan not null para que sea obligatorio el campo
apellido varchar(50) not null,
fecha_nacimiento date,
es_activo boolean default true --por defecto el estudiante sera activo
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



