CREATE TABLE EMP (
    NUMEMP NUMBER PRIMARY KEY,
    NOMCOMPLET VARCHAR2(100),
    PROFESSION VARCHAR2(100),
    CHEF NUMBER,
    SALAIRE NUMBER,
    NUMDEP NUMBER,
    CONSTRAINT fk_numdep FOREIGN KEY (NUMDEP) REFERENCES DEPT(NUMDEP)
);


CREATE TABLE DEPT (
NUMDEP NUMBER PRIMARY KEY,
NOMDEP VARCHAR2(100),
NOMLOC VARCHAR2(100));

-- Insertion des données dans DEPT
INSERT INTO DEPT VALUES (1, 'RECHERCHE', 'DIJON');
INSERT INTO DEPT VALUES (2, 'DEVELOPPEMENT', 'NEW-YORK');
INSERT INTO DEPT VALUES (3, 'FACTURATION', 'PARIS');
INSERT INTO DEPT VALUES (4, 'DIRECTION', 'LONDRES');

-- Insertion des données dans EMP
INSERT INTO EMP VALUES (1, 'BARTH Florent', 'CHEF DE PROJET', 3, 13000, 2);
INSERT INTO EMP VALUES (2, 'XAVIER Richard', 'CHERCHEUR', 3, 21000, 1);
INSERT INTO EMP VALUES (3, 'NICOLLE Chris', 'CHERCHEUR', NULL, 25000, 1);
INSERT INTO EMP VALUES (4, 'BLAKE John', 'DEVELOPPEUR', 6, 8000, 2);
INSERT INTO EMP VALUES (5, 'DUPONT Jean', 'DEVELOPPEUR', 3, 9000, 2);
INSERT INTO EMP VALUES (6, 'MARTIN Alexandre', 'COMPTABLE', 3, 10000, 3);
INSERT INTO EMP VALUES (7, 'RAY Benjamin', 'COMPTABLE', 3, 10000, 3);
INSERT INTO EMP VALUES (8, 'MILLER Pascal', 'DEVELOPPEUR', 3, 9000, 2);
INSERT INTO EMP VALUES (9, 'FORD John', 'DIRECTEUR', 3, 30000, 4);

--Augmenter tout les salaires des employés de 50 : 
DECLARE
	--Déclrarer une variable n
	n NUMBER(2);
	--Déclaration d'un curseur 
	CURSOR employes IS SELECT numemp, nomcomplet, salaire FROM EMP;
	--
	Newsal emp.salaire%TYPE;
	--Créer une exception 
	Empv EXCEPTION;
BEGIN
	--affecter à n le nombre de lignes de la table emp
	SELECT COUNT(*) INTO n FROM EMP;
	--Conditions pour n=0
	IF n=0 THEN
		--Levé l'exception si la condition précédente est vraie
		RAISE empv;
	END IF;
	--Création de la boucle qui va parcourir la table emp avec le curseur
	FOR employe in employes LOOP
		--Affectation à la variable Newsal le salaire actuel + 50
		newsal:=employe.salaire+50;
		--Mise à jour de la table pour chaque nouveau salaire
		UPDATE EMP SET SALAIRE=newsal where NUMEMP = employe.numemp;
	END LOOP;
	Commit;
--initialisation de l'exception
EXCEPTION
	--définition de ceque fais l'exception 
	WHEN empv THEN dbms_output.put_line('Message derreur');
END;

--Afficher tout les salaires des employés avec leurs nom complet

DECLARE
	--

	CURSOR employes IS SELECT nomcomplet, salaire FROM EMP;
	--
	Empv EXCEPTION;
BEGIN
	--
	FOR employe in employes LOOP
		--
		dbms_output.put_line(employe.nomcomplet || ' - ' || employe.salaire);
		--
	END LOOP;
	Commit;
--
EXCEPTION
	--
	WHEN empv THEN dbms_output.put_line('Message derreur');
DECLARE
	--Déclrarer une variable n
	n NUMBER(2);
	--Déclaration d'un curseur 
	CURSOR employes IS SELECT numemp, nomcomplet, salaire FROM EMP;
	--
	Newsal emp.salaire%TYPE;
	--Créer une exception 
	Empv EXCEPTION;
BEGIN
	--affecter à n le nombre de lignes de la table emp
	SELECT COUNT(*) INTO n FROM EMP;
	--Conditions pour n=0
	IF n=0 THEN
		--Levé l'exception si la condition précédente est vraie
		RAISE empv;
	END IF;
	--Création de la boucle qui va parcourir la table emp avec le curseur
	FOR employe in employes LOOP
		--Affectation à la variable Newsal le salaire actuel + 50
		newsal:=employe.salaire+50;
    DBMS_OUTPUT.put_line(employe.salaire-50 || employe.salaire+50);
		--Mise à jour de la table pour chaque nouveau salaire
		UPDATE EMP SET SALAIRE=newsal where NUMEMP = employe.numemp;
	END LOOP;
	Commit;
--initialisation de l'exception
EXCEPTION
	--définition de ceque fais l'exception 
	WHEN empv THEN dbms_output.put_line('Message derreur');
END;
END;

--Augmenter tout les salaires des employés de 50 et afficher le salaire avant et après : 
DECLARE
	--Déclrarer une variable n
	n NUMBER(2);
	--Déclaration d'un curseur 
	CURSOR employes IS SELECT numemp, nomcomplet, salaire FROM EMP;
	--
	Newsal emp.salaire%TYPE;
	--Créer une exception 
	Empv EXCEPTION;
BEGIN
	--affecter à n le nombre de lignes de la table emp
	SELECT COUNT(*) INTO n FROM EMP;
	--Conditions pour n=0
	IF n=0 THEN
		--Levé l'exception si la condition précédente est vraie
		RAISE empv;
	END IF;
	--Création de la boucle qui va parcourir la table emp avec le curseur
	FOR employe in employes LOOP
		--Affectation à la variable Newsal le salaire actuel + 50
    If employe=null Then
      dbms_output.put_line('Pas d employes dans la table');
    End If;
		newsal:=employe.salaire+50;
    DBMS_OUTPUT.put_line('L enmploye : ' || employe.nomcomplet || ' avait comme salaire : ' || employe.salaire || ' et a maintenant pour salaire : ' || newsal);
    
		--Mise à jour de la table pour chaque nouveau salaire
		UPDATE EMP SET SALAIRE=newsal where NUMEMP = employe.numemp;
	END LOOP;
	Commit;
--initialisation de l'exception
EXCEPTION
	--définition de ceque f ais l'exception 
	WHEN empv THEN dbms_output.put_line('Message derreur');
END;


CREATE OR REPLACE PROCEDURE helloWorld() AS
  message VARCHAR2(50);
BEGIN
  message = 'Hello World';
  dbms_output.put_line(message);
END;
set serveroutput on


CREATE OR REPLACE FUNCTION salaire_emp(nom VARCHAR2)
RETURN NUMBER IS
salaireV  EMP.SALAIRE%TYPE;
BEGIN 
  SELECT salaire INTO salaireV FROM EMP
  WHERE nomComplet=nom;
  
  RETURN salaireV;
EXCEPTION
  WHEN NO_DATA_FOUND Then
    dbms_output.put_line('Ca nexiste pas');
    RETURN NULL;
END;



SET SERVEROUTPUT ON;

BEGIN

  SYS.DBMS_OUTPUT.PUT_LINE(salaire_emp('BARTH Florent'));
END;

/

CREATE OR REPLACE PROCEDURE affecter_emp_dept(nomEmp VARCHAR2, idDept NUMBER)IS
  BEGIN
    UPDATE EMP SET NUMDEP = idDept WHERE nomComplet=nomEmp;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE(idDept);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('Employé non trouvé');
END;

BEGIN
 AFFECTER_EMP_DEPT('BARTH Floren',9);
END;

CREATE OR REPLACE FUNCTION exist_emp(nomEmp VARCHAR2) RETURN BOOLEAN IS
IDEMP EMP.NUMEMP%type;
BEGIN
  SELECT NUMEMP INTO IDEMP FROM EMP
  WHERE NOMCOMPLET=nomEmp;
  RETURN TRUE;
EXCEPTION
  WHEN NO_DATA_FOUND THEN 
    RETURN FALSE;
END;

BEGIN
  if EXIST_EMP('BARTH Florent') then
    SYS.DBMS_OUTPUT.PUT_LINE('true');
  else
    SYS.DBMS_OUTPUT.PUT_LINE('false');
  end if;
END;


CREATE OR REPLACE FUNCTION app_demp_dept(nomEmp VARCHAR2, deptEmp NUMBER) RETURN VARCHAR2 IS
phrase EMP.NOMCOMPLET%TYPE;
IDEMP EMP.NUMEMP%TYPE;
BEGIN 
SELECT NUMDEP INTO IDEMP FROM EMP
WHERE nomEmp = NOMCOMPLET;
IF deptEmp = IDEMP  then
  phrase := 'Lemployé fait partie du département ';
ELSE 
  phrase := 'Lemployé ne fait pas partie du département ';
END IF;
RETURN phrase;
EXCEPTION
 WHEN NO_DATA_FOUND Then
  dbms_output.put_line('Valeur non trouvée');
END;

BEGIN

  SYS.DBMS_OUTPUT.PUT_LINE(APP_DEMP_DEPT('BARTH Florent',3));
END;








