USE personal;
-- Obtener los datos completos de los empleados.
SHOW FULL TABLES;
SELECT * FROM personal.empleados;
-- Obtener los datos completos de los departamentos.
SELECT * FROM personal.departamentos;
-- Listar el nombre de los departamentos
SELECT nombre_depto FROM personal.departamentos;
-- Obtener el nombre y salario de todos los empleados.
SELECT nombre, sal_emp FROM personal.empleados;
-- Listar todas las comisiones.
SELECT nombre,comision_emp FROM personal.empleados;
-- Obtener los datos de los empleados cuyo cargo sea ‘Secretaria’.
SELECT * FROM personal.empleados WHERE  cargo_emp LIKE 'secretaria';
-- Obtener los datos de los empleados vendedores, ordenados por nombr alfabéticamente.
SELECT * FROM personal.empleados WHERE  cargo_emp LIKE 'vendedor' ORDER BY nombre ASC;
-- Obtener el nombre y cargo de todos los empleados, ordenados por salario de menor a mayor.
SELECT nombre, cargo_emp, sal_emp FROM personal.empleados ORDER BY sal_emp ASC;
-- Obtener el nombre de o de los jefes que tengan su departamento situado en la ciudad de “Ciudad Real”
SELECT nombre_jefe_depto,nombre_depto,ciudad FROM personal.departamentos WHERE ciudad LIKE 'ciudad real';
-- Elabore un listado donde para cada fila, figure el alias ‘Nombre’ y ‘Cargo’ para las respectivas tablas de empleados.
SELECT nombre AS nombreTEMP, cargo_emp AS CargoTemp FROM personal.empleados;
-- Listar los salarios y comisiones de los empleados del departamento 2000, ordenado por comisión de menor a mayor.
SELECT nombre,sal_emp, comision_emp FROM personal.empleados WHERE id_depto LIKE '2000' ORDER BY comision_emp ASC;
-- Obtener el valor total a pagar a cada empleado del departamento 3000, que resulta de: sumar el salario y la comisión, 
-- más una bonificación de 500. Mostrar el nombre del empleado y el total a pagar, en orden alfabético.
SELECT nombre,(sal_emp + comision_emp+500) AS saldoTotal FROM personal.empleados WHERE id_depto = 3000 ORDER BY saldoTotal ASC;
-- Muestra los empleados cuyo nombre empiece con la letra J
SELECT nombre FROM personal.empleados WHERE nombre LIKE 'j%';
-- Listar el salario, la comisión, el salario total (salario+comisión) y nombre, de aquellos empleados que tienen comisión 
-- superior a 1000
SELECT nombre, sal_emp, comision_emp, (sal_emp + comision_emp) AS Salario_total FROM personal.empleados WHERE comision_emp >1000;
-- Obtener un listado similar al anterior, pero de aquellos empleados que NO tienen comisión
SELECT nombre, sal_emp, comision_emp, (sal_emp + comision_emp) AS Salario_total FROM personal.empleados WHERE comision_emp = 0;
-- Obtener la lista de los empleados que ganan una comisión superior a su sueldo.
SELECT nombre, sal_emp, comision_emp  AS ComisionMayor FROM personal.empleados WHERE comision_emp > sal_emp;
-- Listar los empleados cuya comisión es menor o igual que el 30% de su sueldo
SELECT nombre, sal_emp, comision_emp, (sal_emp + comision_emp) AS Salario_total FROM personal.empleados WHERE comision_emp <=(sal_emp*0.30);
-- Hallar los empleados cuyo nombre no contiene la cadena “MA"
SELECT nombre AS nombreSinMA FROM personal.empleados WHERE nombre NOT LIKE '%ma%';
-- Obtener los nombres de los departamentos que sean “Ventas”, “Investigación” o ‘Mantenimiento
SELECT nombre_depto FROM personal.departamentos WHERE nombre_depto IN ('Ventas', 'Investigacion', 'Mantenimiento');
-- Ahora obtener el contrario, los nombres de los departamentos que no sean “Ventas” ni “Investigación” ni ‘Mantenimiento
SELECT nombre_depto FROM personal.departamentos WHERE nombre_depto NOT IN ('Ventas', 'Investigacion', 'Mantenimiento');
-- Mostrar el salario más alto de la empresa
SELECT max(sal_emp) FROM personal.empleados ;
-- Mostrar el nombre del último empleado de la lista por orden alfabético
SELECT nombre FROM personal.empleados ORDER BY nombre DESC LIMIT 1;
-- Hallar el salario más alto, el más bajo y la diferencia entre ellos
SELECT max(sal_emp) AS salarioMinimo, min(sal_emp) AS salarioMaximo, max(sal_emp) - min(sal_emp) AS Diferencia FROM personal.empleados;
-- Hallar el salario promedio por departamento
SELECT AVG(sal_emp) AS SalrarioPromedio FROM personal.empleados;
-- HAVING
-- Hallar los departamentos que tienen más de tres empleados. Mostrar el número de empleados de esos departamentos.
SELECT id_depto, COUNT(id_emp) AS 'cantidadEmpleados' FROM personal.empleados GROUP BY id_depto HAVING  COUNT(id_emp) > 3 ;
-- Hallar los departamentos que no tienen empleados
SELECT id_depto, COUNT(id_emp) AS 'cantidadEmpleados' FROM personal.empleados GROUP BY id_depto HAVING  COUNT(id_emp) = 0 ;
-- Multitabla (JOIN/LEFT JOIN/RIGHT JOIN)
-- Mostrar la lista de empleados, con su respectivo departamento y el jefe de cada departamento
SELECT nombre, nombre_jefe_depto, nombre_depto FROM personal.empleados INNER JOIN personal.departamentos ON personal.empleados.id_depto = personal.departamentos.id_depto;
-- SELECT nombre, nombre_jefe_depto, nombre_depto FROM personal.empleados LEFT JOIN personal.departamentos ON personal.empleados.id_depto = personal.departamentos.id_depto;
-- SELECT nombre, nombre_jefe_depto, nombre_depto FROM personal.empleados RIGHT JOIN personal.departamentos ON personal.empleados.id_depto = personal.departamentos.id_depto;

-- Subconsulta
-- Mostrar la lista de los empleados cuyo salario es mayor o igual que el promedio de la empresa. Ordenarlo por departamento
-- ó
-- SELECT nombre, sal_emp, id_depto FROM personal.empleados WHERE sal_emp >= 2115384.6153846155 ORDER BY id_depto;
SELECT nombre, sal_emp, id_depto FROM personal.empleados WHERE sal_emp >= (SELECT AVG(sal_emp) FROM personal.empleados) ORDER BY id_depto;

