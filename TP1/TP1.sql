--QUESTION 1
CREATE TABLE VILLE(
    ID_VILLE VARCHAR2 PRIMARY KEY,
    XMIN INTEGER NOT NULL,
    XMAX INTEGER NOT NULL,
    YMIN INTEGER NOT NULL,
    YMAX INTEGER NOT NULL
);
CREATE TABLE PILOTE(
    PLNUM INTEGER PRIMARY KEY,
    PLNOM VARCHAR2(50) NOT NULL,
    PLPRENOM VARCHAR2(50) NOT NULL,
    SALAIRE INTEGER NOT NULL,
    ID_VILLE INTEGER NOT NULL,
    FOREIGN KEY (ID_VILLE) REFERENCES VILLE(ID_VILLE)
);
CREATE TABLE AVION(
    AV_NUM INTEGER PRIMARY KEY,
    AVNOM VARCHAR2(50) NOT NULL,
    LOCALISATION VARCHAR2(50) NOT NULL,
    CAPACITE INTEGER NOT NULL,
    FOREIGN KEY (LOCALISATION) REFERENCES VILLE(ID_VILLE)
);
CREATE TABLE AGENCE(
    CODE VARCHAR2 PRIMARY KEY,
    VILLE VARCHAR2 NOT NULL,
    FOREIGN KEY (VILLE) REFERENCES VILLE(ID_VILLE)
)
CREATE TABLE VOL2(
    VOLNUM INTEGER PRIMARY KEY,
    PLNUM INTEGER NOT NULL,
    AV_NUM INTEGER NOT NULL,
    VILLEDEP VARCHAR2(50) NOT NULL,
    VILLEARR VARCHAR2(50) NOT NULL,
    HEUREDEP DATE NOT NULL,
    HEUREARR DATE NOT NULL,
    FOREIGN KEY (PLNUM) REFERENCES PILOTE(PLNUM),
    FOREIGN KEY (AV_NUM) REFERENCES AVION(AV_NUM),
    FOREIGN KEY (VILLEDEP) REFERENCES VILLE(ID_VILLE),
    FOREIGN KEY (VILLEARR) REFERENCES VILLE(ID_VILLE)
);
-- QUESTION 2
INSERT INTO VILLE (ID_VILLE, XMIN, XMAX, YMIN, YMAX)
VALUES
('Dijon', 8950, 9180, 4840, 5050), -- Dijon
('Lyon', 8820, 9080, 7020, 7230), -- Lyon
('Paris', 6310, 6560, 2940, 3110), -- Paris
('Marseille', 9660, 9930, 10350, 10580), -- Marseille
('Nantes', 2730, 2970, 5320, 5540); -- Nantes

INSERT INTO PILOTE (PLNUM, PLNOM, PLPRENOM, SALAIRE, ID_VILLE)
VALUES
(1, 'Solomon', 'Asres', 21000, 'Paris'), -- Paris
(2, 'Barth', 'Florie', 21000, 'Lyon'), -- Toulouse (remplacer par l'identifiant de Toulouse si dans VILLE)
(3, 'Nicolle', 'Xavier', 18000, 'Dijon'), -- Nice (remplacer par l'identifiant de Nice si dans VILLE)
(4, 'Dupont', 'Nicolas', 17000, 'Paris'); -- Paris

INSERT INTO AVION (AV_NUM, AVNOM, LOCALISATION, CAPACITE)
VALUES
(1, 'A300', 'Paris', 300), -- Nice (remplacer par l'identifiant de Nice si dans VILLE)
(2, 'A310', 'Paris', 300), -- Nice
(3, 'B707', 'Paris', 250), -- Paris
(4, 'A300', 'Lyon', 280); -- Lyon

INSERT INTO AGENCE (CODE, VILLE)
VALUES
('AG001', 'Paris'), -- Paris
('AG002', 'Paris'), -- Nice
('AG003', 'Paris'), -- Nice
('AG004', 'Lyon'); -- Lyon

INSERT INTO VOL2 (VOLNUM, PLNUM, AV_NUM, VILLEDEP, VILLEARR, HEUREDEP, HEUREARR)
VALUES
(1, 1, 1, 'Paris', 'Lyon', TO_DATE('11:00', 'HH24:MI'), TO_DATE('12:00', 'HH24:MI')), -- Nice -> Toulouse
(2, 2, 1, 'Paris', 'Paris', TO_DATE('17:00', 'HH24:MI'), TO_DATE('18:00', 'HH24:MI')), -- Paris -> Toulouse
(3, 3, 2, 'Lyon', 'Lyon', TO_DATE('14:00', 'HH24:MI'), TO_DATE('16:00', 'HH24:MI')), -- Toulouse -> Lyon
(4, 3, 3, 'Lyon', 'Paris', TO_DATE('18:00', 'HH24:MI'), TO_DATE('20:00', 'HH24:MI')), -- Toulouse -> Paris
(5, 4, 3, 'Paris', 'Paris', TO_DATE('06:00', 'HH24:MI'), TO_DATE('08:00', 'HH24:MI')); -- Paris -> Nice
-- QUESTION 3
RENAME TABLE VOL2 TO TRAJETS;
RENAME TABLE PILOTE TO PERSONNEL;

--QUESTION 4
UPDATE TRAJETS SET VILLEARR = "Lille", HEUREARR = TO_DATE('17:00', 'HH24:MI') WHERE VOLNUM = 4;

--QUESTION 5 
DELETE FROM TRAJETS WHERE VOLNUM = 5;

--QUESTION 6

ALTER TABLE PERSONNEL
ADD FONCTION VARCHAR(50) DEFAULT 'pilote';

UPDATE PERSONNEL
SET FONCTION = 'pilote';

--PARTIE 2

--QUESTION 1
DESCRIBE TRAJETS;

--QUESTION 2
SELECT * FROM TRAJETS;

--QUESTION 3
SELECT PLNOM AS Nom, PLPRENOM AS Prenom, SALAIRE AS Salaire FROM PERSONNEL
ORDER BY Nom, Prenom;

--QUESTION 4
SELECT PLNOM AS Nom, PLPRENOM AS Prenom, SALAIRE AS Salaire FROM PERSONNEL
WHERE SALAIRE > 20000;

--QUESTION 5
SELECT PLNOM AS Nom, PLPRENOM AS Prenom, SALAIRE AS Salaire FROM PERSONNEL
WHERE SALAIRE ANY(10000, 20000);

--QUESTION 6
SELECT PLNOM AS Nom, PLPRENOM AS Prenom, SALAIRE AS Salaire FROM PERSONNEL
WHERE SALAIRE > AVG(SALAIRE);

--QUESTION 7
SELECT AVNUM, AVNOM FROM AVION
WHERE LOCALISATION = "Paris";

--QUESTION 8
SELECT PLNOM AS Nom, PLPRENOM AS Prenom, SALAIRE AS Salaire FROM PERSONNEL
WHERE SALAIRE > &valeur_à_saisir;

--QUESTION 9
SELECT AVNUM, AVNOM, CAPACITE, LOCALISATION FROM AVION
WHERE LOCALISATION = (SELECT PLNOM FROM PERSONNEL WHERE PLNUM = &valeur_à_saisir);