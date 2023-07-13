USE superheroes;
SHOW FULL TABLES;
SELECT * FROM personajes;
SELECT inteligencia FROM personajes ORDER BY inteligencia ASC;
SELECT personaje,inteligencia FROM personajes ORDER BY inteligencia DESC;
SELECT inteligencia,personaje FROM personajes group by inteligencia, personaje ;
