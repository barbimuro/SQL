-- INFORMES
SELECT 
    t.id_transaccion,
    c.nombre_cliente,
    t.monto_transaccion AS monto_original,
    IF(t.descuento = TRUE, d.porcentaje_descuento, 0) AS porcentaje_descuento,
    ROUND(t.monto_transaccion - (t.monto_transaccion * d.porcentaje_descuento / 100), 2) AS monto_final,
    ROUND(t.monto_transaccion * d.porcentaje_descuento / 100, 2) AS monto_ahorrado
FROM transaccion AS t
JOIN cliente AS c ON t.id_cliente = c.id_cliente
LEFT JOIN descuento d ON t.codigo_descuento = d.id_descuento
WHERE t.descuento = TRUE;


SELECT 
    p.nombre_producto,
    vp.cantidad_vendida,
    vp.ingreso_total,
    p.stock,
    CASE
        WHEN p.stock < 10 THEN 'Bajo Stock'
        WHEN p.stock BETWEEN 10 AND 50 THEN 'Stock Medio'
        ELSE 'Stock Suficiente'
    END AS estado_stock
FROM producto AS p
JOIN vista_productos_mas_vendidos AS vp ON p.nombre_producto = vp.nombre_producto
ORDER BY vp.cantidad_vendida DESC;


SELECT 
    e.id_envio,
    t.id_transaccion,
    c.nombre_cliente,
    e.fecha_envio,
    e.fecha_entrega_estimada,
    e.fecha_entrega_real,
    DATEDIFF(e.fecha_entrega_real, e.fecha_entrega_estimada) AS dias_diferencia,
    CASE
        WHEN DATEDIFF(e.fecha_entrega_real, e.fecha_entrega_estimada) = 0 THEN 'A Tiempo'
        WHEN DATEDIFF(e.fecha_entrega_real, e.fecha_entrega_estimada) < 0 THEN 'Adelantada'
        ELSE 'Retrasada'
    END AS estado_entrega
FROM envio AS e
JOIN transaccion AS t ON e.id_transaccion = t.id_transaccion
JOIN cliente c ON t.id_cliente = c.id_cliente
WHERE e.estado_envio = 'entregado';

SELECT 
    c.id_cliente,
    c.nombre_cliente,
    COUNT(t.id_transaccion) AS numero_compras,
    SUM(t.monto_transaccion) AS total_acumulado,
    AVG(t.monto_transaccion) AS promedio_por_compra
FROM cliente AS c
JOIN transaccion AS t ON c.id_cliente = t.id_cliente
GROUP BY c.id_cliente
HAVING COUNT(t.id_transaccion) > 5
ORDER BY total_acumulado DESC;
