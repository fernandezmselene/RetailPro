USE Ventas_Tech_DB;

-- == Consulta 1 — Resumen ejecutivo mensual ==
SELECT 
	MONTH(fecha_venta) AS mes,
	SUM (cantidad * precio_unitario) AS total_facturado,
	COUNT(*) AS cantidad_pedidos,
	AVG (cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

-- == Consulta 2 — Ranking de productos (TOP 5) ==
SELECT TOP 5
	id_producto,
	SUM (cantidad * precio_unitario) AS total_facturado,
	SUM (cantidad) AS unidades_vendidas
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;

-- == Consulta 3 — Clientes recurrentes ==
SELECT
	id_cliente,
	COUNT (*) AS cantidad_pedidos,
	SUM (cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1;

-- == Consulta 4 — Productos por encima/por debajo del promedio Total facturado ==
WITH ventas_por_producto AS (
    SELECT
        id_producto,
        SUM (cantidad * precio_unitario) AS total_facturado
    FROM ventas
    GROUP BY id_producto
)
SELECT
    id_producto,
    total_facturado,
    CASE
        WHEN total_facturado > (SELECT AVG(total_facturado) FROM ventas_por_producto) THEN 'Por encima'
        ELSE 'Por debajo'
    END AS comparacion
FROM ventas_por_producto
ORDER BY id_producto;

-- == BLOQUE DE HALLAZGOS ==
-- HALLAZGO 1: Más del 50% del total facturado en el mes corresponde a las ventas del producto 1 ($3600 sobre un total de $6444).
-- HALLAZGO 2: Si bien el producto 2 registra la mayor cantidad de unidades vendidas (13 u), su facturación representa aproximadamente el 10% en comparación con el producto con mayor ingreso.
-- HALLAZGO 3: Solo dos clientes (con id 1 y 5) concentran aproximadamente el 70% de la facturación total en el mes.