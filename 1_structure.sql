DROP DATABASE IF EXISTS styles_by_bm;
CREATE DATABASE styles_by_bm;
USE styles_by_bm;

CREATE TABLE cliente (
id_cliente INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre_cliente VARCHAR(60),
dni_cliente VARCHAR(12),
telefono_cliente VARCHAR(15),
direccion_cliente VARCHAR(100),
email_cliente VARCHAR(80)
) COMMENT 'Datos del cliente';

CREATE TABLE descuento (
 id_descuento INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 descripcion_descuento VARCHAR(255),
 porcentaje_descuento DECIMAL(5,2) CHECK (porcentaje_descuento > 0 AND porcentaje_descuento <= 100),
 fecha_inicio DATE,
 fecha_fin DATE
) COMMENT 'Descuento disponible';

CREATE TABLE proveedor (
id_proveedor INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre_proveedor VARCHAR(60),
cuit_proveedor VARCHAR(12),
telefono_proveedor VARCHAR(15),
direccion_proveedor VARCHAR(100),
email_proveedor VARCHAR(80)
) COMMENT 'Datos del proveedor';

CREATE TABLE categoria_producto (
id_categoria INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre_categoria VARCHAR(60),
descripcion_categoria VARCHAR(300)
) COMMENT 'Descripcion categorias de productos';

CREATE TABLE producto (
id_producto INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre_producto VARCHAR(60),
precio_producto DECIMAL(8,2),
descripcion_producto VARCHAR(300),
id_categoria INT UNSIGNED, -- fk
id_proveedor INT UNSIGNED -- fk
) COMMENT 'Datos del producto';

CREATE TABLE transaccion (
id_transaccion INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
id_cliente INT UNSIGNED, -- fk
fecha_transaccion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
monto_transaccion DECIMAL(8,2),
estado_transaccion ENUM('en preparacion', 'enviado', 'recibido', 'cancelado'),
descuento BOOLEAN DEFAULT FALSE,
codigo_descuento INT UNSIGNED 
) COMMENT 'Datos de la transaccion';

CREATE TABLE detalle_transaccion (
id_detalle_transaccion INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
id_transaccion INT UNSIGNED, -- fk
id_producto INT UNSIGNED, -- fk
cantidad_producto INT UNSIGNED,
precio_unitario DECIMAL(8,2)
) COMMENT 'Detalle de la transaccion';

CREATE TABLE envio (
    id_envio INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_transaccion INT UNSIGNED, -- fk
    fecha_envio DATE,
    fecha_entrega_estimada DATE,
    fecha_entrega_real DATE,
    estado_envio ENUM('pendiente', 'en tránsito', 'entregado', 'devuelto', 'cancelado'),
    direccion_envio VARCHAR(100),
    FOREIGN KEY (id_transaccion) REFERENCES Transaccion(id_transaccion)
) COMMENT 'Actualización del envio';

CREATE TABLE opinion (
    id_opinion INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT UNSIGNED, -- fk
    id_producto INT UNSIGNED, -- fk
    calificacion TINYINT UNSIGNED CHECK (calificacion BETWEEN 1 AND 5), 
    comentario VARCHAR(500),
    fecha_opinion DATE DEFAULT(CURRENT_DATE)
) COMMENT 'Valoración del producto';

CREATE TABLE historial_precios (
    id_historial INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_producto INT UNSIGNED, -- fk
    precio_anterior DECIMAL(8,2),
    fecha_cambio DATE DEFAULT(CURRENT_DATE),
    nuevo_precio DECIMAL(8,2)
)COMMENT 'Historial de precios';



ALTER TABLE   styles_by_bm.producto   ADD
FOREIGN KEY  (id_categoria)  REFERENCES styles_by_bm.categoria_producto(id_categoria);

ALTER TABLE   styles_by_bm.producto   ADD
FOREIGN KEY  (id_proveedor)  REFERENCES styles_by_bm.proveedor(id_proveedor);

ALTER TABLE styles_by_bm.transaccion  ADD
FOREIGN KEY  (id_cliente)  REFERENCES styles_by_bm.cliente(id_cliente);

ALTER TABLE   styles_by_bm.detalle_transaccion   ADD
FOREIGN KEY   (id_transaccion) REFERENCES styles_by_bm.transaccion(id_transaccion) ;

ALTER TABLE  styles_by_bm.detalle_transaccion     ADD
FOREIGN KEY   (id_producto)  REFERENCES styles_by_bm.producto(id_producto) ;

ALTER TABLE styles_by_bm.opinion ADD
FOREIGN KEY (id_cliente) REFERENCES styles_by_bm.cliente(id_cliente);

ALTER TABLE styles_by_bm.opinion ADD
FOREIGN KEY (id_producto) REFERENCES styles_by_bm.producto(id_producto);

ALTER TABLE styles_by_bm.historial_precios ADD
FOREIGN KEY (id_producto) REFERENCES styles_by_bm.producto(id_producto);

ALTER TABLE styles_by_bm.envio ADD 
FOREIGN KEY (id_transaccion) REFERENCES styles_by_bm.transaccion(id_transaccion);

ALTER TABLE styles_by_bm.transaccion ADD
FOREIGN KEY (codigo_descuento) REFERENCES styles_by_bm.descuento(id_descuento)

ALTER TABLE producto
ADD COLUMN stock INT UNSIGNED DEFAULT 0 AFTER descripcion_producto;


--ROLES:

--ADMIN
CREATE USER 'admin_bm'@'localhost' IDENTIFIED BY 'admin_password';
GRANT ALL PRIVILEGES ON styles_by_bm.* TO 'admin_bm'@'localhost';

--GERENTE
CREATE USER 'gerente_bm'@'localhost' IDENTIFIED BY 'gerente_password';
GRANT SELECT, INSERT, UPDATE, DELETE ON styles_by_bm.transaccion TO 'gerente_bm'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON styles_by_bm.producto TO 'gerente_bm'@'localhost';
GRANT SELECT, INSERT, UPDATE ON styles_by_bm.cliente TO 'gerente_bm'@'localhost';
GRANT SELECT ON styles_by_bm.opinion TO 'gerente_bm'@'localhost';

--PROVEEDOR
CREATE USER 'proveedor_bm'@'localhost' IDENTIFIED BY 'proveedor_password';
GRANT SELECT, INSERT, UPDATE ON styles_by_bm.producto TO 'proveedor_bm'@'localhost';
GRANT SELECT ON styles_by_bm.transaccion TO 'proveedor_bm'@'localhost';

--SOPORTE
CREATE USER 'soporte_bm'@'localhost' IDENTIFIED BY 'soporte_password';
GRANT SELECT, UPDATE ON styles_by_bm.envio TO 'soporte_bm'@'localhost';
GRANT SELECT ON styles_by_bm.transaccion TO 'soporte_bm'@'localhost';
GRANT SELECT ON styles_by_bm.cliente TO 'soporte_bm'@'localhost';

