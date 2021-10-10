Create table adresse_type(
	street_number number,
	street_name Varchar(20),
	city_name Varchar(20)
)


CREATE TYPE personneType as OBJECT(
	firstname Varchar(20),
	lastname Varchar(20),
	id number
)NOT FINAL;


CREATE TYPE activitiesType as OBJECT(
	niveau number,
	nom Varchar(20),
	equipe Varchar(20)
)NOT FINAL;

Create TYPE cours_type AS OBJECT(
	NUM_COURS       Number(2),
    	NOM             VARCHAR2(20),
    	NBHEURES        Number(2),
    	ANNEE           Number(1)
)NOT FINAL;


Create table personnes OF personneType;

Create table activities OF activitiesType(
	CONSTRAINT PK_ACTIVITIES        PRIMARY KEY(NIVEAU, NOM)
);

Create table cours_associated OF cours_type(
	CONSTRAINT PK_COUR            PRIMARY KEY(NUM_COURS)
);



insert into Activities(niveau,nom,equipe)
	values(1,'surf','ekip');
insert into Activities(niveau,nom,equipe)
	values(2,'tennis','plop');


select * from cours;


select distinct(nom) from cours where NBHEURES >= 25;


insert into Activities(niveau,nom,equipe) values (1,'ski','Au club');

update activities set niveau=3 where nom='VolleyBall' and equipe='Avs80';


Create or replace TYPE liste_cours is ARRAY(5) of number (4,0) NOT NULL;

Create or replace type UE_type as object(cours liste_cours,name Varchar(200))FINAL;


Create table UE of UE_type(constraint PK_UE Primary Key(name));

Create or replace TYPE result_type AS object(cours Varchar(20),note float);


Create or replace type result_tab is table of result_type;

alter type eleve_type add attribute result result_tab cascade;

drop table personnes;
alter type personneType not final;
alter type personneType add attribute personneType char(1) cascade;
Create or replace TYPE professeurType under personneType(
	specialities Varchar(20),
	date_entree date,
	salaire_base number,
	salaire_actuel number
)FINAL;


Create or replace trigger prof_eleve before insert on professeurs for each row
Declare existing Exeption;
x number (4,0):=NULL;
BEGIN
select personne_num into x from eleves where pers_num:=new pers_num
if x is not NULL then
	RAISE existing;
end if;
Exeption where existing then RAISE_Application_ERROR(-2000,"A proffesseur can't be create");
where NO_DATA_FOUND then NULL
END;

Create or replace trigger eleve_prof before insert on eleves for each row
Declare existing Exeption;
x number (4,0):=NULL;
BEGIN
select personne_num into x from proffesseurs where pers_num:=new pers_num
if x is not NULL then
	RAISE existing;
end if;
Exeption where existing then RAISE_Application_ERROR(-2000,"A student can't be create");
where NO_DATA_FOUND then NULL;
END;


Select * from professeurs;

