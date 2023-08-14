/* Poner en uso base de datos master */
USE master;

/* Si la base de datos ya existe la eliminamos */
DROP DATABASE IF EXISTS db_SalesClothes;

/* Crear base de datos Sales Clothes */
CREATE DATABASE db_SalesClothes;

/* Poner en uso la base de datos */
USE db_SalesClothes;

/* Crear tabla client */
CREATE TABLE client
(
    id INT PRIMARY KEY,
    type_document CHAR(3),
    number_document CHAR(15),
    names VARCHAR(60),
    last_name VARCHAR(90),
    email VARCHAR(80),
    cell_phone CHAR(9),
    birthdate DATE,
    active BIT
);

/* Ver estructura de tabla client */
EXEC sp_columns @table_name = 'client';

/* Listar tablas de la base de datos db_SalesClothes */
SELECT * FROM INFORMATION_SCHEMA.TABLES;

/* Crear Tablas */

-- Table: clothes
CREATE TABLE clothes (
    id INT PRIMARY KEY,
    description VARCHAR(60),
    brand VARCHAR(60),
    amount INT,
    size VARCHAR(10),
    price DECIMAL(8,2),
    active BIT
);

-- Table: sale
CREATE TABLE sale (
    id INT PRIMARY KEY,
    date_time DATETIME,
    client_id INT,
    seller_id INT,
    active BIT
);

-- Table: sale_detail
CREATE TABLE sale_detail (
    id INT PRIMARY KEY,
    sale_id INT,
    clothes_id INT,
    amount INT
);

-- Table: seller
CREATE TABLE seller (
    id INT PRIMARY KEY,
    type_document CHAR(3),
    number_document VARCHAR(15),
    names VARCHAR(60),
    last_name VARCHAR(90),
    salary DECIMAL(8,2),
    cell_phone CHAR(9),
    email VARCHAR(80),
    active BIT
);

/* Relaciones */

-- foreign keys
-- Reference: sale_client (table: sale)
ALTER TABLE sale ADD CONSTRAINT sale_client
    FOREIGN KEY (client_id)
    REFERENCES client (id);

-- Reference: sale_detail_clothes (table: sale_detail)
ALTER TABLE sale_detail ADD CONSTRAINT sale_detail_clothes
    FOREIGN KEY (clothes_id)
    REFERENCES clothes (id);

-- Reference: sale_detail_sale (table: sale_detail)
ALTER TABLE sale_detail ADD CONSTRAINT sale_detail_sale
    FOREIGN KEY (sale_id)
    REFERENCES sale (id);

-- Reference: sale_seller (table: sale)
ALTER TABLE sale ADD CONSTRAINT sale_seller
    FOREIGN KEY (seller_id)
    REFERENCES seller (id);

/* Ver relaciones creadas entre las tablas de la base de datos */
SELECT 
    fk.name [Constraint],
    OBJECT_NAME(fk.parent_object_id) [Tabla],
    COL_NAME(fc.parent_object_id, fc.parent_column_id) [Columna FK],
    OBJECT_NAME(fk.referenced_object_id) AS [Tabla base],
    COL_NAME(fc.referenced_object_id, fc.referenced_column_id) AS [Columna PK]
FROM 
    sys.foreign_keys fk
    INNER JOIN sys.foreign_key_columns fc ON (fk.OBJECT_ID = fc.constraint_object_id);

/* Eliminar base de datos */
USE master;
DROP DATABASE db_SalesClothes;
