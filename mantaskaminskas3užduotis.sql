
DROP DATABASE IF EXISTS telekomunikacijos;
CREATE DATABASE telekomunikacijos;
USE telekomunikacijos;

CREATE TABLE Miestas (
    id          INT PRIMARY KEY,
    pavadinimas VARCHAR(50) NOT NULL
);

CREATE TABLE Operatorius (
    id          INT PRIMARY KEY,
    pavadinimas VARCHAR(50) NOT NULL
);

CREATE TABLE InternetoPlanas (
    id             INT PRIMARY KEY,
    pavadinimas    VARCHAR(50) NOT NULL,
    mb_kiekis      INT NOT NULL,
    kaina          DECIMAL(6,2) NOT NULL,
    operatorius_id INT NOT NULL REFERENCES Operatorius(id)
);

CREATE TABLE Planas (
    id                  INT PRIMARY KEY,
    pavadinimas         VARCHAR(50) NOT NULL,
    kaina               DECIMAL(6,2) NOT NULL,
    operatorius_id      INT NOT NULL REFERENCES Operatorius(id),
    interneto_planas_id INT NULL REFERENCES InternetoPlanas(id),
    nemokamos_min_lt    INT NOT NULL
);

CREATE TABLE PapildomaPaslauga (
    id             INT PRIMARY KEY,
    pavadinimas    VARCHAR(50) NOT NULL,
    kaina          DECIMAL(6,2) NOT NULL,
    operatorius_id INT NOT NULL REFERENCES Operatorius(id)
);

CREATE TABLE Zona (
    id          INT PRIMARY KEY,
    pavadinimas VARCHAR(50) NOT NULL
);

CREATE TABLE Valstybe (
    id          INT PRIMARY KEY,
    pavadinimas VARCHAR(50) NOT NULL,
    zona_id     INT NOT NULL REFERENCES Zona(id)
);

-- Skambuciu kaina (EUR/min) is operatoriaus i valstybe
CREATE TABLE Tarifas (
    operatorius_id INT NOT NULL REFERENCES Operatorius(id),
    valstybe_id    INT NOT NULL REFERENCES Valstybe(id),
    minutes_kaina  DECIMAL(6,2) NOT NULL,
    PRIMARY KEY (operatorius_id, valstybe_id)
);

-- Naudotojas = abonentas
CREATE TABLE Naudotojas (
    id         INT PRIMARY KEY,
    vardas     VARCHAR(50) NOT NULL,
    pavarde    VARCHAR(50) NOT NULL,
    miestas_id INT NOT NULL REFERENCES Miestas(id)
);

CREATE TABLE Sutartis (
    id                             INT PRIMARY KEY,
    naudotojas_id                  INT NOT NULL REFERENCES Naudotojas(id),
    planas_id                      INT NOT NULL REFERENCES Planas(id),
    numeris                        VARCHAR(20) NOT NULL,
    sutarties_pradzia              DATE NOT NULL,
    sutarties_pabaiga              DATE NOT NULL,
    papildomas_interneto_planas_id INT NULL REFERENCES InternetoPlanas(id)
);

-- Kokias papildomas paslaugas uzsake sutartis
CREATE TABLE SutartiesPaslauga (
    sutartis_id INT NOT NULL REFERENCES Sutartis(id),
    paslauga_id INT NOT NULL REFERENCES PapildomaPaslauga(id),
    PRIMARY KEY (sutartis_id, paslauga_id)
);

CREATE TABLE Skambutis (
    id          INT PRIMARY KEY,
    sutartis_id INT NOT NULL REFERENCES Sutartis(id),
    valstybe_id INT NOT NULL REFERENCES Valstybe(id),
    pradzia     DATETIME NOT NULL,
    trukme_sek  INT NOT NULL
);

INSERT INTO Miestas VALUES
(1, 'Vilnius'),
(2, 'Kaunas'),
(3, 'Klaipeda'),
(4, 'Siauliai'),
(5, 'Panevezys');

INSERT INTO Operatorius VALUES
(1, 'Telia'),
(2, 'Bite'),
(3, 'Tele2');

INSERT INTO InternetoPlanas VALUES
(1, 'Mini', 1024, 3.0, 1),
(2, 'Vidutinis', 10240, 5.0, 2),
(3, 'Neribotas', 102400, 10.0, 3),
(4, 'Telia Extra 5GB', 5120, 2.5, 1),
(5, 'Bite Naktis 20GB', 20480, 4.0, 2),
(6, 'Tele2 Turbo 50GB', 51200, 6.0, 3);

INSERT INTO Planas VALUES
(1, 'Telia S', 7.99, 1, 1, 50),
(2, 'Telia M', 12.99, 1, 2, 200),
(3, 'Telia Balsas', 4.99, 1, NULL, 100),
(4, 'Bite Smart', 9.99, 2, 2, 150),
(5, 'Bite Max', 19.99, 2, 3, 500),
(6, 'Bite Pokalbiai', 3.99, 2, NULL, 80),
(7, 'Tele2 Basic', 5.99, 3, 1, 100),
(8, 'Tele2 Plus', 14.99, 3, 3, 300);

INSERT INTO PapildomaPaslauga VALUES
(1, 'Roaming paketas', 4.99, 1),
(2, 'Antivirusine', 1.99, 1),
(3, 'TV paslauga', 6.99, 2),
(4, 'Roaming paketas', 3.99, 2),
(5, 'Roaming paketas', 4.49, 3),
(6, 'Muzikos paslauga', 2.99, 3),
(7, 'Antivirusine', 1.49, 3);

INSERT INTO Zona VALUES
(1, 'Lietuva'),
(2, 'Europos Sajunga'),
(3, 'Siaures Amerika'),
(4, 'Azija'),
(5, 'Afrika');

INSERT INTO Valstybe VALUES
(1, 'Lietuva', 1),
(2, 'Latvija', 2),
(3, 'Lenkija', 2),
(4, 'Vokietija', 2),
(5, 'JAV', 3),
(6, 'Kanada', 3),
(7, 'Meksika', 3),
(8, 'Kinija', 4),
(9, 'Japonija', 4);

INSERT INTO Tarifas VALUES
(1, 1, 0.0),
(1, 2, 0.15),
(1, 3, 0.15),
(1, 4, 0.2),
(1, 5, 0.6),
(1, 6, 0.6),
(1, 7, 1.2),
(1, 8, 0.9),
(1, 9, 1.0),
(2, 1, 0.0),
(2, 2, 0.12),
(2, 3, 0.14),
(2, 4, 0.18),
(2, 5, 0.55),
(2, 6, 0.65),
(2, 7, 1.5),
(2, 8, 0.85),
(2, 9, 1.1),
(3, 1, 0.0),
(3, 2, 0.1),
(3, 3, 0.12),
(3, 4, 0.19),
(3, 5, 0.5),
(3, 6, 0.55),
(3, 7, 1.1),
(3, 8, 0.95),
(3, 9, 0.95);

INSERT INTO Naudotojas VALUES
(1, 'Jonas', 'Jonaitis', 1),
(2, 'Ona', 'Onaitiene', 1),
(3, 'Petras', 'Petraitis', 1),
(4, 'Rasa', 'Rasaite', 2),
(5, 'Tomas', 'Tomaitis', 2),
(6, 'Greta', 'Gretaite', 3),
(7, 'Lukas', 'Lukaitis', 1),
(8, 'Ieva', 'Ievaite', 2),
(9, 'Mantas', 'Mantaitis', 3),
(10, 'Egle', 'Eglaite', 1),
(11, 'Paulius', 'Paulaitis', 2),
(12, 'Austeja', 'Austejaite', 1),
(13, 'Darius', 'Dariukas', 3),
(14, 'Laura', 'Lauraite', 2),
(15, 'Karolis', 'Karolaitis', 1);

INSERT INTO Sutartis VALUES
(1, 1, 2, '+37061000000', '2025-01-02', '2027-01-02', NULL),
(2, 2, 5, '+37061007331', '2025-01-03', '2027-01-03', 4),
(3, 3, 7, '+37061014662', '2025-01-05', '2027-01-05', NULL),
(4, 4, 4, '+37061021993', '2025-01-08', '2027-01-08', NULL),
(5, 5, 8, '+37061029324', '2025-01-10', '2027-01-10', 6),
(6, 6, 1, '+37061036655', '2025-01-15', '2027-01-15', NULL),
(7, 7, 2, '+37061043986', '2025-02-01', '2027-02-01', NULL),
(8, 8, 2, '+37061051317', '2025-03-12', '2027-03-12', 5),
(9, 9, 5, '+37061058648', '2025-04-20', '2027-04-20', NULL),
(10, 10, 7, '+37061065979', '2025-05-05', '2027-05-05', NULL),
(11, 11, 4, '+37061073310', '2025-06-18', '2027-06-18', 6),
(12, 12, 8, '+37061080641', '2025-07-01', '2027-07-01', NULL),
(13, 13, 2, '+37061087972', '2025-08-09', '2027-08-09', NULL),
(14, 14, 5, '+37061095303', '2025-09-14', '2027-09-14', 4),
(15, 15, 3, '+37061102634', '2025-09-30', '2027-09-30', NULL);

INSERT INTO SutartiesPaslauga VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 5),
(3, 6),
(5, 5),
(5, 6),
(6, 1),
(9, 3),
(9, 4),
(12, 5),
(15, 1),
(15, 2);

INSERT INTO Skambutis VALUES
(1, 1, 1, '2025-09-11 03:12:00', 291),
(2, 1, 1, '2025-09-23 06:58:00', 764),
(3, 1, 1, '2025-09-10 07:54:00', 568),
(4, 1, 1, '2025-09-08 21:55:00', 42),
(5, 1, 1, '2025-09-03 17:05:00', 248),
(6, 1, 1, '2025-10-16 23:57:00', 584),
(7, 1, 1, '2025-09-19 02:22:00', 728),
(8, 1, 1, '2025-10-20 14:26:00', 469),
(9, 1, 1, '2025-10-24 15:16:00', 900),
(10, 1, 2, '2025-09-01 14:11:00', 442),
(11, 1, 1, '2025-10-01 23:17:00', 230),
(12, 1, 2, '2025-11-27 03:03:00', 399),
(13, 1, 1, '2025-09-09 19:16:00', 362),
(14, 1, 1, '2025-10-25 22:51:00', 54),
(15, 2, 1, '2025-10-19 19:24:00', 397),
(16, 2, 1, '2025-09-08 04:08:00', 859),
(17, 2, 1, '2025-10-28 05:17:00', 892),
(18, 2, 1, '2025-10-03 22:00:00', 731),
(19, 2, 1, '2025-09-07 07:56:00', 243),
(20, 2, 1, '2025-11-10 08:47:00', 91),
(21, 2, 1, '2025-11-17 20:28:00', 113),
(22, 2, 1, '2025-10-05 14:23:00', 660),
(23, 2, 1, '2025-11-15 22:08:00', 389),
(24, 2, 1, '2025-10-03 08:06:00', 283),
(25, 2, 5, '2025-11-03 21:08:00', 633),
(26, 3, 1, '2025-09-16 13:51:00', 260),
(27, 3, 1, '2025-09-15 20:57:00', 286),
(28, 3, 1, '2025-11-24 05:32:00', 580),
(29, 3, 1, '2025-09-20 23:45:00', 873),
(30, 3, 2, '2025-11-09 22:24:00', 42),
(31, 3, 1, '2025-11-13 06:38:00', 284),
(32, 3, 1, '2025-09-07 00:35:00', 590),
(33, 3, 1, '2025-11-19 18:27:00', 227),
(34, 3, 1, '2025-10-30 15:49:00', 668),
(35, 3, 1, '2025-10-12 18:22:00', 152),
(36, 3, 1, '2025-09-23 10:45:00', 561),
(37, 3, 1, '2025-09-24 21:58:00', 448),
(38, 3, 1, '2025-11-21 17:19:00', 380),
(39, 3, 2, '2025-09-20 23:06:00', 515),
(40, 4, 1, '2025-11-08 19:01:00', 122),
(41, 4, 1, '2025-09-14 21:53:00', 821),
(42, 4, 1, '2025-11-01 22:32:00', 75),
(43, 4, 1, '2025-10-06 00:32:00', 489),
(44, 4, 1, '2025-10-19 03:52:00', 576),
(45, 5, 1, '2025-11-01 22:06:00', 708),
(46, 5, 1, '2025-11-20 12:50:00', 283),
(47, 5, 1, '2025-11-09 23:01:00', 124),
(48, 5, 1, '2025-09-27 17:09:00', 474),
(49, 6, 1, '2025-11-26 19:38:00', 746),
(50, 6, 6, '2025-09-24 23:22:00', 529),
(51, 6, 1, '2025-11-23 01:39:00', 650),
(52, 6, 4, '2025-09-28 03:57:00', 213),
(53, 7, 4, '2025-10-05 00:49:00', 807),
(54, 7, 1, '2025-11-23 23:05:00', 10),
(55, 7, 1, '2025-10-25 12:24:00', 29),
(56, 7, 7, '2025-09-11 04:22:00', 861),
(57, 7, 1, '2025-11-13 10:25:00', 69),
(58, 7, 8, '2025-09-22 22:11:00', 97),
(59, 8, 1, '2025-11-14 06:37:00', 788),
(60, 8, 2, '2025-10-19 11:42:00', 496),
(61, 8, 1, '2025-11-26 04:25:00', 281),
(62, 8, 4, '2025-10-19 00:43:00', 226),
(63, 8, 1, '2025-11-24 13:14:00', 757),
(64, 8, 1, '2025-11-02 19:02:00', 329),
(65, 8, 5, '2025-10-07 07:36:00', 458),
(66, 8, 1, '2025-11-21 21:14:00', 133),
(67, 8, 1, '2025-09-23 13:33:00', 356),
(68, 8, 1, '2025-09-02 21:57:00', 245),
(69, 8, 1, '2025-10-24 13:28:00', 82),
(70, 9, 1, '2025-09-06 08:36:00', 42),
(71, 9, 1, '2025-11-18 05:54:00', 536),
(72, 9, 1, '2025-09-22 15:55:00', 507),
(73, 9, 1, '2025-09-20 12:00:00', 750),
(74, 9, 4, '2025-11-25 03:39:00', 258),
(75, 9, 1, '2025-11-11 10:01:00', 426),
(76, 9, 1, '2025-09-18 07:57:00', 684),
(77, 9, 1, '2025-10-10 05:38:00', 430),
(78, 9, 2, '2025-10-13 12:13:00', 679),
(79, 9, 1, '2025-11-29 13:56:00', 72),
(80, 9, 1, '2025-10-07 15:32:00', 829),
(81, 9, 1, '2025-11-18 10:21:00', 206),
(82, 9, 1, '2025-09-18 07:31:00', 153),
(83, 9, 1, '2025-10-09 09:36:00', 483),
(84, 10, 4, '2025-11-19 14:20:00', 892),
(85, 10, 1, '2025-11-17 21:53:00', 61),
(86, 10, 7, '2025-10-30 08:37:00', 105),
(87, 10, 3, '2025-11-24 07:40:00', 426),
(88, 10, 1, '2025-10-15 04:53:00', 895),
(89, 10, 2, '2025-10-07 12:05:00', 12),
(90, 10, 1, '2025-11-29 16:26:00', 812),
(91, 11, 1, '2025-09-26 23:08:00', 758),
(92, 11, 1, '2025-11-11 07:16:00', 745),
(93, 11, 1, '2025-10-15 07:08:00', 313),
(94, 11, 4, '2025-09-20 19:34:00', 565),
(95, 11, 1, '2025-09-06 13:09:00', 68),
(96, 11, 1, '2025-09-05 13:32:00', 524),
(97, 11, 2, '2025-11-23 16:25:00', 530),
(98, 11, 2, '2025-09-08 07:00:00', 79),
(99, 11, 3, '2025-11-01 11:01:00', 593),
(100, 11, 1, '2025-09-23 09:51:00', 50),
(101, 11, 1, '2025-10-27 09:03:00', 683),
(102, 12, 1, '2025-10-22 10:45:00', 277),
(103, 12, 1, '2025-09-19 14:12:00', 331),
(104, 12, 1, '2025-09-22 17:25:00', 144),
(105, 12, 1, '2025-11-01 03:19:00', 478),
(106, 12, 8, '2025-09-29 18:41:00', 19),
(107, 12, 1, '2025-10-12 17:08:00', 586),
(108, 12, 1, '2025-09-10 02:24:00', 228),
(109, 12, 1, '2025-10-17 01:07:00', 367),
(110, 12, 1, '2025-11-20 04:16:00', 260),
(111, 12, 1, '2025-10-04 15:14:00', 458),
(112, 12, 1, '2025-11-15 21:20:00', 319),
(113, 12, 6, '2025-10-26 16:13:00', 551),
(114, 12, 1, '2025-09-01 17:05:00', 577),
(115, 13, 1, '2025-11-24 19:27:00', 147),
(116, 13, 1, '2025-09-25 01:44:00', 119),
(117, 13, 1, '2025-11-07 13:50:00', 288),
(118, 13, 1, '2025-09-26 15:30:00', 744),
(119, 13, 1, '2025-10-02 05:02:00', 659),
(120, 13, 1, '2025-11-17 15:12:00', 510),
(121, 13, 7, '2025-09-23 20:34:00', 104),
(122, 13, 1, '2025-10-28 17:36:00', 293),
(123, 14, 1, '2025-09-01 07:44:00', 143),
(124, 14, 2, '2025-10-28 23:47:00', 462),
(125, 14, 1, '2025-10-21 05:09:00', 584),
(126, 14, 1, '2025-09-01 21:07:00', 717),
(127, 15, 1, '2025-10-20 15:51:00', 388),
(128, 15, 1, '2025-10-24 00:30:00', 450),
(129, 15, 1, '2025-09-12 14:24:00', 383),
(130, 15, 9, '2025-11-21 19:51:00', 50),
(131, 15, 1, '2025-11-21 19:43:00', 708),
(132, 15, 1, '2025-09-23 17:06:00', 372);

-- Mantas Kaminskas, 3 užduotis

-- Parašykite užklausą, nustatančią kokias papildomas paslaugas teikia mobiliojo ryšio operatorius TELE2.
SELECT pp.pavadinimas AS paslauga,
       pp.kaina
FROM PapildomaPaslauga pp
JOIN Operatorius o ON o.id = pp.operatorius_id
WHERE o.pavadinimas = 'Tele2';

-- 2. Parašykite užklausą, išvedančią papildomas paslaugas, kurias siūlo visi mobiliojo ryšio operatoriai.
SELECT o.pavadinimas  AS operatorius,
       pp.pavadinimas AS paslauga,
       pp.kaina
FROM PapildomaPaslauga pp
JOIN Operatorius o ON o.id = pp.operatorius_id
WHERE pp.pavadinimas IN (
    SELECT pavadinimas
    FROM PapildomaPaslauga
    GROUP BY pavadinimas
    HAVING COUNT(DISTINCT operatorius_id) = (SELECT COUNT(*) FROM Operatorius)
)
ORDER BY pp.pavadinimas, o.pavadinimas;

-- 3. Parašykite užklausą, išvedančią kiekvienai zonai priklausančių valstybių skaičių.
SELECT z.pavadinimas AS zona,
       COUNT(v.id)   AS valstybiu_kiekis
FROM Zona z
LEFT JOIN Valstybe v ON v.zona_id = z.id
GROUP BY z.id, z.pavadinimas;

-- 4.Parašykite užklausą, kuri išveda operatoriaus pavadinimą, siūlančio brangiausius skambučius į Meksiką.
SELECT o.pavadinimas AS operatorius,
       t.minutes_kaina
FROM Tarifas t
JOIN Operatorius o ON o.id = t.operatorius_id
JOIN Valstybe v    ON v.id = t.valstybe_id
WHERE v.pavadinimas = 'Meksika'
  AND t.minutes_kaina = (
      SELECT MAX(t2.minutes_kaina)
      FROM Tarifas t2
      JOIN Valstybe v2 ON v2.id = t2.valstybe_id
      WHERE v2.pavadinimas = 'Meksika'
  );

-- 5. ĮParašykite užklausą, kuri nustato interneto planą, neįtrauktą į mokėjimo planą, pagal kurį 1MB kaina yra mažiausia. Užklausa turi išvesti operatoriaus pavadinimą, interneto plano pavadinimą ir 1MB kaina.
SELECT o.pavadinimas                    AS operatorius,
       ip.pavadinimas                   AS interneto_planas,
       ROUND(ip.kaina / ip.mb_kiekis, 6) AS mb_kaina
FROM InternetoPlanas ip
JOIN Operatorius o ON o.id = ip.operatorius_id
WHERE NOT EXISTS (SELECT 1 FROM Planas p WHERE p.interneto_planas_id = ip.id)
  AND ip.kaina / ip.mb_kiekis = (
      SELECT MIN(ip2.kaina / ip2.mb_kiekis)
      FROM InternetoPlanas ip2
      WHERE NOT EXISTS (SELECT 1 FROM Planas p2 WHERE p2.interneto_planas_id = ip2.id)
  );

-- 6. Išveskite procentine išraiška abonentų pasiskirstymą tarp operatorių.
SELECT o.pavadinimas AS operatorius,
       COUNT(s.id)   AS abonentu_kiekis,
       ROUND(COUNT(s.id) * 100.0 / (SELECT COUNT(*) FROM Sutartis), 2) AS procentai
FROM Operatorius o
LEFT JOIN Planas p   ON p.operatorius_id = o.id
LEFT JOIN Sutartis s ON s.planas_id = p.id
GROUP BY o.id, o.pavadinimas
ORDER BY procentai DESC;

-- 7. TOP 3 populiariausi planai (su lygiosiomis)
SELECT plano_pavadinimas, abonentu_kiekis
FROM (
    SELECT p.pavadinimas AS plano_pavadinimas,
           COUNT(s.id)   AS abonentu_kiekis,
           RANK() OVER (ORDER BY COUNT(s.id) DESC) AS vieta
    FROM Planas p
    JOIN Sutartis s ON s.planas_id = p.id
    GROUP BY p.id, p.pavadinimas
) r
WHERE vieta <= 3
ORDER BY abonentu_kiekis DESC;

-- 8. 10 atsitiktinių abonentų informacija
SELECT CONCAT(n.vardas, ' ', n.pavarde) AS pilnas_vardas,
       m.pavadinimas       AS miestas,
       s.numeris,
       s.sutarties_pradzia,
       s.sutarties_pabaiga,
       o.pavadinimas       AS operatorius,
       p.pavadinimas       AS planas,
       CASE WHEN s.papildomas_interneto_planas_id IS NOT NULL
            THEN 'Taip' ELSE 'Ne' END AS papildomas_internetas,
       CASE WHEN EXISTS (SELECT 1 FROM SutartiesPaslauga sp WHERE sp.sutartis_id = s.id)
            THEN 'Taip' ELSE 'Ne' END AS papildomos_paslaugos
FROM Sutartis s
JOIN Naudotojas n  ON n.id = s.naudotojas_id
JOIN Miestas m     ON m.id = n.miestas_id
JOIN Planas p      ON p.id = s.planas_id
JOIN Operatorius o ON o.id = p.operatorius_id
ORDER BY RAND()
LIMIT 10;

-- 9. TOP 5 abonentai pagal skambučių kiekį Lietuvoje 2025 m. spalį
SELECT CONCAT(n.vardas, ' ', n.pavarde) AS abonentas,
       s.numeris,
       COUNT(sk.id) AS skambuciu_kiekis
FROM Skambutis sk
JOIN Sutartis s   ON s.id = sk.sutartis_id
JOIN Naudotojas n ON n.id = s.naudotojas_id
JOIN Valstybe v   ON v.id = sk.valstybe_id
WHERE v.pavadinimas = 'Lietuva'
  AND sk.pradzia >= '2025-10-01'
  AND sk.pradzia <  '2025-11-01'
GROUP BY s.id, n.vardas, n.pavarde, s.numeris
ORDER BY skambuciu_kiekis DESC
LIMIT 5;

-- 10. Populiariausia užsienio šalis pagal skambučių kiekį (su lygiosiomis)
SELECT v.pavadinimas AS salis,
       COUNT(sk.id)  AS skambuciu_kiekis
FROM Skambutis sk
JOIN Valstybe v ON v.id = sk.valstybe_id
WHERE v.pavadinimas <> 'Lietuva'
GROUP BY v.id, v.pavadinimas
HAVING COUNT(sk.id) = (
    SELECT MAX(kiekis)
    FROM (
        SELECT COUNT(*) AS kiekis
        FROM Skambutis sk2
        JOIN Valstybe v2 ON v2.id = sk2.valstybe_id
        WHERE v2.pavadinimas <> 'Lietuva'
        GROUP BY sk2.valstybe_id
    ) x
);





