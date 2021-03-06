-- ======================================================================
PROMPT ******************** Table : ELEVES ******************************                                            
-- ======================================================================
PROMPT

create table ELEVES
(
    NUM_ELEVE       Number (4),
    NOM             VARCHAR2(25),
    PRENOM          VARCHAR2(25),
    DATE_NAISSANCE  DATE,
    POIDS           Number,
    ANNEE           Number,
    SEXE        Char(1),
    CONSTRAINT PK_ELEVES           PRIMARY KEY(NUM_ELEVE),
    CONSTRAINT NN_ELEVE_NOM        CHECK(NOM IS NOT NULL),
    CONSTRAINT NN_ELEVE_PRENOM     CHECK(PRENOM IS NOT NULL)
);

-- =======================================================================
PROMPT ******************** Table : COURS ********************************                                          
-- =======================================================================
PROMPT

create table COURS
(
    NUM_COURS       Number(2),
    NOM             VARCHAR2(20),
    NBHEURES        Number(2),
    ANNEE           Number(1),
    CONSTRAINT PK_COURS            PRIMARY KEY(NUM_COURS),
    CONSTRAINT NN_COURS_NOM        CHECK(NOM IS NOT NULL)
);

PROMPT
pause Tapez sur Enter...
PROMPT

-- =======================================================================
PROMPT ******************* Table : PROFESSEURS ***************************                                      
-- =======================================================================
PROMPT

create table PROFESSEURS
(
    NUM_PROF        Number(4),
    NOM             VARCHAR2(25),
    SPECIALITE      VARCHAR2(20),
    DATE_ENTREE     DATE,
    DER_PROM        DATE,
    SALAIRE_BASE    Number,
    SALAIRE_ACTUEL  Number,
    CONSTRAINT PK_PROFESSEURS         PRIMARY KEY(NUM_PROF),
    CONSTRAINT NN_PROFESSEURS_NOM     CHECK(NOM IS NOT NULL)
);

PROMPT
pause Tapez sur Enter...
PROMPT

-- =======================================================================
PROMPT ******************** Table : ACTIVITES ****************************                                        
-- =======================================================================
PROMPT

create table ACTIVITES
(
    NIVEAU          Number(1),
    NOM             VARCHAR2(20),
    EQUIPE          VARCHAR2(32),
    CONSTRAINT PK_ACTIVITES        PRIMARY KEY(NIVEAU, NOM)
);

PROMPT
pause Tapez sur Enter...
PROMPT

-- =======================================================================
PROMPT ********************* Table : RESULTATS ***************************                                        
-- =======================================================================
PROMPT

create table RESULTATS
(
    NUM_ELEVE       Number(4),
    NUM_COURS       Number(4),
    POINTS          Number,
    CONSTRAINT PK_RESULTATS                     PRIMARY KEY(NUM_ELEVE, NUM_COURS)
);

PROMPT
pause Tapez sur Enter...
PROMPT

-- =======================================================================
PROMPT ********************* Table : CHARGE ******************************                                          
-- =======================================================================
PROMPT

create table CHARGE
(
    NUM_PROF       Number(4) NOT NULL,
    NUM_COURS      Number(4) NOT NULL,
    CONSTRAINT PK_CHARGE                    PRIMARY KEY(NUM_COURS, NUM_PROF)
);

PROMPT
pause Tapez sur Enter...
PROMPT

-- =======================================================================
PROMPT ****************** Table : ACTIVITES_PRATIQUEES *******************                            
-- =======================================================================
PROMPT

create table ACTIVITES_PRATIQUEES
(
    NUM_ELEVE       Number(4),
    NIVEAU          Number(1),
    NOM             VARCHAR2(20),
    CONSTRAINT PK_ACTIVITES_PRATIQUEES         PRIMARY KEY(NUM_ELEVE, NIVEAU, NOM)
);

ALTER TABLE RESULTATS
   ADD FOREIGN KEY (Num_Eleve) REFERENCES Eleves (num_eleve);
ALTER TABLE RESULTATS
   ADD FOREIGN KEY (Num_Cours) REFERENCES Cours (num_cours);
ALTER TABLE Charge
   ADD FOREIGN KEY (num_prof) REFERENCES Professeurs (num_prof);
ALTER TABLE Charge
   ADD FOREIGN KEY (num_cours) REFERENCES Cours (num_cours);
ALTER TABLE Activites_pratiquees
   ADD FOREIGN KEY (niveau,nom) REFERENCES Activites (niveau,nom);
ALTER TABLE Activites_pratiquees
   ADD FOREIGN KEY (num_eleve) REFERENCES Eleves (num_eleve);

PROMPT
pause Tapez sur Enter...
PROMPT


REM ***********************************************************************
PROMPT ************************ Creation des donnees **********************
REM ***********************************************************************
PROMPT

SELECT 'Creation des donnees' FROM DUAL;
SELECT 'Tapez sur RETURN 'FROM DUAL;
PAUSE


Insert into eleves (Num_eleve, nom, prenom, date_naissance, Poids, annee, sexe)
Values (1, 'Brisefer', 'Benoit', '10-DEC-1974', 35,1, 'M') ;

Insert into eleves (Num_eleve, nom, prenom, date_naissance, Poids, annee, sexe)
Values (2, 'G????nial', 'Olivier', '10-APR-1978', 42, 1, 'M') ;

Insert into eleves (num_eleve, nom, prenom, date_naissance, Poids, annee, sexe)
Values (3, 'Jourdan', 'Gil', '28-06-1974', 72, 2, 'F') ;

Insert into eleves (num_eleve, nom, prenom, date_naissance, Poids, annee, sexe)
Values (4, 'Spring', 'Jerry', '16-FEB-1974', 78, 2, 'M') ;

Insert into eleves (num_eleve, nom, prenom, date_naissance, Poids, annee, sexe)
Values (5, 'Tsuno', 'Yoko', '29-NOV-1977', 45, 1, 'F') ;

Insert into eleves (num_eleve, nom, prenom, date_naissance, Poids, annee, sexe)
Values (6, 'Lebut', 'Marc', '29-APR-1974', 75,2, 'M') ;

Insert into eleves (num_eleve, nom, prenom, date_naissance, Poids, annee, sexe)
Values (7, 'Lagaffe', 'Gaston', '08-APR-1975', 61,1, 'M') ;

Insert into eleves (num_eleve, nom, prenom, date_naissance, Poids, annee, sexe)
Values (8, 'Dubois', 'Robin', '20-APR-1976', 60, 2, 'M') ;

Insert into eleves (num_eleve, nom, prenom, date_naissance, Poids, annee, sexe)
Values (9, 'Walth????ry', 'Natacha', '07-SEP-1977', 59,1, 'F') ;

Insert into eleves (num_eleve, nom, prenom, date_naissance, Poids, annee, sexe)
Values (10, 'Danny', 'Buck', '15-FEB-1973', 82, 2, 'M') ;


Insert into cours (Num_cours, Nom, Nbheures, annee)
Values (1, 'R????seau', 15, 1);

Insert into cours (Num_cours, Nom, Nbheures, annee)
Values (2, 'Sgbd', 30, 1) ;

Insert into cours (Num_cours, Nom, Nbheures, annee)
Values (3, 'Programmation', 15,1) ;

Insert into cours (Num_cours, Nom, Nbheures, annee)
Values (4, 'Sgbd', 30,2 ) ;

Insert into cours (Num_cours, Nom, Nbheures, annee)
Values (5, 'Analyse', 60,2) ;


Insert into PROFESSEURS (Num_prof, nom , specialite, Date_entree, Der_prom, Salaire_base, Salaire_actuel)
Values(1, 'Bottle', 'po????sie', '01-OCT-1970', '01-OCT-1988', 2000000, 2600000) ;

Insert into PROFESSEURS (Num_prof, nom , specialite, Date_entree, Der_prom, Salaire_base, Salaire_actuel)
Values(2, 'Bolenov', 'r????seau', '15-NOV-1968', '01-OCT-1998', 1900000, 2468000) ;

Insert into PROFESSEURS (Num_prof, nom , specialite, Date_entree, Der_prom, Salaire_base, Salaire_actuel)
Values(3, 'Tonilaclasse', 'poo', '01-OCT-1979', '01-JAN-1989', 1900000, 2360000) ;

Insert into PROFESSEURS (Num_prof, nom , specialite, Date_entree, Der_prom, Salaire_base, Salaire_actuel)
Values(4, 'Pastecnov', 'sql', '01-OCT-1975', '', 2500000, 2500000) ;

Insert into PROFESSEURS (Num_prof, nom , specialite, Date_entree, Der_prom, Salaire_base, Salaire_actuel)
Values(5, 'Selector', 'sql', '15-OCT-1982', '01-OCT-1988', 1900000, 1900000) ;

Insert into PROFESSEURS (Num_prof, nom , specialite, Date_entree, Der_prom, Salaire_base, Salaire_actuel)
Values(6, 'Vilplusplus', 'poo', '25-APR-1990', '05-JUL-1994', 1900000, 2200000) ;

Insert into PROFESSEURS (Num_prof, nom , specialite, Date_entree, Der_prom, Salaire_base, Salaire_actuel)
Values(7, 'Francesca', '', '01-APR-1975', '11-JAN-1998', 2000000, 3200000) ;

Insert into PROFESSEURS (Num_prof, nom , specialite, Date_entree, Der_prom, Salaire_base, Salaire_actuel)
Values(8, 'Pucette', 'sql', '06-DEC-1988', '29-FEB-1996', 2000000, 2500000) ;

Insert into CHARGE (Num_prof, Num_cours)
Values(1,1) ;

Insert into CHARGE (Num_prof, Num_cours)
Values(1,4) ;

Insert into CHARGE (Num_prof, Num_cours)
Values(2,1) ;

Insert into CHARGE (Num_prof, Num_cours)
Values(3,2) ;

Insert into CHARGE (Num_prof, Num_cours)
Values(3,4) ;

Insert into CHARGE (Num_prof, Num_cours)
Values(3,5) ;

Insert into CHARGE (Num_prof, Num_cours)
Values(4,2) ;

Insert into CHARGE (Num_prof, Num_cours)
Values(7,4) ;

Insert into CHARGE (Num_prof, Num_cours)
Values(8,1) ;

Insert into CHARGE (Num_prof, Num_cours)
Values(8,2) ;

Insert into CHARGE (Num_prof, Num_cours)
Values(8,3) ;

Insert into CHARGE (Num_prof, Num_cours)
Values(8,4) ;

Insert into CHARGE (Num_prof, Num_cours)
Values(8,5) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(1,1, 15 ) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(1,2 ,10.5 ) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(1, 4, 8) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(1, 5, 20) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(2, 1, 13.5) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(2, 2, 12) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(2, 4, 11) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(2, 5, 1.5) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(3, 1, 14) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(3, 2, 15) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(3, 4, 16) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(3, 5, 20) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(4, 1, 16.5) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(4, 2, 14) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(4, 4, 11) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(4, 5, 8) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(5, 1, 5) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(5, 2, 6.5) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(5, 4, 13) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(5, 5, 13) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(6, 1, 15) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(6, 2, 3.5) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(6, 4, 16) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(6, 5, 5) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(7, 1, 2.5) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(7, 2, 18) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(7, 4, 11) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(7, 5, 10) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(8, 1, 16) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(8, 2, 0) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(8, 4, 6) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(8, 5, 11.5) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(9, 1, 20) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(9, 2, 20) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(9, 4, 14) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(9, 5, 9.5) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(10, 1, 3) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(10, 2, 12.5) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(10, 4, 0) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(10, 5, 16) ;

Insert into ACTIVITES (Niveau, Nom, equipe)
Values(1,'Mini foot','Amc Indus') ;

Insert into ACTIVITES (Niveau, Nom, equipe)
values (1,'Surf','Les planchistes ...') ;


Insert into ACTIVITES (Niveau, Nom, equipe)
Values(2,'Tennis','Ace Club') ;

Insert into ACTIVITES (Niveau, Nom, equipe)
Values(3,'Tennis','Ace Club') ;

Insert into ACTIVITES (Niveau, Nom, equipe)
Values(1,'Volley ball', 'Avs80') ;

Insert into ACTIVITES (Niveau, Nom, equipe)
Values(2,'Mini foot', 'Les as du ballon') ;

Insert into ACTIVITES (Niveau, Nom, equipe)
Values(2,'Volley ball', 'smash') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (1, 1, 'Mini foot') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (1, 1, 'Surf') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (1, 1, 'Volley ball') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (1, 2, 'Tennis') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (2, 1, 'Mini foot') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (2, 2, 'Tennis') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (3, 2, 'Mini foot') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (3, 2, 'Tennis') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (3, 2, 'Volley ball') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (4, 1, 'Surf') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (4, 2, 'Mini foot') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (5, 1, 'Mini foot') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (5, 1, 'Surf') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (5, 1, 'Volley ball') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (8, 1, 'Mini foot') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (8, 1, 'Volley ball') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (8, 2, 'Volley ball') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (9, 1, 'Mini foot') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (9, 2, 'Volley ball') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (10, 1, 'Mini foot') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (10, 2, 'Tennis') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (10, 2, 'Volley ball') ;

REM **************************************************************************

REM **************************************************************************

COMMIT;

Select * from cours;