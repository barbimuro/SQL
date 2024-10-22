INSERT INTO cliente (nombre_cliente, dni_cliente, telefono_cliente, direccion_cliente, email_cliente) VALUES
('Juan Pérez', '12345678', '555-1234', 'Calle Falsa 123', 'juan.perez@example.com'),
('María Gómez', '23456789', '555-2345', 'Avenida Siempre Viva 456', 'maria.gomez@example.com'),
('Luis Fernández', '34567890', '555-3456', 'Calle Luna 789', 'luis.fernandez@example.com'),
('Ana Torres', '45678901', '555-4567', 'Avenida del Sol 101', 'ana.torres@example.com'),
('Pedro Martínez', '56789012', '555-5678', 'Calle Estrella 202', 'pedro.martinez@example.com'),
('Lucía Ramírez', '67890123', '555-6789', 'Calle Río 303', 'lucia.ramirez@example.com'),
('Carlos Díaz', '78901234', '555-7890', 'Calle Mar 404', 'carlos.diaz@example.com'),
('Sofía Castro', '89012345', '555-8901', 'Avenida Tierra 505', 'sofia.castro@example.com'),
('Fernando López', '90123456', '555-9012', 'Calle Viento 606', 'fernando.lopez@example.com'),
('Clara Ruiz', '01234567', '555-0123', 'Calle Nieve 707', 'clara.ruiz@example.com'),
('David Morales', '11234567', '555-1123', 'Avenida Agua 808', 'david.morales@example.com'),
('Teresa Romero', '21234567', '555-2123', 'Calle Fuego 909', 'teresa.romero@example.com'),
('Mario Ortega', '31234567', '555-3123', 'Calle Tierra 010', 'mario.ortega@example.com'),
('Patricia Soto', '41234567', '555-4123', 'Avenida Luz 111', 'patricia.soto@example.com'),
('Javier Mendoza', '51234567', '555-5123', 'Calle Sombra 222', 'javier.mendoza@example.com');

INSERT INTO descuento (descripcion_descuento, porcentaje_descuento, fecha_inicio, fecha_fin) VALUES
('Descuento del 10% en productos de belleza', 10.00, '2024-01-01', '2024-12-31'),
('Descuento del 15% en maquillaje', 15.00, '2024-02-01', '2024-05-31'),
('Descuento del 5% en productos de cuidado del cabello', 5.00, '2024-03-01', '2024-08-31'),
('Descuento del 20% en perfumes', 20.00, '2024-04-01', '2024-11-30'),
('Descuento del 25% en la primera compra', 25.00, '2024-05-01', '2024-06-30');

INSERT INTO proveedor (nombre_proveedor, cuit_proveedor, telefono_proveedor, direccion_proveedor, email_proveedor) VALUES
('Proveedores S.A.', '30-12345678-9', '555-1010', 'Av. Libertador 1234', 'info@proveedores.com'),
('Distribuciones XYZ', '20-23456789-0', '555-2020', 'Calle de la Paz 567', 'contacto@xyz.com'),
('Cosméticos El Sol', '27-34567890-1', '555-3030', 'Calle del Mercado 890', 'ventas@elsol.com'),
('Belleza Natural', '23-45678901-2', '555-4040', 'Avenida de la Belleza 234', 'info@bellezanatural.com'),
('Maquillaje Pro', '29-56789012-3', '555-5050', 'Calle Maquillaje 456', 'info@maquillajepro.com');

INSERT INTO categoria_producto (nombre_categoria, descripcion_categoria) VALUES
('Maquillaje', 'Productos para el maquillaje facial, corporal y de ojos.'),
('Cuidado de la Piel', 'Productos para el cuidado y tratamiento de la piel.'),
('Cuidado del Cabello', 'Productos para el cuidado y tratamiento del cabello.'),
('Perfumería', 'Fragancias y perfumes para uso personal.'),
('Accesorios de Belleza', 'Accesorios y herramientas para el cuidado personal.');

INSERT INTO producto (nombre_producto, precio_producto, descripcion_producto, id_categoria, id_proveedor) VALUES
('Base de Maquillaje', 250.00, 'Base líquida para un acabado natural.', 1, 1),
('Crema Hidratante', 150.00, 'Crema hidratante para todo tipo de piel.', 2, 2),
('Champú Reparador', 200.00, 'Champú para cabellos dañados.', 3, 3),
('Perfume Floral', 500.00, 'Perfume con fragancia floral.', 4, 4),
('Espejo de Maquillaje', 80.00, 'Espejo con luces LED.', 5, 5);

INSERT INTO transaccion (id_cliente, monto_transaccion, estado_transaccion, descuento, codigo_descuento) VALUES
(1, 300.00, 'en preparacion', TRUE, 1),
(2, 450.00, 'enviado', FALSE, NULL),
(3, 150.00, 'recibido', TRUE, 2),
(4, 200.00, 'cancelado', FALSE, NULL),
(5, 350.00, 'en preparacion', TRUE, 3),
(6, 400.00, 'recibido', TRUE, 4),
(7, 250.00, 'enviado', FALSE, NULL),
(8, 600.00, 'cancelado', FALSE, NULL),
(9, 100.00, 'en preparacion', TRUE, 5),
(10, 300.00, 'recibido', FALSE, NULL),
(11, 450.00, 'enviado', TRUE, 1),
(12, 500.00, 'cancelado', FALSE, NULL),
(13, 350.00, 'en preparacion', TRUE, 2),
(14, 400.00, 'recibido', FALSE, NULL),
(15, 600.00, 'enviado', TRUE, 3);

INSERT INTO detalle_transaccion (id_transaccion, id_producto, cantidad_producto, precio_unitario) VALUES
(1, 1, 1, 250.00),
(1, 2, 1, 150.00),
(2, 3, 2, 200.00),
(3, 4, 1, 500.00),
(4, 5, 3, 80.00),
(5, 1, 2, 250.00),
(6, 2, 1, 150.00),
(7, 3, 1, 200.00),
(8, 4, 1, 500.00),
(9, 5, 2, 80.00),
(10, 1, 1, 250.00),
(11, 2, 1, 150.00),
(12, 3, 1, 200.00),
(13, 4, 1, 500.00),
(14, 5, 1, 80.00);

INSERT INTO envio (id_transaccion, fecha_envio, fecha_entrega_estimada, fecha_entrega_real, estado_envio, direccion_envio) VALUES
(1, '2024-10-01', '2024-10-05', '2024-10-04', 'entregado', 'Calle Falsa 123'),
(2, '2024-10-02', '2024-10-06', NULL, 'pendiente', 'Avenida Siempre Viva 456'),
(3, '2024-10-03', '2024-10-07', '2024-10-06', 'entregado', 'Calle Luna 789'),
(4, '2024-10-04', NULL, NULL, 'cancelado', 'Avenida del Sol 101'),
(5, '2024-10-05', '2024-10-09', NULL, 'en tránsito', 'Calle Estrella 202'),
(6, '2024-10-06', '2024-10-10', '2024-10-09', 'entregado', 'Calle Río 303'),
(7, '2024-10-07', '2024-10-11', NULL, 'pendiente', 'Calle Mar 404'),
(8, '2024-10-08', NULL, NULL, 'cancelado', 'Avenida Tierra 505'),
(9, '2024-10-09', '2024-10-13', NULL, 'en tránsito', 'Calle Viento 606'),
(10, '2024-10-10', NULL, NULL, 'pendiente', 'Calle Nieve 707'),
(11, '2024-10-11', '2024-10-15', '2024-10-12', 'entregado', 'Avenida Agua 808'),
(12, '2024-10-12', NULL, NULL, 'cancelado', 'Calle Fuego 909'),
(13, '2024-10-13', '2024-10-17', NULL, 'en tránsito', 'Calle Tierra 010'),
(14, '2024-10-14', NULL, NULL, 'pendiente', 'Avenida Luz 111'),
(15, '2024-10-15', '2024-10-19', '2024-10-18', 'entregado', 'Calle Sombra 222');

INSERT INTO opinion (id_cliente, id_producto, calificacion, comentario) VALUES
(1, 1, 5, 'Excelente base de maquillaje, cubre muy bien.'),
(2, 2, 4, 'Buena crema hidratante, pero el olor podría mejorar.'),
(3, 3, 3, 'Champú aceptable, no noté grandes cambios.'),
(4, 4, 5, 'Fragancia muy fresca y duradera.'),
(5, 5, 4, 'Espejo muy útil, las luces son un gran plus.'),
(1, 3, 5, 'Me encantó este champú, lo recomiendo.'),
(2, 4, 3, 'El perfume es bueno, pero esperaba más duración.'),
(3, 1, 4, 'La base se aplica fácilmente y se ve natural.'),
(4, 2, 5, 'Mejor crema hidratante que he probado.'),
(5, 5, 4, 'Me encanta el tamaño y la luz del espejo.'),
(1, 4, 2, 'No me gustó el perfume, demasiado fuerte.'),
(2, 3, 5, 'Fantástico para cabellos dañados.'),
(3, 2, 3, 'Cumple su función, pero no es nada especial.'),
(4, 1, 4, 'Me gusta mucho el acabado de esta base.'),
(5, 4, 5, 'Simplemente perfecto, mi fragancia favorita.'),
(1, 5, 3, 'Está bien, pero esperaba más calidad por el precio.');

INSERT INTO historial_precios (id_producto, precio_anterior, nuevo_precio) VALUES
(1, 270.00, 250.00),
(2, 160.00, 150.00),
(3, 220.00, 200.00),
(4, 550.00, 500.00),
(5, 90.00, 80.00),
(1, 250.00, 240.00),
(2, 150.00, 145.00),
(3, 200.00, 190.00),
(4, 500.00, 480.00),
(5, 80.00, 75.00),
(1, 240.00, 230.00),
(2, 145.00, 140.00),
(3, 190.00, 185.00),
(4, 480.00, 470.00),
(5, 75.00, 70.00);
