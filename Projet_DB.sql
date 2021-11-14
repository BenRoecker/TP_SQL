alter session set "_ORACLE_SCRIPT"=true;

--------------------------------------------------------------
---------------------------DDL--------------------------------

CREATE TABLE ContratClient (dateDebut date, dateFin date, coefpoids number(10), coeftaille number(10), validity char(1), Clientraisonsocial number(10) NOT NULL, id number(10) GENERATED AS IDENTITY, PRIMARY KEY (id));
CREATE TABLE Client (raisonsocial number(10) GENERATED AS IDENTITY, numeroregistre number(10), telephone number(10), adressenumero number(10) NOT NULL, adresserue char(255) NOT NULL, adresseville char(255) NOT NULL, adressecodePostal number(10) NOT NULL, PRIMARY KEY (raisonsocial));
CREATE TABLE Colis (poids number(10), taille number(10), numero char(10), Livraisonid number(10) NOT NULL, id number(10) GENERATED AS IDENTITY, PointRelaisid number(10) NOT NULL, adressenumero number(10) NOT NULL, adresserue char(255) NOT NULL, adresseville char(255) NOT NULL, adressecodePostal number(10) NOT NULL, PRIMARY KEY (id));
CREATE TABLE PointRelais (numero number(10), rue char(255), ville char(255), codePostal number(10), id number(10) GENERATED AS IDENTITY, PRIMARY KEY (id));
CREATE TABLE Livreur (Nom varchar2(20) NOT NULL, Prenom number(10) NOT NULL, telephone number(10), DepartementcodePostal varchar2(20) NOT NULL, PRIMARY KEY (Nom, Prenom));
CREATE TABLE Departement (codePostal varchar2(20) NOT NULL, Nom varchar2(20), ResponsableNom varchar2(20) NOT NULL, ResponsablePrenom char(255) NOT NULL, PRIMARY KEY (codePostal));
CREATE TABLE facture (id number(10) GENERATED AS IDENTITY, relaistoadresse number(10), adressetorelais number(10), adressetoadresse number(10), prix number(10), regle raw(1), Clientraisonsocial number(10) NOT NULL, PRIMARY KEY (id));
CREATE TABLE adresse (numero number(10) NOT NULL, rue char(255) NOT NULL, ville char(255) NOT NULL, codePostal number(10) NOT NULL, PRIMARY KEY (numero, rue, ville));
CREATE TABLE Responsable (Nom varchar2(20) NOT NULL, Prenom char(255) NOT NULL, telephone number(10), PRIMARY KEY (Nom, Prenom));
CREATE TABLE Contratrelais (dateDebut number(10), dateFin number(10), validity raw(1), ouverture timestamp(7), fermeture timestamp(7), id number(10) GENERATED AS IDENTITY, PointRelaisid number(10) NOT NULL, PRIMARY KEY (id));
CREATE TABLE Livraison ("date" date, id number(10) GENERATED AS IDENTITY, LivreurNom varchar2(20) NOT NULL, LivreurPrenom number(10) NOT NULL, Clientraisonsocial number(10) NOT NULL, PRIMARY KEY (id));
CREATE TABLE Paiement ("date" date, montant number(10), id number(10) GENERATED AS IDENTITY, PointRelaisid number(10) NOT NULL, PRIMARY KEY (id));
ALTER TABLE Livreur ADD CONSTRAINT FKLivreur415042 FOREIGN KEY (DepartementcodePostal) REFERENCES Departement (codePostal);
ALTER TABLE Colis ADD CONSTRAINT FKColis314700 FOREIGN KEY (PointRelaisid) REFERENCES PointRelais (id);
ALTER TABLE facture ADD CONSTRAINT FKfacture10880 FOREIGN KEY (Clientraisonsocial) REFERENCES Client (raisonsocial);
ALTER TABLE Client ADD CONSTRAINT FKClient780786 FOREIGN KEY (adressenumero, adresserue, adresseville) REFERENCES adresse (numero, rue, ville);
ALTER TABLE Colis ADD CONSTRAINT FKColis356687 FOREIGN KEY (adressenumero, adresserue, adresseville) REFERENCES adresse (numero, rue, ville);
ALTER TABLE Departement ADD CONSTRAINT FKDepartemen695662 FOREIGN KEY (ResponsableNom, ResponsablePrenom) REFERENCES Responsable (Nom, Prenom);
ALTER TABLE Colis ADD CONSTRAINT FKColis556490 FOREIGN KEY (Livraisonid) REFERENCES Livraison (id);
ALTER TABLE Livraison ADD CONSTRAINT FKLivraison592620 FOREIGN KEY (Clientraisonsocial) REFERENCES Client (raisonsocial);
ALTER TABLE Livraison ADD CONSTRAINT FKLivraison533819 FOREIGN KEY (LivreurNom, LivreurPrenom) REFERENCES Livreur (Nom, Prenom);
ALTER TABLE Paiement ADD CONSTRAINT FKPaiement502198 FOREIGN KEY (PointRelaisid) REFERENCES PointRelais (id);
ALTER TABLE Contratrelais ADD CONSTRAINT FKContratrel685586 FOREIGN KEY (PointRelaisid) REFERENCES PointRelais (id);
ALTER TABLE ContratClient ADD CONSTRAINT FKContratCli984566 FOREIGN KEY (Clientraisonsocial) REFERENCES Client (raisonsocial);

------------------------------------------------------------------------------
------------------------Les données-------------------------------------------
------------------------------------------------------------------------------

INSERT INTO POINTRELAIS(codePostal, ville, rue, numero)
VALUES(78100,'Saint-Germain-en-Laye', 'Maurice Denis', 5);
INSERT INTO ADRESSE(NUMERO,RUE,VILLE,CODEPOSTAL)
VALUES(5,'Maurice Denis','Saint-Germain-en-Laye',78100);
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
INSERT INTO LIVRAISON("date",LivreurNom,LivreurPrenom,Clientraisonsocial)
VALUES('2000-09-18','Roecker',10,3);
INSERT INTO CLIENT(NUMEROREGISTRE,ADRESSERUE,ADRESSENUMERO,ADRESSEVILLE,ADRESSECODEPOSTAL)
VALUES(09876545,'Maurice Denis',5,'Saint-Germain-en-Laye',78100);
INSERT INTO LIVREUR(NOM,PRENOM,TELEPHONE,DEPARTEMENTCODEPOSTAL)
Values('Roecker',10,0635103615,'78');
INSERT INTO DEPARTEMENT(CODEPOSTAL,NOM,RESPONSABLENOM,RESPONSABLEPRENOM)
VALUES('78','Yveline','Renan','Josselin');
INSERT INTO RESPONSABLE(NOM,PRENOM,TELEPHONE)
VALUES('Renan','Josselin','0956467456');
INSERT INTO COLIS(numero, taille,poids,PointRelaisid, Livraisonid,ADRESSENUMERO,ADRESSERUE,ADRESSEVILLE,ADRESSECODEPOSTAL)
VALUES('45F56',30,30,1,10,5,'Maurice Denis','Saint-Germain-en-Laye',78100);
INSERT INTO COLIS(numero, taille,poids,PointRelaisid, Livraisonid,ADRESSENUMERO,ADRESSERUE,ADRESSEVILLE,ADRESSECODEPOSTAL)
VALUES('45F57',15,45,1,10,5,'Maurice Denis','Saint-Germain-en-Laye',78100);





------------------------------------------------------------------------------
------------------------Les Vues----------------------------------------------
------------------------------------------------------------------------------

Create or REPLACE VIEW nbrColisRelais
AS
Select 
Count(COLIS.ID) "Total",
POINTRELAIS.ID,
Extract(MONTH FROM LIVRAISON."date") "Month"
FROM
PointRelais 
INNER JOIN COLIS on COLIS.POINTRELAISID = POINTRELAIS.ID
INNER JOIN Livraison on Colis.LIVRAISONID = LIVRAISON.ID
GROUP BY POINTRELAIS.ID, Extract(MONTH FROM LIVRAISON."date"); 

CREATE or REPLACE VIEW LivraisonsEnCours
AS
SELECT
COLIS.NUMERO,
COLIS.ID
FROM COLIS
INNER JOIN Livraison on Colis.LIVRAISONID = LIVRAISON.ID
INNER JOIN CLIENT on CLIENT.RAISONSOCIAL = LIVRAISON.CLIENTRAISONSOCIAL
RIGHT JOIN FACTURE on FACTURE.CLIENTRAISONSOCIAL = CLIENT.NUMEROREGISTRE
WHERE FACTURE.ID = NULL;


