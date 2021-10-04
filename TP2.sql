select POINTS, ELEVES.NOM from RESULTATS INNER JOIN ELEVES on RESULTATS.NUM_ELEVE = ELEVES.NUM_ELEVE order by ELEVES.NOM;

select PROFESSEURS.NOM, COURS.NOM from PROFESSEURS INNER JOIN CHARGE on PROFESSEURS.NUM_PROF = CHARGE.NUM_PROF INNER JOIN COURS on COURS.NUM_COURS = CHARGE.NUM_COURS;

alter table RESULTATS add constraint score_limit check (points <= 20 and points >=0 );

alter table ELEVES add constraint gender_val check (sexe in ('f','F','m','M'));

alter table PROFESSEURS add constraint Salary check (salaire_base <= salaire_actuel);

connect benjamin;

create or replace TRIGGER cannot_decrease 
 BEFORE
  UPDATE ON PROFESSEURS
DECLARE
 user_xcep EXCEPTION;
 PRAGMA EXCEPTION_INIT( user_xcep, -20001 );
BEGIN
 WHEN (NEW.SALAIRE_ACTUEL <= OLD.SALAIRE_ACTUEL)
  RAISE user_xcep;
END;

CREATE TABLE PROF_SPECIALITE (SPECIALITE VARCHAR2 (20), NB_PROFESSEURS NUMBER);