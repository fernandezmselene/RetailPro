USE Ventas_Tech_DB;

-- Consulta 1 — Vista base del proyecto (INNER JOIN)
-- Propósito: Visualizar en una sola fila fecha, identificación del cliente, descripción del producto, cantidad, precio unitario y total de venta.
SELECT
	v.id_venta,
	v.fecha_venta,
	c.nombre,
	p.nombre_producto,
	cat.nombre_categoria,
	v.cantidad,
	v.precio_unitario,
	(v.cantidad * precio_unitario) AS total_venta
FROM ventas v
INNER JOIN clientes c ON v.id_cliente = c.id_cliente
INNER JOIN productos p ON v.id_producto = p.id_producto
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria;

HACER TABLA TERRITORIO
-- Hallazgo: Se generó una vista integrada óptima.

-- Consulta 2 — Clientes sin ventas (LEFT JOIN)
-- Propósito: Identificar clientes registrados que aún no han realizado ninguna compra, para que CRM los contacte.
SELECT
	c.nombre,
	c.email,
	c.fecha_registro
FROM clientes c
LEFT JOIN ventas v ON v.id_cliente = c.id_cliente
WHERE v.id_venta IS NULL;
-- Hallazgo: El 100% de los clientes registrados realizaron al menos una compra en el período analizado.

-- Consulta 3 — Productos sin ventas (LEFT JOIN)
-- Propósito: Identificar los productos que no tienen ninguna venta registrada.
SELECT
	p.nombre_producto,
	cat.nombre_categoria,
	p.precio
FROM productos p
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas v ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;
-- Hallazgo: Todos los productos se vendieron al menos una vez en el período analizado.

-- Consulta 4 — Consolidado por canal (UNION ALL)
-- Propósito: Categorizar y comparar la facturación total.
SELECT canal, SUM(total) AS total_canal
FROM (
    SELECT fecha_venta, cantidad * precio_unitario AS total, 'Online' AS canal
    FROM ventas
	WHERE cantidad * precio_unitario < 1000
    UNION ALL
    SELECT fecha_venta, cantidad * precio_unitario AS total, 'Presencial' AS canal
    FROM ventas
	WHERE cantidad * precio_unitario > = 1000
) AS consolidado
GROUP BY canal;
-- Hallazgo: El canal presencial concentra mayor facturación ($3600) frente al online ($2844).
