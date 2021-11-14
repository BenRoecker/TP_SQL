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







---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------Les Vues----------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------






----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------Procédure et fonction---------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
