-- VIEWS:
CREATE VIEW vista_productos_mas_vendidos AS
SELECT p.nombre_producto, SUM(dt.cantidad_producto) AS cantidad_vendida, SUM(dt.precio_unitario * dt.cantidad_producto) AS ingreso_total
FROM producto AS p
JOIN detalle_transaccion AS dt ON p.id_producto = dt.id_producto
GROUP BY p.id_producto
ORDER BY cantidad_vendida DESC;

CREATE VIEW vista_envios_cancelados AS 
SELECT t.id_transaccion, c.nombre_cliente,c.telefono_cliente, t.monto_transaccion, t.fecha_transaccion
FROM transaccion AS t
JOIN cliente AS c ON t.id_cliente = c.id_cliente
WHERE t.estado_transaccion ='cancelado';

CREATE VIEW vista_opiniones_productos AS
SELECT p.nombre_producto, o.calificacion, o.comentario, c.nombre_cliente
FROM opinion AS  o
JOIN producto AS p ON o.id_producto = p.id_producto
JOIN cliente AS c ON o.id_cliente = c.id_cliente
ORDER BY p.nombre_producto, o.calificacion DESC;

CREATE VIEW vista_historial_precios AS
SELECT p.nombre_producto, hp.precio_anterior, hp.nuevo_precio
FROM producto AS p
JOIN historial_precios AS hp ON p.id_producto = hp.id_producto
ORDER BY p.nombre_producto, hp.nuevo_precio DESC;

CREATE VIEW vista_clientes_ultimas_compras AS
SELECT c.id_cliente, c.nombre_cliente, t.fecha_transaccion, t.monto_transaccion, t.estado_transaccion
FROM cliente AS c
JOIN transaccion AS t ON c.id_cliente = t.id_cliente
WHERE t.fecha_transaccion = (
    SELECT MAX(t2.fecha_transaccion)
    FROM transaccion AS t2
    WHERE t2.id_cliente = c.id_cliente
);


-- FUNCTIONS:
DROP FUNCTION IF EXISTS fn_total_transacciones;
DROP FUNCTION IF EXISTS fn_dias_desde_ultima_transaccion;
DELIMITER //
CREATE FUNCTION fn_total_transacciones(cid INT)
RETURNS INT
COMMENT 'Cantidad de transacciones por cliente'
DETERMINISTIC
READS SQL DATA
	BEGIN 
		DECLARE existe BOOL;
        DECLARE total_transacciones INT;
        SET existe =(SELECT 
						IF(
							COUNT(id_cliente)=0, FALSE, TRUE)
                            FROM styles_by_bm.cliente
                            WHERE id_cliente = cid);
		IF existe THEN 
			SELECT COUNT(t.id_transaccion) INTO total_transacciones
            FROM transaccion AS t
			WHERE t.id_cliente = cid;
            RETURN total_transacciones;
				ELSE
					SIGNAL SQLSTATE '45000' 
					SET MESSAGE_TEXT = 'No existe el cliente', MYSQL_ERRNO = 1000;
		    END IF;
           
            
	END //
CREATE FUNCTION fn_dias_desde_ultima_transaccion(cid INT)
RETURNS INT
COMMENT 'Cantidad de días desde la última transacción del cliente'
DETERMINISTIC
READS SQL DATA
BEGIN 
    DECLARE dias INT;
    SELECT DATEDIFF(NOW(), MAX(t.fecha_transaccion)) INTO dias
    FROM transaccion t
    WHERE t.id_cliente = cid;
    IF dias IS NULL THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'No existe el cliente o no tiene transacciones', MYSQL_ERRNO = 1000;
    END IF;
    RETURN dias;
END //
DELIMITER ;
-- PROCEEDURES:
DROP PROCEDURE IF EXISTS reportar_info_cliente;
DROP PROCEDURE IF EXISTS chequeo_transaccion_envio;
DELIMITER //
CREATE PROCEDURE reportar_info_cliente(
    IN cid INT
)
BEGIN
    SELECT 
		c.nombre_cliente,
        fn_total_transacciones(c.id_cliente),
        fn_dias_desde_ultima_transaccion(c.id_cliente)
        FROM cliente AS c
        WHERE cid = c.id_cliente;
END //
CREATE PROCEDURE chequeo_transaccion_envio(
    IN cid INT
)
BEGIN
	SELECT c.nombre_cliente,
    t.estado_transaccion,
	fn_dias_desde_ultima_transaccion(c.id_cliente)
    FROM cliente AS c
    JOIN transaccion AS t
		USING(id_cliente)
    WHERE cid = c.id_cliente;
END //
DELIMITER ;
-- TRIGGERS:
DELIMITER //
DROP TRIGGER IF EXISTS evitar_monto_cero;
DROP TRIGGER IF EXISTS actualizar_stock_producto;

CREATE TRIGGER evitar_monto_cero
BEFORE INSERT ON transaccion
FOR EACH ROW
BEGIN
    IF NEW.monto_transaccion <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El monto de la transacción debe ser mayor que cero.';
    END IF;
END //
DELIMITER //
CREATE TRIGGER actualizar_stock_producto
AFTER INSERT ON detalle_transaccion
FOR EACH ROW
BEGIN
    UPDATE producto
    SET stock = stock - NEW.cantidad_producto
    WHERE id_producto = NEW.id_producto;
END //
DELIMITER ;
