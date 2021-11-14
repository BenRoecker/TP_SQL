alter session set "_ORACLE_SCRIPT"=true;
--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------DDL---------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE ContratClient (dateDebut date, dateFin date, coefpoids number(10), coeftaille number(10), validity char(1), Clientraisonsocial number(10) NOT NULL, id number(10) GENERATED AS IDENTITY, PRIMARY KEY (id));
CREATE TABLE Client (raisonsocial number(10) GENERATED AS IDENTITY, numeroregistre number(10), telephone number(10), adresseid number(10) NOT NULL, PRIMARY KEY (raisonsocial));
CREATE TABLE Colis (poids number(10), taille number(10), numero char(10), Livraisonid number(10) NOT NULL, id number(10) GENERATED AS IDENTITY, Pointrelaisid number(10) NOT NULL, adresseid number(10), Done number(1) NOT NULL, PRIMARY KEY (id));
CREATE TABLE Pointrelais (numero number(10), rue char(255), ville char(255), codePostal number(10), id number(10) GENERATED AS IDENTITY, PRIMARY KEY (id));
CREATE TABLE Livreur (Nom varchar2(20) NOT NULL, Prenom varchar2(255) NOT NULL, telephone number(10), DepartementcodePostal varchar2(20) NOT NULL, ID number(10) GENERATED AS IDENTITY, PRIMARY KEY (ID));
CREATE TABLE Departement (codePostal varchar2(20) NOT NULL, Nom varchar2(20), ResponsableNom varchar2(20) NOT NULL, ResponsablePrenom char(255) NOT NULL, PRIMARY KEY (codePostal));
CREATE TABLE facture (id number(10) GENERATED AS IDENTITY, relaistoadresse number(10), adressetorelais number(10), adressetoadresse number(10), prix number(10), paid number(1), Clientraisonsocial number(10) NOT NULL, PRIMARY KEY (id));
CREATE TABLE adresse (numero number(10) NOT NULL, rue char(255) NOT NULL, ville char(255) NOT NULL, codePostal number(10), id number(10) NOT NULL, PRIMARY KEY (id));
CREATE TABLE Responsable (Nom varchar2(20) NOT NULL, Prenom char(255) NOT NULL, telephone number(10), PRIMARY KEY (Nom, Prenom));
CREATE TABLE Contratrelais (dateDebut number(10), dateFin number(10), validity raw(1), ouverture timestamp(7), fermeture timestamp(7), id number(10) GENERATED AS IDENTITY, Pointrelaisid number(10) NOT NULL, PRIMARY KEY (id));
CREATE TABLE Livraison (DateCreation date, id number(10) GENERATED AS IDENTITY, Clientraisonsocial number(10) NOT NULL, LivreurID number(10), Recup number(1), PRIMARY KEY (id));
CREATE TABLE Paiement ("date" date, montant number(10), id number(10) GENERATED AS IDENTITY, Pointrelaisid number(10) NOT NULL, PRIMARY KEY (id));
ALTER TABLE Livreur ADD CONSTRAINT FKLivreur756584 FOREIGN KEY (DepartementcodePostal) REFERENCES Departement (codePostal);
ALTER TABLE Colis ADD CONSTRAINT FKColis262711 FOREIGN KEY (Pointrelaisid) REFERENCES Pointrelais (id);
ALTER TABLE facture ADD CONSTRAINT FKfacture10880 FOREIGN KEY (Clientraisonsocial) REFERENCES Client (raisonsocial);
ALTER TABLE Client ADD CONSTRAINT FKClient420396 FOREIGN KEY (adresseid) REFERENCES adresse (id);
ALTER TABLE Colis ADD CONSTRAINT FKColis413720 FOREIGN KEY (adresseid) REFERENCES adresse (id);
ALTER TABLE Departement ADD CONSTRAINT FKDepartemen674716 FOREIGN KEY (ResponsableNom, ResponsablePrenom) REFERENCES Responsable (Nom, Prenom);
ALTER TABLE Colis ADD CONSTRAINT FKColis556490 FOREIGN KEY (Livraisonid) REFERENCES Livraison (id);
ALTER TABLE Livraison ADD CONSTRAINT FKLivraison592620 FOREIGN KEY (Clientraisonsocial) REFERENCES Client (raisonsocial);
ALTER TABLE Livraison ADD CONSTRAINT FKLivraison797213 FOREIGN KEY (LivreurID) REFERENCES Livreur (ID);
ALTER TABLE Paiement ADD CONSTRAINT FKPaiement450209 FOREIGN KEY (Pointrelaisid) REFERENCES Pointrelais (id);

--------------------------------------------------------------------------------------------------------------------------
-------------------------------------------Les données--------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
----Adresse
INSERT INTO ADRESSE(ID,NUMERO, RUE, VILLE)
VALUES(1,5,'Maurice DENIS','Saint-Germain-en-Laye');
----Client
INSERT INTO CLIENT(ADRESSEID,TELEPHONE)
VALUES(1,0635103615);
----Responsable
INSERT INTO RESPONSABLE(NOM,PRENOM)
VALUES('Renan','Josselin');
----Departement
INSERT INTO DEPARTEMENT(CODEPOSTAL,RESPONSABLENOM,RESPONSABLEPRENOM,NOM)
VALUES(78,'Renan','Josselin','Yveline');
----Livreur
INSERT INTO LIVREUR(NOM,PRENOM,DEPARTEMENTCODEPOSTAL)
Values('Sinsheimer','Alexandre',78);
--Livraison
INSERT INTO LIVRAISON(RECUP,LIVREURID,CLIENTRAISONSOCIAL,DATECREATION)
VALUES(0,1,1,'12-DEC-2021');
UPDATE LIVRAISON
SET RECUP=1
WHERE DATECREATION = '12-DEC-2021';
--POINT RELAIS
INSERT INTO POINTRELAIS(NUMERO,RUE,VILLE)
VALUES(4,'De la Paix','Paris');
--Colis
INSERT INTO COLIS(LIVRAISONID,NUMERO,TAILLE,POIDS,DONE,POINTRELAISID)
VALUES(1,'234GT567',30,30,0,1);
---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------Les Vues----------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
---7
Create or REPLACE VIEW nbrColisRelais
AS
Select 
Count(COLIS.ID) "Total",
POINTRELAIS.ID,
Extract(MONTH FROM LIVRAISON.DateCreation) "Month"
FROM
PointRelais 
INNER JOIN COLIS on COLIS.POINTRELAISID = POINTRELAIS.ID
INNER JOIN Livraison on Colis.LIVRAISONID = LIVRAISON.ID
GROUP BY POINTRELAIS.ID, Extract(MONTH FROM LIVRAISON.DateCreation); 
---6
CREATE or REPLACE VIEW LivraisonsEnCours
AS
SELECT
COLIS.NUMERO,
COLIS.ID
FROM COLIS
INNER JOIN Livraison on Colis.LIVRAISONID = LIVRAISON.ID
WHERE COLIS.DONE = 0 AND LIVRAISON.RECUP = 1;



select * from POINTRELAIS;

----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------Procédure et fonction---------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
