
-- Usar control + enter para ejecutar las querys en Workbench

-- Crear base de datos

create database nombre_base_de_datos;

-- Muestrame las bases de datos

show databases;

-- Selecciono la base de datos para crear una tabla

use nombre_base_de_datos;

-- Crear una tabla con id auto incremental y un par de campos más

CREATE TABLE  animales (
    id int auto_increment NOT NULL, -- 
    tipo varchar(255) NOT NULL, --String(numjero de caracteres)
    estado varchar(255) NOT NULL,
    PRIMARY KEY (id) 
);

-- Insertar datos

INSERT INTO animales (tipo, estado) VALUES ('chanchito', 'feliz');
INSERT INTO animales (tipo, estado) VALUES ('dragon', 'feliz');
INSERT INTO animales (tipo, estado) VALUES ('felipe', 'triste');

-- Si no hubiera hecho la id autoincrementada podría hacerlo de esta forma

ALTER TABLE animales MODIFY COLUMN id int auto_increment;

-- Para ver el comando ejecutado uso show

SHOW CREATE TABLE animales;

-- Seleccionar elementos de una tabla

SELECT * FROM animales;

-- Seleccionar específicamente

SELECT * FROM animales WHERE id = 1;
SELECT * FROM animales WHERE estado = 'feliz';
SELECT * FROM animales WHERE estado = 'feliz' AND tipo = 'chanchito'; -- devuelve a chanchito feliz
SELECT * FROM animales WHERE estado = 'feliz' OR tipo = 'dragon'; -- devuelve a chanchito y a dragón

-- Actualizar un campo. Necesito pasarle el id para que no de error

UPDATE animales SET estado = 'feliz' WHERE id = 3;

-- Para borrar. También necesito pasarle el id para que no de error. Esto se puede cambiar en la config pero no es recomendable

DELETE FROM animales WHERE id = 3;

-- Creo una tabla de usuarios

CREATE TABLE usuarios(
    id int NOT NULL auto_increment,
    name varchar(50) NOT NULL,
    edad int NOT NULL,
    email varchar(100) NOT NULL,
    PRIMARY KEY (id)
);

-- Inserto valores

INSERT INTO usuarios (name, edad, email) values ('Oscar', 25, 'oscar@gmail.com');
INSERT INTO usuarios (name, edad, email) values ('Layla', 15, 'layla@gmail.com');
INSERT INTO usuarios (name, edad, email) values ('Nicolás', 36, 'nicolas@gmail.com');
INSERT INTO usuarios (name, edad, email) values ('Chanchito', 7, 'chanchito@gmail.com');

-- CONSULTAS

SELECT * FROM usuarios;

SELECT * FROM usuarios limit 1;

SELECT * FROM usuarios where edad > 15;

SELECT * FROM usuarios where edad >= 15;

SELECT * FROM usuarios where edad >20 AND email = 'nicolas@gmail.com';

SELECT * FROM usuarios where edad > 20 OR email = 'layla@gmail.com'; -- Devuelve layla, oscar y nicolas

SELECT * FROM usuarios where email != 'layla@gmail.com';  -- Menos layla

SELECT * FROM usuarios where edad between 15 and 30;

SELECT * FROM usuarios WHERE email like '%gmail%'; -- Selecciona todos los registros que contengan el texto gmail en el email. El % es como un *

-- Se puede usar el % con el like para que de igual el texto que haya donde está el %

SELECT * FROM usuarios order by edad asc; -- Ordenar por edad en orden ascendente
SELECT * FROM usuarios order by edad desc; -- Ordenar por edad en orden descendente

SELECT max(edad) as mayor FROM usuarios; -- El máximo de edad en usuarios. Nombro el campo "mayor"
SELECT min(edad) as menor FROM usuarios; -- El minimo de edad en usuarios. Nombro el campo "menor"

-- Seleccionar columnas en específico

SELECT id, name FROM usuarios;

-- Para cambiar el nombre de la columna que se está mostrando

SELECT id, name as nombre FROM usuarios;

-- JOIN

-- Creo una nueva tabla para hacer un JOIN a través de las llaves foráneas
-- Tabla de productos

CREATE TABLE products(
    id int NOT NULL auto_increment,
    name varchar(50) NOT NULL,
    created_by int NOT NULL,
    marca varchar(50) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (created_by) references usuarios(id)
);

-- Si quiero la tabla en singular puedo cambiarle el nombre

RENAME TABLE products TO product;

-- Inserto valores en la tabla, puedo hacerlo todo con un INSERT

INSERT INTO products (name, created_by, marca)
values
    ('ipad', 1, 'apple'),
    ('iphone', 1, 'apple'),
    ('watch', 2, 'apple'),
    ('macbook', 1, 'apple'),
    ('imac', 3, 'apple'),
    ('ipadmini', 2, 'apple');

-- LEFT JOIN user-products: aparecerántodos los usuarios y los encuentre asociados a los productos registrados. 
-- Devolverá todos los usuarios y si algún usuario no coincide devolverá el usuario y un NULL
-- u es el alias de usuario
-- p es el alias de producto
-- uso on para hacer el join

SELECT u.id, u.email FROM usuarios u; -- esto ya funciona
SELECT u.id, u.email, p.name FROM usuarios u left join  products p; -- ahora falta unir los campos que interesa unir que es el id con created_by
SELECT u.id, u.email, p.name FROM usuarios u left join  products p on u.id = p.created_by;

-- En este caso nicolas devuelve un NULL en name

-- RIGHT JOIN es lo mismo pero la que manda es la tabla derecha ( products )
-- Si hago un RIGHT JOIN lo que cambia es el resultado, en este caso todos los productos están asociados a un email menos a nicolás

SELECT u.id, u.email, p.name FROM usuarios u right join  products p on u.id = p.created_by;

-- INNER JOIN
--  Devuelve solo los usuarios y productos siempre y cuando tengan una asociación

SELECT u.id, u.email, p.name FROM usuarios u inner join  products p on u.id = p.created_by;







