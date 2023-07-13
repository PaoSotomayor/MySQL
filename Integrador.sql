USE nba;
-- Teniendo el máximo de asistencias por partido, muestre cuantas veces se logró dicho máximo.
-- Este resultado nos dará la posición del candado (1, 2, 3 o 4)
 -- Candado A
SELECT asistencias_por_partido FROM estadisticas;
SELECT MAX(asistencias_por_partido) FROM estadisticas;
SELECT COUNT(*) AS Posicion FROM estadisticas  WHERE Asistencias_por_partido= (SELECT MAX(asistencias_por_partido) 
FROM estadisticas );
# ->Posicion 2

-- CLAVE: Muestre la suma total del peso de los jugadores, donde la conferencia sea Este y la posición sea
-- centro o esté comprendida en otras posiciones.
-- LLAVE A
SELECT *FROM jugadores;
SELECT SUM(jugadores.peso) AS CLave FROM jugadores JOIN equipos 
ON jugadores.nombre_equipo = equipos.nombre WHERE equipos.conferencia=('East') 
AND (jugadores.posicion LIKE ('%C%'));
#Clave 14043

#A: ->2,14043

-- Muestre la cantidad de jugadores que poseen más asistencias por partidos, que el numero de
-- jugadores que tiene el equipo Heat.
-- CANDADO B
SELECT * FROM jugadores;
SELECT * FROM estadisticas;

SELECT COUNT(*)  FROM jugadores WHERE Nombre_equipo = 'Heat';
SELECT COUNT(*) AS  Posicion FROM estadisticas
WHERE Asistencias_por_partido > (SELECT COUNT(*) FROM jugadores WHERE Nombre_equipo = 'Heat');
-- > Posicion 3

-- Clave: La clave del candado B estará con formada por la/s siguientes consulta/s a la base de datos:
-- La clave será igual al conteo de partidos jugados durante las temporadas del año 1999.

SELECT COUNT(*) AS Clave FROM partidos WHERE temporada LIKE '%99%';
SELECT COUNT(*) AS Clave FROM partidos WHERE temporada LIKE '%99';
# Clave 3480 
#B -> 3,3480

-- Posición: El candado C está ubicado en la posición calculada a partir del número obtenido en la/s
-- siguiente/s consulta/s:
-- La posición del código será igual a la cantidad de jugadores que proceden de Michigan y forman
-- parte de equipos de la conferencia oeste.
-- Candado C
SELECT COUNT(*) FROM jugadores as j JOIN equipos as e ON j.nombre_equipo = e.nombre WHERE j.procedencia 
LIKE "%Michigan%" AND e.conferencia = "West";
-- Al resultado obtenido lo dividiremos por la cantidad de jugadores cuyo peso es mayor o igual a
-- 195, y a eso le vamos a sumar 0.9945.
SELECT COUNT(*) AS'Peso >= a 195' FROM jugadores WHERE (Peso >= 195) + 0.9945;

SELECT (SELECT COUNT(*) FROM jugadores j JOIN equipos e ON j.Nombre_equipo = e.Nombre
WHERE procedencia LIKE "%Michigan%" AND e.conferencia = "West")
/ (SELECT COUNT(*) FROM jugadores WHERE (peso >= 195)) + 0.9945 AS Posicion;
-- Este resultado nos dará la posición del candado (1, 2, 3 o 4)
#-> Posicion 1
-- Clave: La clave del candado C estará con formada por la/s siguientes consulta/s a la base de datos:
-- Para obtener el siguiente código deberás redondear hacia abajo el resultado que se devuelve de sumar:
-- el promedio de puntos por partido,
SELECT AVG(Puntos_por_partido) FROM estadisticas;
-- el conteo de asistencias por partido 
SELECT COUNT(Asistencias_por_partido) FROM estadisticas;
-- y la suma de tapones por partido. 
SELECT SUM(Tapones_por_partido) FROM estadisticas;
-- Ademas este resultado debe ser, donde la division sea central.
SELECT (AVG(puntos_por_partido)+ COUNT(Asistencias_por_partido))  FROM estadisticas;
SELECT FLOOR(AVG(e.Puntos_por_partido)+COUNT(e.Asistencias_por_partido)+SUM(e.Tapones_por_partido)) AS Llave
FROM estadisticas as e JOIN jugadores as j ON e.jugador = j.codigo JOIN equipos as eq
ON j.nombre_equipo = eq.nombre
WHERE eq.division = "Central";
#C -> 1, 631

-- CANDADO D 
-- Posición:  El candado D está ubicado en la posición calculada a partir del número obtenido en la/s siguiente/s consulta/s:  
-- Muestre los tapones por partido del jugador Corey Maggette durante la temporada 00/01.

SELECT ROUND(Tapones_por_partido) AS 'Posicion Candado D' FROM estadisticas 
WHERE temporada = '00/01' AND jugador = (SELECT codigo FROM jugadores WHERE Nombre = 'Corey Maggette');

SELECT FLOOR(Tapones_por_partido) AS Posicion
FROM estadisticas JOIN jugadores ON estadisticas.jugador = jugadores.codigo 
WHERE jugadores.Nombre = 'Corey Maggette' AND estadisticas.temporada = '00/01';

-- Este resultado nos dará la posición del candado (1, 2, 3 o 4) 
-- Clave: La clave del candado D estará con formada por la/s siguientes consulta/s a la base de datos:  
-- Para obtener el siguiente código deberás redondear hacia abajo, la suma de puntos por partido 
-- de todos los jugadores de procedencia argentina.

SELECT FLOOR(SUM(e.Puntos_por_partido))AS Llave FROM estadisticas  e JOIN jugadores j
ON e.jugador = j.codigo WHERE j.procedencia = "Argentina";

#D -> 4, 191