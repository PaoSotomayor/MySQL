USE nba;
-- 1. Mostrar el nombre de todos los jugadores ordenados alfabéticamente.
SELECT nombre FROM jugadores ORDER BY nombre asc;
-- 2. Mostrar el nombre de los jugadores que sean pivots (‘C’) y que pesen más de 200 libras,
-- ordenados por nombre alfabéticamente.
SELECT nombre as 'Pivots de mas de 200 lb', peso, posicion FROM jugadores 
	WHERE Posicion = "C" AND Peso >= 200
	ORDER BY Nombre;
-- 3. Mostrar el nombre de todos los equipos ordenados alfabéticamente.
SELECT nombre AS Equipos FROM equipos ORDER BY nombre;
-- 4 Mostrar el nombre de los equipos del este (East).
SELECT nombre AS 'Equipos del Este' FROM equipos WHERE conferencia = 'East';
-- 5. Mostrar los equipos donde su ciudad empieza con la letra ‘c’, ordenados por nombre.
SELECT nombre, ciudad FROM equipos WHERE ciudad LIKE 'c%' ORDER BY nombre;
-- 6. Mostrar todos los jugadores y su equipo ordenados por nombre del equipo.
SELECT nombre, nombre_equipo FROM jugadores ORDER BY nombre_equipo;
-- 7. Mostrar todos los jugadores del equipo “Raptors” ordenados por nombre.
SELECT nombre, nombre_equipo FROM jugadores WHERE nombre_equipo LIKE 'Raptors' ORDER BY nombre; 
-- 8. Mostrar los puntos por partido del jugador ‘Pau Gasol’.
SELECT e.puntos_por_partido AS PPP, j.nombre FROM estadisticas e INNER JOIN jugadores j 
	ON e.jugador = j.codigo WHERE nombre = 'Pau Gasol';
   -- ó
SELECT j.nombre ,e.Puntos_por_partido AS PPP FROM jugadores j, estadisticas e WHERE j.codigo = e.jugador 
AND e.jugador=(SELECT codigo FROM jugadores WHERE nombre LIKE 'Pau Gasol');
-- 9. Mostrar los puntos por partido del jugador ‘Pau Gasol’ en la temporada ’04/05′.
SELECT nombre ,Puntos_por_partido AS PPP FROM jugadores, estadisticas e WHERE codigo = jugador 
AND e.jugador=(SELECT DISTINCT codigo FROM jugadores WHERE nombre LIKE 'Pau Gasol' AND e.temporada = '04/05');
-- 10. Mostrar el número de puntos de cada jugador en toda su carrera.
SELECT nombre, (SELECT SUM(Puntos_por_partido) FROM estadisticas WHERE jugador = codigo) AS 'Puntos totales' FROM jugadores ORDER BY nombre ;
-- ó
SELECT nombre, SUM(Puntos_por_partido) FROM estadisticas INNER JOIN jugadores ON jugador = codigo GROUP BY nombre;
-- ó
SELECT nombre, sum(puntos_por_partido) as 'Puntos totales' FROM estadisticas, jugadores WHERE jugador=codigo 
GROUP BY nombre HAVING SUM(puntos_por_partido);
-- 11. Mostrar el número de jugadores de cada equipo.
SELECT nombre_equipo,COUNT(nombre_equipo) AS 'Número de jugadores' FROM jugadores GROUP BY nombre_equipo;
-- 12. Mostrar el jugador que más puntos ha realizado en toda su carrera.
SELECT nombre AS 'Jugador',(SELECT ROUND(SUM(Puntos_por_partido)) FROM estadisticas 
	WHERE jugador = codigo) AS 'Puntos Totales' FROM jugadores ORDER BY 
		(SELECT ROUND(SUM(Puntos_por_partido)) FROM estadisticas WHERE jugador = codigo) DESC LIMIT 1; 
-- 13. Mostrar el nombre del equipo, conferencia y división del jugador más alto de la NBA.
SELECT j.nombre AS 'Nombre Jugador', j.altura, e.nombre AS 'Nombre Equipo', e.conferencia, e.division FROM jugadores as j 
INNER JOIN equipos as e ON j.nombre_equipo = e.nombre WHERE j.altura = (SELECT MAX(altura) FROM jugadores);
-- 14. Mostrar la media de puntos en partidos de los equipos de la división Pacific.
SELECT p.equipo_local, AVG(p.puntos_local) AS 'Media de puntos' FROM partidos AS p INNER JOIN equipos AS e
ON p.equipo_local = e.nombre WHERE e.division = 'Pacific' GROUP BY p.equipo_local;
-- 15. Mostrar el partido o partidos (equipo_local, equipo_visitante y diferencia) con mayor diferencia de puntos.		
SELECT equipo_local AS 'Local', equipo_visitante AS 'Visitante', ABS(puntos_local-puntos_visitante) AS 'Diferencia'
	FROM partidos WHERE ABS(puntos_local-puntos_visitante)=(SELECT MAX(puntos_local-puntos_visitante) FROM partidos);
-- 16. Mostrar la media de puntos en partidos de los equipos de la división Pacific.
SELECT p.equipo_local, AVG(p.puntos_local) AS 'Media de puntos' FROM partidos AS p INNER JOIN equipos AS e
ON p.equipo_local = e.nombre WHERE e.division = 'Pacific' GROUP BY p.equipo_local;

-- 17. Mostrar los puntos de cada equipo en los partidos, tanto de local como de visitante.
SELECT e.nombre AS Equipo, p.puntos_local, p.puntos_visitante FROM partidos p, equipos e;

SELECT partidos.equipo_local, puntos_local, partidos.puntos_visitante, partidos.equipo_visitante FROM partidos;

SELECT equipo_local AS 'Local', puntos_local AS 'Puntos Local', puntos_visitante AS 'Puntos Visitante', equipo_visitante AS 'Visitante'
FROM partidos;
SELECT DISTINCT(e.nombre),
        (SELECT SUM(puntos_local) FROM partidos WHERE equipo_local = e.nombre) as Puntos_local,
        (SELECT SUM(puntos_visitante) FROM partidos WHERE equipo_visitante = e.nombre) as Puntos_visitante
FROM equipos as e;
-- 18. Mostrar quien gana en cada partido (codigo, equipo_local, equipo_visitante, equipo_ganador), en caso de empate sera null.
select codigo, equipo_local as 'Local', equipo_visitante as 'Visitante',
(puntos_local>puntos_visitante) as' Local Gana (1)',(puntos_local<puntos_visitante) as' Visitante Gana (1)'
from partidos;

SELECT p.codigo,p.equipo_local,p.equipo_visitante, CASE WHEN (p.puntos_local>p.puntos_visitante) THEN equipo_local 
when (p.puntos_local<p.puntos_visitante) THEN equipo_visitante ELSE null end as equipoGanador from partidos p; 

SELECT codigo AS 'Codigo', puntos_local AS 'Puntos Local', puntos_visitante AS 'Puntos Visitante', 
(SELECT CASE WHEN (puntos_local> puntos_visitante) THEN equipo_local WHEN (puntos_local<puntos_visitante) THEN equipo_visitante ELSE NULL END) AS 'Equipo Ganador'
FROM partidos;

SELECT codigo, equipo_local, equipo_visitante,
    CASE
        WHEN puntos_local > puntos_visitante THEN equipo_local
        WHEN puntos_local < puntos_visitante THEN equipo_visitante
        ELSE NULL
    END AS equipo_ganador
FROM partidos;