
--CREATING DATA BASE:
CREATE DATABASE "pokémonCenterDB"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LOCALE_PROVIDER = 'libc'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
	
--CREATING TABLES: 
--1.	TRAINERS
CREATE TABLE public.trainers
(
    tranerid serial NOT NULL,
    trainername text NOT NULL,
    trainertown text NOT NULL,
    PRIMARY KEY (tranerid)
);
ALTER TABLE IF EXISTS public.trainers
    OWNER to postgres;
	
--2.	POKÉMONS
CREATE TABLE public.pokemons
(
    pokemonid serial NOT NULL,
    pokemonname text NOT NULL,
    pokemontype1 text NOT NULL,
    pokemongender text NOT NULL,
    PRIMARY KEY (pokemonid)
);
ALTER TABLE IF EXISTS public.pokemons
    OWNER to postgres;
	
--3.	NURSES
CREATE TABLE public.nurses
(
    nurseid serial NOT NULL,
    nursename text NOT NULL,
    PRIMARY KEY (nurseid)
);
ALTER TABLE IF EXISTS public.nurses
    OWNER to postgres;

--4.	POKEMON-TRAINER DETAILS
CREATE TABLE public.pokemontrainerdetails
(
    pokemonid int NOT NULL,
    trainerid int NOT NULL,
    PRIMARY KEY (pokemonid),
    FOREIGN KEY (pokemonid)
        REFERENCES public.pokemons (pokemonid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    FOREIGN KEY (trainerid)
        REFERENCES public.trainers (tranerid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);
ALTER TABLE IF EXISTS public.pokemontrainerdetails
    OWNER to postgres;

--5.	POKEMON TYPE DETAILS
CREATE TABLE public.pokemontypedetails
(
    pokemonid int NOT NULL,
    pokemontype2 text NOT NULL,
    PRIMARY KEY (pokemonid),
    FOREIGN KEY (pokemonid)
        REFERENCES public.pokemons (pokemonid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);
ALTER TABLE IF EXISTS public.pokemontypedetails
    OWNER to postgres;

--6.	POKEMON REGISTRATION (with an error)
CREATE TABLE public.pokemonregistrations
(
    pokemonregistrationid serial NOT NULL,
    pokemonentrydate date NOT NULL,
    pokemonid integer NOT NULL,
    trainerid integer NOT NULL,
    nurseid integer NOT NULL,
    pokemondeparturedate date NOT NULL,
    PRIMARY KEY (pokemonregistrationid),
    FOREIGN KEY (pokemonid)
        REFERENCES public.pokemons (pokemonid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    FOREIGN KEY (trainerid)
        REFERENCES public.trainers (tranerid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    FOREIGN KEY (nurseid)
        REFERENCES public.nurses (nurseid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);
ALTER TABLE IF EXISTS public.pokemonregistrations
    OWNER to postgres;
	
--7. SECURITY GUARDS (Irrelevant table)
CREATE TABLE public.securityguards
(
    securityguardid serial NOT NULL,
    securityguardname text NOT NULL,
    PRIMARY KEY (securityguardid)
);
ALTER TABLE IF EXISTS public.securityguards
    OWNER to postgres;

--INSERTING DATA:
--NURSES:
INSERT INTO public.nurses(
	nursename)
	VALUES ('Liz'),
	('Joy'),
	('Dalia'),
	('Ada'),
	('Nao');
	
--TRAINERS:
INSERT INTO public.trainers(
	trainername, trainertown)
	VALUES ('Angie', 'Lavander'),
	('Ash', 'Pallet'),
	('Brock', 'Pewter'),
	('Jessie', 'Kanto'),
	('James', 'Kanto'),
	('Iris', 'Opelucid'),
	('May', 'Petalburg'),
	('Red', 'Pallet'),
	('Mallow', 'Konikoni'),
	('Kiawe', 'Paniola');
	
--POKÉMONS (with grammatical errors):
INSERT INTO public.pokemons(
	pokemonname, pokemontype1, pokemongender)
	VALUES ('Pikachu', 'ELectric', 'Male'),
	('Charizard', 'Fire', 'Male'),
	('Bulbasaur', 'Grass', 'Female'),
	('Squirtle', 'Water', 'MAle'),
	('Jigglypuff', 'Normal', 'Female'),
	('Snorlax', 'Normal', 'Male'),
	('Mewtwo', 'Psychic', 'Female'),
	('Gengar', 'Ghost', 'Male'),
	('Eeve', 'Normal', 'Female'),
	('Dragonite', 'Dragon', 'Female'),
	('Lucario', 'Fighting', 'Male'),
	('Gyarados', 'Water', 'Male'),
	('Blastoise', 'Water', 'Male'),
	('Alakazam', 'Psychic', 'Female'),
	('Machamp', 'Fighting', 'Male'),
	('Arcanine', 'Fire', 'Male'),
	('Gardevoir', 'Psychic', 'Female'),
	('Tyranitar', 'Rock', 'Male'),
	('Salamence', 'Dragon', 'Male'),
	('Greninja', 'Wate', 'Male');

--POKÉMON TYPE DETAILS:
INSERT INTO public.pokemontypedetails(
	pokemonid, pokemontype2)
	VALUES (2, 'Flying'),
	(3, 'Poison'),
	(5, 'Fairy'),
	(8, 'Poison'),
	(10, 'Flying'),
	(11, 'Steel'),
	(12, 'Flying'),
	(17, 'Fairy'),
	(18, 'Dark'),
	(19, 'Flying'),
	(20, 'Dark');

--POKÉMON-TRAINER DETAILS:
INSERT INTO public.pokemontrainerdetails(
	pokemonid, trainerid)
	VALUES (1, 2),
	(2, 2),
	(3, 8),
	(4, 9),
	(5, 1),
	(6, 3),
	(7, 1),
	(8, 4),
	(9, 1),
	(10, 7),
	(11, 5),
	(12, 9),
	(13, 10),
	(14, 10),
	(15, 1),
	(16, 5),
	(17, 6),
	(18, 7),
	(19, 6),
	(20, 8);

--POKÉMON REGISTRATIONS:
INSERT INTO public.pokemonregistrations(
	pokemonentrydate, pokemonid, trainerid, nurseid, pokemondeparturedate)
	VALUES ('2024/01/01', 1, 2, 4, '2024/01/02'),
	('2024/01/01', 2, 2, 3, '2024/01/02'),
	('2024/01/06', 3, 8, 5, '2024/01/07'),
	('2024/01/10', 4, 9, 2, '2024/01/11'),
	('2024/01/15', 5, 1, 2, '2024/01/16'),
	('2024/01/23', 6, 3, 1, '2024/01/24'),
	('2024/01/25', 7, 1, 2, '2024/01/26'),
	('2024/01/30', 8, 4, 4, '2024/01/31'),
	('2024/02/03', 9, 1, 5, '2024/02/04'),
	('2024/02/08', 10, 7, 3, '2024/02/09'),
	('2024/02/11', 11, 5, 2, '2024/02/12'),
	('2024/02/20', 12, 9, 3, '2024/02/21'),
	('2024/02/24', 13, 10, 5, '2024/02/25'),
	('2024/02/28', 14, 10, 4, '2024/02/29'),
	('2024/03/01', 15, 1, 1, '2024/03/02'),
	('2024/03/05', 16, 5, 1, '2024/03/06'),
	('2024/03/12', 17, 6, 2, '2024/03/13'),
	('2024/03/18', 18, 7, 3, '2024/03/19'),
	('2024/03/22', 19, 6, 4, '2024/03/23'),
	('2024/03/29', 20, 8, 5, '2024/03/30');
	
--TABLE MODIFICATIONS:
ALTER TABLE pokemonregistrations DROP COLUMN trainerid;
DROP TABLE securityguards;
UPDATE pokemons SET pokemontype1 = 'Electric' WHERE pokemonid = 1;
UPDATE pokemons SET pokemongender = 'Male' WHERE pokemonid = 4;
UPDATE pokemons SET pokemontype1 = 'Water' WHERE pokemonid = 20;
DELETE FROM pokemonregistrations WHERE pokemonregistrationid = 8;
DELETE FROM pokemonregistrations WHERE pokemonregistrationid = 19;

--SIMPLE CONSULTATIONS:
SELECT * FROM trainers;
SELECT * FROM nurses;
SELECT * FROM pokemons;
SELECT * FROM pokemontypedetails;
SELECT * FROM pokemontrainerdetails;
SELECT * FROM pokemonregistrations;
SELECT pokemonid, nurseid FROM pokemonregistrations;
SELECT pokemonname, pokemontype1 FROM pokemons;
SELECT * FROM pokemonregistrations WHERE nurseid = 3;
SELECT * FROM pokemons WHERE pokemontype1 = 'Normal' AND pokemongender = 'Female';
SELECT * FROM pokemons WHERE pokemontype1 = 'Psychic' OR pokemongender = 'Female';
SELECT * FROM pokemontrainerdetails ORDER BY trainerid DESC;
SELECT * FROM pokemontrainerdetails ORDER BY trainerid ASC;
SELECT * FROM pokemonregistrations ORDER BY pokemonentrydate LIMIT 3;
SELECT * FROM pokemons OFFSET 5;
SELECT pokemonid FROM pokemonregistrations GROUP BY pokemonid;
