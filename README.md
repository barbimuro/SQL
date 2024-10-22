
# Proyecto **styles_by_bm** - Base de Datos de Gestión de Productos de Belleza

Este proyecto corresponde a una base de datos para la gestión de transacciones, productos, clientes y proveedores de una tienda en línea de productos de belleza. La base de datos se denomina **`styles_by_bm`** y está diseñada para manejar desde el inventario de productos hasta las transacciones, envíos y descuentos asociados a los productos. Además, incluye mecanismos para gestionar el historial de precios y las opiniones de los clientes.

## Tabla de Contenidos

- [Estructura de la Base de Datos](#estructura-de-la-base-de-datos)
- [Vistas](#vistas)
- [Funciones](#funciones)
- [Procedimientos Almacenados](#procedimientos-almacenados)
- [Disparadores (Triggers)](#disparadores-triggers)
- [Roles y Permisos](#roles-y-permisos)
- [Instrucciones de Instalación](#instrucciones-de-instalación)
- [Consultas Ejemplo](#consultas-ejemplo)

## Estructura de la Base de Datos

La base de datos contiene las siguientes tablas:

1. **cliente**: Información de los clientes, como nombre, dirección, teléfono y email.
2. **proveedor**: Información de los proveedores.
3. **categoria_producto**: Categorías a las que pertenecen los productos.
4. **producto**: Información sobre los productos, su precio, descripción, stock y relación con categorías y proveedores.
5. **descuento**: Define los descuentos aplicables a transacciones, con porcentaje de descuento y fechas de validez.
6. **transaccion**: Detalle de las compras realizadas por los clientes, con estado de la transacción y relación con los descuentos.
7. **detalle_transaccion**: Relación entre los productos y las transacciones, incluyendo cantidad y precio unitario de los productos.
8. **envio**: Información sobre los envíos de las transacciones.
9. **opinion**: Opiniones de los clientes sobre los productos, con calificaciones y comentarios.
10. **historial_precios**: Historial de cambios en los precios de los productos.

### Relación Entre Tablas

- **`transaccion`** tiene una relación 1:N con **`cliente`** y 1:N con **`descuento`**.
- **`detalle_transaccion`** es una tabla intermedia entre **`transaccion`** y **`producto`** para modelar una relación N:M.
- **`envio`** está relacionado 1:1 con **`transaccion`**.
- **`opinion`** está relacionado N:1 con **`producto`** y **`cliente`**.
- **`historial_precios`** registra los cambios de precios de cada producto.

## Vistas

El proyecto cuenta con 5 vistas predefinidas para simplificar la obtención de información clave:

1. **vista_productos_mas_vendidos**: Muestra los productos más vendidos, la cantidad vendida y los ingresos totales generados.
   
    ```sql
    SELECT p.nombre_producto, SUM(dt.cantidad_producto) AS cantidad_vendida, SUM(dt.precio_unitario * dt.cantidad_producto) AS ingreso_total
    FROM producto AS p
    JOIN detalle_transaccion AS dt ON p.id_producto = dt.id_producto
    GROUP BY p.id_producto
    ORDER BY cantidad_vendida DESC;
    ```

2. **vista_envios_cancelados**: Muestra las transacciones canceladas y sus detalles.
   
3. **vista_opiniones_productos**: Muestra las opiniones y calificaciones de los clientes sobre los productos.
   
4. **vista_historial_precios**: Muestra el historial de precios de los productos.

5. **vista_clientes_ultimas_compras**: Muestra la última transacción realizada por cada cliente.

## Funciones

Se han definido dos funciones clave:

1. **`fn_total_transacciones`**: Devuelve la cantidad total de transacciones realizadas por un cliente específico.

    ```sql
    CREATE FUNCTION fn_total_transacciones(cid INT)
    RETURNS INT
    ```

2. **`fn_dias_desde_ultima_transaccion`**: Calcula el número de días desde la última transacción de un cliente.

    ```sql
    CREATE FUNCTION fn_dias_desde_ultima_transaccion(cid INT)
    RETURNS INT
    ```

## Procedimientos Almacenados

1. **`reportar_info_cliente`**: Muestra la información básica de un cliente, su total de transacciones y el tiempo desde su última compra.

2. **`chequeo_transaccion_envio`**: Muestra el estado de una transacción y el estado de envío relacionado, junto con los días desde la última transacción.

## Disparadores (Triggers)

El proyecto incluye dos triggers importantes:

1. **`evitar_monto_cero`**: Verifica que las transacciones no tengan un monto igual o inferior a cero.

    ```sql
    CREATE TRIGGER evitar_monto_cero
    BEFORE INSERT ON transaccion
    FOR EACH ROW
    ```

2. **`actualizar_stock_producto`**: Actualiza el stock del producto cuando se realiza una venta (inserción en detalle_transaccion).

    ```sql
    CREATE TRIGGER actualizar_stock_producto
    AFTER INSERT ON detalle_transaccion
    ```

## Roles y Permisos

Se han creado varios roles de usuarios con diferentes niveles de permisos:

1. **`admin_bm`**: Tiene todos los privilegios sobre la base de datos.
   
2. **`gerente_bm`**: Puede gestionar transacciones, productos y clientes.
   
3. **`proveedor_bm`**: Puede ver y actualizar los productos, así como consultar las transacciones.
   
4. **`soporte_bm`**: Tiene acceso a la información de envíos y puede actualizar su estado.

## Instrucciones de Instalación

1. Clonar el repositorio o descargar el script SQL.
2. Cargar el script en tu motor de base de datos MySQL:
   
    ```bash
    mysql -u usuario -p < script.sql
    ```

3. Ejecutar las sentencias SQL para crear las tablas, vistas, funciones, procedimientos y triggers.
4. Crear los usuarios y asignar los roles utilizando las sentencias `CREATE USER` y `GRANT`.

## Consultas Ejemplo

- **Consultar los productos más vendidos**:

    ```sql
    SELECT * FROM vista_productos_mas_vendidos;
    ```

- **Obtener los días desde la última transacción de un cliente**:

    ```sql
    SELECT fn_dias_desde_ultima_transaccion(1);
    ```

- **Ver las opiniones de un producto**:

    ```sql
    SELECT * FROM vista_opiniones_productos WHERE nombre_producto = 'Shampoo';
    ```

---

Este README proporciona una visión general del proyecto y te permite comprender la estructura y funcionalidad de la base de datos **`styles_by_bm`** para la gestión eficiente de una tienda de productos de belleza.

