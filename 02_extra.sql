use jardineria;
-- 1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.
SELECT codigo_oficina, ciudad FROM oficina;
-- 2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.
SELECT ciudad, telefono FROM oficina WHERE pais LIKE 'españa';
-- 3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.
SELECT nombre, apellido1, apellido2, email FROM empleado WHERE codigo_jefe = 7;
-- 4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.
SELECT puesto, nombre, apellido1, apellido2, email FROM empleado WHERE puesto LIKE 'Director General';
-- 5. Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.
SELECT nombre, apellido1, apellido2, puesto FROM empleado WHERE puesto NOT LIKE 'representante ventas';
-- 6. Devuelve un listado con el nombre de los todos los clientes españoles.
SELECT nombre_cliente, pais FROM cliente WHERE pais LIKE 'Spain';
-- 7. Devuelve un listado con los distintos estados por los que puede pasar un pedido.
SELECT DISTINCT(estado) FROM pedido;
-- 8. Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2008. 
--  Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:
--  a Utilizando la función YEAR de MySQL.
SELECT DISTINCT(codigo_cliente) FROM pago WHERE YEAR(fecha_pago) = 2008;
--  b Utilizando la función DATE_FORMAT de MySQL. o Sin utilizar ninguna de las funciones anteriores.
SELECT distinct(codigo_cliente) FROM pago WHERE DATE_FORMAT(fecha_pago, "%Y") = 2008;
--  c Sin utilizar ninguna de las funciones anteriores.
SELECT DISTINCT codigo_cliente FROM pago WHERE fecha_pago >= '2008-01-01' AND fecha_pago < '2009-01-01';
SELECT distinct(codigo_cliente) FROM pago WHERE LEFT(fecha_pago, 4) = 2008;
-- 9. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos que 
-- no han sido entregados a tiempo.
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM pedido WHERE fecha_entrega > fecha_esperada;
-- 10. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos cuya 
-- fecha de entrega ha sido al menos dos días antes de la fecha esperada.
-- Utilizando la función ADDDATE de MySQL.
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM pedido 
WHERE ADDDATE(fecha_entrega, INTERVAL 2 DAY) <= fecha_esperada;
-- Utilizando la función DATEDIFF de MySQL.
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM pedido
WHERE DATEDIFF(fecha_esperada, fecha_entrega) >= 2;
-- 11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.
SELECT *FROM pedido WHERE estado LIKE 'rechazado' AND YEAR(fecha_pedido) = 2009;
-- 12. Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier año.
SELECT *FROM pedido WHERE estado LIKE 'entregado' AND MONTH(fecha_pedido) =1;
-- 13. Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal. 
-- Ordene el resultado de mayor a menor.
SELECT * FROM pago WHERE forma_pago = "PayPal" AND YEAR(fecha_pago) = 2008 ORDER BY fecha_pago;
-- 14. Devuelve un listado con todas las formas de pago que aparecenen la tabla pago.
-- Tenga en cuenta que no deben aparecer formas de pago repetidas.
SELECT DISTINCT(forma_pago) FROM pago;
-- 15. Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que tienen más de 100 unidades 
-- en stock. 
-- El listado deberá estar ordenado por su precio de venta, mostrando en primer lugar los de mayor precio.
SELECT * FROM producto WHERE gama LIKE 'ornamentales' AND cantidad_en_stock > 100 ORDER BY precio_venta DESC;
-- 16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo representante de ventas tenga 
-- el código de empleado 11 o 30.
SELECT nombre_cliente, ciudad, codigo_empleado_rep_ventas FROM cliente WHERE ciudad LIKE 'Madrid' 
AND codigo_empleado_rep_ventas IN (11,30);
-- Consultas multitabla (Composición interna)
-- Las consultas se deben resolver con INNER JOIN.
-- 1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.
SELECT c.nombre_cliente, e.nombre, e.apellido1, e.apellido2 FROM cliente c JOIN empleado e
ON c.codigo_empleado_rep_ventas = e.codigo_empleado ORDER BY nombre_cliente;
-- 2. Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.
SELECT DISTINCT(c.nombre_cliente), e.nombre AS 'Rep. Ventas' FROM cliente as c INNER JOIN pago as p
ON c.codigo_cliente = p.codigo_cliente INNER JOIN empleado as e ON c.codigo_empleado_rep_ventas = e.codigo_empleado 
ORDER BY c.nombre_cliente;
-- 3. Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas.
SELECT DISTINCT c.nombre_cliente , e.nombre FROM cliente as c LEFT JOIN pago as p ON c.codigo_cliente = p.codigo_cliente
INNER JOIN empleado as e ON c.codigo_empleado_rep_ventas = e.codigo_empleado WHERE p.fecha_pago IS NULL;
-- 4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina 
-- a la que pertenece el representante.
SELECT DISTINCT c.nombre_cliente, e.nombre, o.ciudad FROM cliente as c INNER JOIN pago as p
ON c.codigo_cliente = p.codigo_cliente INNER JOIN empleado as e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
INNER JOIN oficina as o ON e.codigo_oficina = o.codigo_oficina;

SELECT DISTINCT c.nombre_cliente, e.nombre, o.ciudad FROM cliente c JOIN pago p ON c.codigo_cliente = p.codigo_cliente
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado JOIN oficina o ON e.codigo_oficina = o.codigo_oficina;
-- 5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes junto con la ciudad 
-- de la oficina a la que pertenece el representante.
SELECT DISTINCT(c.nombre_cliente), e.nombre, o.ciudad FROM cliente as c LEFT JOIN pago as p ON c.codigo_cliente = p.codigo_cliente
INNER JOIN empleado as e ON c.codigo_empleado_rep_ventas = e.codigo_empleado INNER JOIN oficina as o ON e.codigo_oficina = o.codigo_oficina  
WHERE p.fecha_pago IS NULL;

SELECT DISTINCT c.nombre_cliente, e.nombre, o.ciudad FROM cliente c LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente JOIN empleado e
ON c.codigo_empleado_rep_ventas = e.codigo_empleado JOIN oficina o ON e.codigo_oficina = o.codigo_oficina WHERE p.fecha_pago IS NULL; 
-- 6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
SELECT DISTINCT o.linea_direccion1, o.linea_direccion2 FROM oficina o JOIN empleado e
ON o.codigo_oficina = e.codigo_oficina JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE c.ciudad = "Fuenlabrada";
-- 7. Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que 
-- pertenece el representante.
SELECT DISTINCT c.nombre_cliente, e.nombre, o.ciudad FROM oficina o JOIN empleado e 
ON o.codigo_oficina = e.codigo_oficina JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas;

-- 8. Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.
SELECT nombre, (SELECT nombre FROM empleado WHERE e.codigo_jefe = codigo_empleado) AS 'Empleado + Jefes'
FROM empleado e;
-- 9. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.
SELECT nombre_cliente FROM cliente c JOIN pedido p ON c.codigo_cliente = p.codigo_cliente WHERE fecha_entrega > fecha_esperada;

-- 10. Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.
SELECT c.nombre_cliente, pr.gama FROM cliente c JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
JOIN detalle_pedido d ON d.codigo_pedido = p.codigo_pedido JOIN producto pr
ON pr.codigo_producto = d.codigo_producto GROUP BY c.nombre_cliente, pr.gama;
-- Consultas multitabla (Composición externa)
-- Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, JOIN.
-- 1. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
SELECT DISTINCT c.nombre_cliente FROM cliente as c LEFT JOIN pedido as p 
ON c.codigo_cliente = p.codigo_cliente WHERE p.fecha_pago IS NULL;
-- 2. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.
SELECT DISTINCT c.nombre_cliente FROM cliente as c RIGHT JOIN pago as p 
ON c.codigo_cliente = p.codigo_cliente WHERE p.codigo_cliente IS NULL; -- (?)
-- 3. Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no han realizado ningún pedido.
SELECT DISTINCT c.nombre_cliente FROM cliente as c RIGHT JOIN pago as p 
ON c.codigo_cliente = p.codigo_cliente LEFT JOIN pedido pe ON c.codigo_cliente = pe.codigo_cliente 
WHERE pe.codigo_cliente IS NULL; -- Tampoco se si es asi
-- 4. Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.
SELECT e.nombre, e.apellido1, e.apellido2 FROM empleado e LEFT JOIN oficina o 
ON e.codigo_oficina = o.codigo_oficina WHERE o.codigo_oficina IS NULL;
-- 5. Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.
SELECT e.nombre, e.apellido1, e.apellido2 FROM empleado e LEFT JOIN cliente c 
ON e.codigo_empleado=c.codigo_empleado_rep_ventas WHERE c.codigo_cliente IS NULL;
-- 6. Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no tienen un cliente asociado.
SELECT e.nombre, e.apellido1, e.apellido2 FROM empleado e LEFT JOIN cliente c 
ON e.codigo_empleado=c.codigo_empleado_rep_ventas WHERE c.codigo_cliente IS NULL 
UNION SELECT e.nombre, e.apellido1, e.apellido2 FROM empleado e LEFT JOIN oficina o 
ON e.codigo_oficina = o.codigo_oficina WHERE o.codigo_oficina IS NULL;
-- 7. Devuelve un listado de los productos que nunca han aparecido en un pedido.
SELECT pr.nombre FROM producto pr LEFT JOIN detalle_pedido pe 
ON pr.codigo_producto = pe.codigo_producto WHERE pe.codigo_producto IS NULL;
-- 8. Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas de 
-- algún cliente que haya realizado la compra de algún producto de la gama Frutales.

SELECT o.codigo_oficina, o.pais, o.ciudad FROM oficina o WHERE o.codigo_oficina NOT IN (
SELECT o.codigo_oficina FROM oficina o JOIN empleado e ON o.codigo_oficina = e.codigo_oficina
JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
JOIN detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido
JOIN producto pr ON dp.codigo_producto = pr.codigo_producto WHERE pr.gama = 'Frutales');
-- 9. Devuelve un listado con los clientes que han realizado algún pedido, pero no han realizado ningún pago.
SELECT c.nombre_cliente FROM cliente c JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
LEFT JOIN pago pg ON c.codigo_cliente = pg.codigo_cliente WHERE pg.id_transaccion IS NULL;
-- 10. Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su jefe asociado.
SELECT CONCAT(e.nombre, ' ',e.apellido1,' ', e.apellido2) AS Empleados, CONCAT(e2.nombre,' ', e2.apellido1,' ', e2.apellido2 ) 
AS Jefe, e2.puesto FROM empleado e LEFT JOIN cliente c ON e.codigo_empleado=c.codigo_empleado_rep_ventas
LEFT JOIN empleado e2 ON e.codigo_jefe=e2.codigo_empleado where c.codigo_cliente is null;

-- Consultas resumen
-- 1. ¿Cuántos empleados hay en la compañía?
SELECT COUNT(*) AS 'Cantidad de empleados' FROM empleado;
-- 2. ¿Cuántos clientes tiene cada país?
SELECT COUNT(*) pais FROM cliente;
-- 3. ¿Cuál fue el pago medio en 2009?
SELECT AVG(total) AS 'Pago medio en 2009' FROM pago p WHERE YEAR(p.fecha_pago)=2009;
-- 4. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.
SELECT COUNT(*), estado FROM pedido GROUP BY estado;
-- 5. Calcula el precio de venta del producto más caro y más barato en una misma consulta.
SELECT MAX(p.precio_venta), MIN(p.precio_venta) FROm producto p;
-- 6. Calcula el número de clientes que tiene la empresa.
SELECT COUNT(*) FROM cliente;
-- 7. ¿Cuántos clientes tiene la ciudad de Madrid?
SELECT COUNT(*) FROM cliente c WHERE c.ciudad = 'Madrid';
-- 8. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?
SELECT COUNT(*), c.ciudad FROM cliente c WHERE c.ciudad LIKE 'M%'group by ciudad;
-- 9. Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende cada uno.
SELECT CONCAT(e.nombre,' ', e.apellido1) AS 'Representante de Ventas', COUNT(*) AS 'Total Clientes' FROM empleado e
JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas GROUP BY e.codigo_empleado;
-- 10. Calcula el número de clientes que no tiene asignado representante de ventas.
SELECT COUNT(*) FROM cliente c LEFT JOIN empleado e ON c.codigo_empleado_rep_ventas=e.codigo_empleado
WHERE e.codigo_empleado IS NULL; -- no se si es correcto
-- 11. Calcula la fecha del primer y último pago realizado por cada uno de los clientes. El listado deberá mostrar 
-- el nombre y los apellidos de cada cliente.
SELECT MIN(p.fecha_pago), MAX(p.fecha_pago),c.nombre_cliente, CONCAT(c.nombre_contacto,' ', c.apellido_contacto) AS 'Contacto'  FROM cliente c
JOIN pago p ON c.codigo_cliente=p.codigo_cliente GROUP BY c.codigo_cliente;
-- 12. Calcula el número de productos diferentes que hay en cada uno de los pedidos.
SELECT COUNT(*) AS cantidad, codigo_producto FROM detalle_pedido
GROUP BY codigo_producto ORDER BY cantidad DESC;
-- 13. Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos.
SELECT SUM(cantidad), codigo_producto FROM detalle_pedido GROUP BY codigo_producto;
-- 14. Devuelve un listado de los 20 productos más vendidos y el número total de unidades que se han vendido de cada uno. 
-- El listado deberá estar ordenado por el número total de unidades vendidas.
SELECT SUM(cantidad) AS '20 mas vendidos', codigo_producto FROM detalle_pedido
GROUP BY codigo_producto ORDER BY Total_unidades_vendidas DESC LIMIT 20;
-- 15. La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el IVA y el total facturado.
-- La base imponible se calcula sumando el coste del producto por el número de unidades vendidas de la tabla detalle_pedido. 
-- El IVA es el 21 % de la base imponible, y el total la suma de los dos campos anteriores.
SELECT SUM(cantidad*precio_unidad) AS base_imponible, SUM(cantidad*precio_unidad)*0.21 AS IVA,
SUM(cantidad*precio_unidad)+ SUM(cantidad*precio_unidad)*0.21 AS Total
FROM detalle_pedido;
-- 16. La misma información que en la pregunta anterior, pero agrupada por código de producto.
SELECT SUM(cantidad*precio_unidad) AS 'Base Imponible', SUM(cantidad*precio_unidad)*0.21 AS IVA,
SUM(cantidad*precio_unidad)+ SUM(cantidad*precio_unidad)*0.21 AS Total, codigo_producto
FROM detalle_pedido dp GROUP BY dp.codigo_producto;
-- 17. La misma información que en la pregunta anterior, pero agrupada por código de producto filtrada por los códigos 
-- que empiecen por OR.
SELECT SUM(cantidad*precio_unidad) AS 'Base Imponible', SUM(cantidad*precio_unidad)*0.21 AS IVA,
SUM(cantidad*precio_unidad)+ SUM(cantidad*precio_unidad)*0.21 AS Total, codigo_producto
FROM detalle_pedido dp GROUP BY dp.codigo_producto HAVING dp.codigo_producto LIKE 'or%';
-- 18. Lista las ventas totales de los productos que hayan facturado más de 3000 euros. Se mostrará el nombre, 
-- unidades vendidas, total facturado y total facturado con impuestos (21% IVA)
SELECT p.nombre, COUNT(*) as unidades_vendidas, SUM(cantidad*precio_unidad) AS Total, 
SUM(cantidad*precio_unidad)+ SUM(cantidad*precio_unidad)*0.21 AS 'Total con impuestos',dp.codigo_producto
FROM detalle_pedido dp INNER JOIN producto p ON dp.codigo_producto= p.codigo_producto
GROUP BY dp.codigo_producto HAVING total>3000;
