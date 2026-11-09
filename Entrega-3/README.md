# Ventas_Tech_DB

Script SQL correspondiente al tercer entregable del curso, cuyo objetivo es realizar el scrip SQL que genera la base de datos Ventas_Tech_DB donde va a vivir toda la información de ventas.

## Contenido del script (`ventas_tech_db.sql`)
Estructura relacional normalizada hasta 3NF para SQL Server, dividida en 4 secciones:
1. **DROP TABLES**: Eliminación previa de tablas en orden inverso a las dependencias para el script sea repetible.
2. **CREATE TABLES**: Creación de las tablas (`categorias`, `clientes`, `productos`, `ventas`) con sus respectivas PK y FK.
3. **INSERT DATA**: Carga de los registros iniciales.
4. **VALIDACIÓN**: Consultas `SELECT` de control.
