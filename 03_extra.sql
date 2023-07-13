use pokemondb;
-- 1. Mostrar el nombre de todos los pokemon.
SELECT nombre FROM pokemon;
-- 2. Mostrar los pokemon que pesen menos de 10k.
SELECT *FROM pokemon WHERE peso < 10;
-- 3. Mostrar los pokemon de tipo agua.
SELECT id_tipo FROM tipo WHERE nombre='Agua';
SELECT p.nombre FROM pokemon p JOIN pokemon_tipo pkt ON pkt.numero_pokedex = p.numero_pokedex 
WHERE pkt.id_tipo = (SELECT id_tipo FROM tipo WHERE nombre='Agua');

select pokemon.nombre from pokemon join pokemon_tipo on pokemon.numero_pokedex=pokemon_tipo.numero_pokedex 
join tipo on pokemon_tipo.id_tipo=tipo.id_tipo where tipo.nombre=('Agua');

-- 4. Mostrar los pokemon de tipo agua, fuego o tierra ordenados por tipo.
select tipo.nombre,pokemon.nombre from pokemon join pokemon_tipo on pokemon.numero_pokedex=pokemon_tipo.numero_pokedex 
join tipo on pokemon_tipo.id_tipo=tipo.id_tipo where tipo.nombre in ('Agua','Fuego','Tierra') order by tipo.nombre;

-- 5. Mostrar los pokemon que son de tipo fuego y volador.
select tipo.nombre,pokemon.nombre from pokemon join pokemon_tipo on pokemon.numero_pokedex=pokemon_tipo.numero_pokedex 
join tipo on pokemon_tipo.id_tipo=tipo.id_tipo where tipo.nombre in ('Fuego','Volador') order by tipo.nombre;

-- 6. Mostrar los pokemon con una estadística base de ps mayor que 200.
select p.nombre, e.ps FROM pokemon p Join estadisticas_base e ON p.numero_pokedex = e.numero_pokedex  Where ps > 200;
-- 7. Mostrar los datos (nombre, peso, altura) de la prevolución de Arbok.
select nombre, numero_pokedex from pokemon where nombre like 'Arbok';
SELECT pokemon_origen FROM evoluciona_de WHERE pokemon_evolucionado =(SELECT numero_pokedex FROM pokemon WHERE nombre LIKE 'Arbok');

select p.nombre, p.peso, p.altura from pokemon p where numero_pokedex = (select pokemon_origen from evoluciona_de 
where pokemon_evolucionado = (select numero_pokedex from pokemon where nombre = 'Arbok'));
-- 8. Mostrar aquellos pokemon que evolucionan por intercambio.
select * from pokemon p where p.numero_pokedex in (select pfe.numero_pokedex from pokemon_forma_evolucion pfe 
inner join forma_evolucion fe on pfe.id_forma_evolucion=fe.id_forma_evolucion 
inner join tipo_evolucion te on fe.tipo_evolucion=te.id_tipo_evolucion where te.tipo_evolucion='intercambio');
-- 9. Mostrar el nombre del movimiento con más prioridad.
