alter session set "_ORACLE_SCRIPT"=true;

--------------------------------------------------------------
---------------------------DDL--------------------------------
CREATE TABLE item (itemid number(10) GENERATED AS IDENTITY, title varchar2(255), price float(10), "date" number(10), nbrlnStock number(10), avgGrade float(10), nbrVotes number(10), Categorycategory number(10) NOT NULL, Typetype varchar2(255) NOT NULL, PRIMARY KEY (itemid));
CREATE TABLE Type (type varchar2(255) NOT NULL, PRIMARY KEY (type));
CREATE TABLE Category (category number(10) GENERATED AS IDENTITY, PRIMARY KEY (category));
CREATE TABLE ShoppingCart (cartId number(10) GENERATED AS IDENTITY, complete raw(1), itemitemid number(10) NOT NULL, CostumerCutomerNbr number(10) NOT NULL, PRIMARY KEY (cartId));
CREATE TABLE item_ShoppingCartjj (itemitemid number(10) NOT NULL, ShoppingCartcartId number(10) NOT NULL, isDelivered number(10), deliveryDate number(10), PRIMARY KEY (itemitemid, ShoppingCartcartId));
CREATE TABLE Costumer (CutomerNbr number(10) GENERATED AS IDENTITY, name varchar2(255), adress varchar2(255), creditCardNumber number(10), email varchar2(255), newsletter varchar2(255), PRIMARY KEY (CutomerNbr));
CREATE TABLE Review ("date" varchar2(255) NOT NULL, text varchar2(255), CostumerCutomerNbr number(10) NOT NULL, itemitemid number(10) NOT NULL, PRIMARY KEY ("date"));
CREATE TABLE Eleves (Num_eleve number(4) GENERATED AS IDENTITY, Nom varchar2(25), Prenom varchar2(25), date_naissance date, poids number(10), annee number(10), sexe char(1), PRIMARY KEY (Num_eleve));
CREATE TABLE Cours (Num_cours number(2) GENERATED AS IDENTITY, Nom varchar2(20), nbheures number(2), Annee number(1), PRIMARY KEY (Num_cours));
CREATE TABLE Professeurs (Num_prof number(4) GENERATED AS IDENTITY, nom varchar2(25), specialite varchar2(20), dateEntree date, der_prom date, salaire_base number(10), salaire_actuel number(10), PRIMARY KEY (Num_prof));
CREATE TABLE Activites (niveau number(1) NOT NULL, nom varchar2(20) NOT NULL, Equipe varchar2(32), PRIMARY KEY (niveau, nom));
CREATE TABLE charge (ProfesseursNum_prof number(4) NOT NULL, CoursNum_cours number(2) NOT NULL, PRIMARY KEY (ProfesseursNum_prof, CoursNum_cours));
CREATE TABLE Activites_Eleves (Activitesniveau number(1) NOT NULL, ElevesNum_eleve number(4) NOT NULL, Activitesnom varchar2(20) NOT NULL, PRIMARY KEY (Activitesniveau, ElevesNum_eleve, Activitesnom));
CREATE TABLE Cours_Eleves (CoursNum_cours number(2) NOT NULL, ElevesNum_eleve number(4) NOT NULL, points number(10), CONSTRAINT resultat PRIMARY KEY (CoursNum_cours, ElevesNum_eleve));
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
ALTER TABLE item ADD CONSTRAINT FKitem967474 FOREIGN KEY (Categorycategory) REFERENCES Category (category);
ALTER TABLE item ADD CONSTRAINT FKitem267998 FOREIGN KEY (Typetype) REFERENCES Type (type);
ALTER TABLE item_ShoppingCartjj ADD CONSTRAINT FKitem_Shopp1744 FOREIGN KEY (itemitemid) REFERENCES item (itemid);
ALTER TABLE item_ShoppingCartjj ADD CONSTRAINT FKitem_Shopp158225 FOREIGN KEY (ShoppingCartcartId) REFERENCES ShoppingCart (cartId);
ALTER TABLE ShoppingCart ADD CONSTRAINT FKShoppingCa810229 FOREIGN KEY (CostumerCutomerNbr) REFERENCES Costumer (CutomerNbr);
ALTER TABLE Review ADD CONSTRAINT FKReview945998 FOREIGN KEY (CostumerCutomerNbr) REFERENCES Costumer (CutomerNbr);
ALTER TABLE Review ADD CONSTRAINT FKReview157778 FOREIGN KEY (itemitemid) REFERENCES item (itemid);
ALTER TABLE charge ADD CONSTRAINT FKcharge900196 FOREIGN KEY (ProfesseursNum_prof) REFERENCES Professeurs (Num_prof);
ALTER TABLE charge ADD CONSTRAINT FKcharge769882 FOREIGN KEY (CoursNum_cours) REFERENCES Cours (Num_cours);
ALTER TABLE Activites_Eleves ADD CONSTRAINT FKActivites_285138 FOREIGN KEY (Activitesniveau, Activitesnom) REFERENCES Activites (niveau, nom);
ALTER TABLE Activites_Eleves ADD CONSTRAINT FKActivites_586414 FOREIGN KEY (ElevesNum_eleve) REFERENCES Eleves (Num_eleve);
ALTER TABLE Cours_Eleves ADD CONSTRAINT FKCours_Elev213580 FOREIGN KEY (CoursNum_cours) REFERENCES Cours (Num_cours);
ALTER TABLE Cours_Eleves ADD CONSTRAINT FKCours_Elev248326 FOREIGN KEY (ElevesNum_eleve) REFERENCES Eleves (Num_eleve);
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






------------------------------------------------------------------------------
------------------------Les Vues----------------------------------------------
------------------------------------------------------------------------------




