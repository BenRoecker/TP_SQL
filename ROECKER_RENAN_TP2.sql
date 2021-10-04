select POINTS, ELEVES.NOM from RESULTATS INNER JOIN ELEVES on RESULTATS.NUM_ELEVE = ELEVES.NUM_ELEVE order by ELEVES.NOM;

select PROFESSEURS.NOM, COURS.NOM from PROFESSEURS INNER JOIN CHARGE on PROFESSEURS.NUM_PROF = CHARGE.NUM_PROF INNER JOIN COURS on COURS.NUM_COURS = CHARGE.NUM_COURS;

alter table RESULTATS add constraint score_limit check (points <= 20 and points >=0 );

alter table ELEVES add constraint gender_val check (sexe in ('f','F','m','M'));

alter table PROFESSEURS add constraint Salary check (salaire_base <= salaire_actuel);

create or replace TRIGGER cannot_decrease 
 BEFORE
  UPDATE ON PROFESSEURS
   FOR EACH ROW
 DECLARE
  user_xcep EXCEPTION;
 BEGIN
  if (:new.Salaire_actuel < :OLD.SALAIRE_ACTUEL) then
   RAISE user_xcep;
  END IF;
  EXCEPTION WHEN user_xcep THEN
   DBMS_OUTPUT.PUT_LINE('Error Error - Cannot decrease salary');
END;
/
CREATE TABLE PROF_SPECIALITE (SPECIALITE VARCHAR2 (20), NB_PROFESSEURS NUMBER);

create or replace TRIGGER update_specialite
 AFTER insert or update or delete on PROFESSEURS for EACH ROW
declare
    nb_prof NUMBER := 1;
Begin
if inserting THEN
  select NB_PROFESSEURS into nb_prof from PROF_SPECIALITE where SPECIALITE = :new.SPECIALITE;
  update PROF_SPECIALITE set NB_PROFESSEURS = nb_prof+1 where SPECIALITE = :NEW.SPECIALITE;
ELSIF deleting THEN
 select NB_PROFESSEURS into nb_prof from PROF_SPECIALITE where SPECIALITE = :OLD.SPECIALITE;
 update PROF_SPECIALITE set NB_PROFESSEURS = nb_prof -1 where SPECIALITE = :OLD.SPECIALITE;
 if nb_prof = 1 then 
  delete from prof_specialite where specialite = :old.specialite;
 end if;
elsif updating then 
 select nb_professeurs into nb_prof from prof_specialite where specialite = :new.specialite;  
 update prof_specialite SET nb_professeurs = nb_prof + 1 where specialite = :new.specialite;
 select nb_professeurs into nb_prof from prof_specialite where specialite = :old.specialite;
 update prof_specialite set nb_professeurs = nb_prof - 1 where specialite = :old.specialite;
 if nb_prof = 1 then 
  DELETE from PROF_SPECIALITE where specialite = :old.specialite;
 end if;
end if;
EXCEPTION 
 When NO_DATA_FOUND then 
  insert into prof_specialite values (:new.specialite,1);                             
end;
/

COMMIT;
select * from PROF_SPECIALITE;
update PROFESSEURS set SPECIALITE = 'poo' where NUM_PROF = 1;

CREATE TABLE AUDIT_RESULTATS (
V_USER VARCHAR2 (50),
DATE_MAJ date,
DESC_MAJ VARCHAR2 (20),
NUM_ELEVE Number,
NUM_COURS Number,
Points Number
);

create or replace TRIGGER accessRecord
before INSERT or DELETE or UPDATE on RESULTATS for each row
BEGIN
if inserting THEN
insert into AUDIT_RESULTATS values(USER, SYSDATE(), 'INSERT', :new.NUM_ELEVE,:NEW.NUM_COURS,:new.points);
ELSIF deleting THEN
insert into AUDIT_RESULTATS values(USER, SYSDATE(), 'DELETE', 1,1,:old.NUM_ELEVE,old.NUM_COURS,:old.points);
ELSIF updating THEN
insert into AUDIT_RESULTATS values(USER, SYSDATE(), 'DELETE',:new.NUM_ELEVE,:NEW.NUM_COURS,:new.points);
END IF;
END;

create or replace trigger confidenciality
after update on professeurs
for each row
when (new.salaire_actuel >= old.salaire_actuel + 0.2 * old.salaire_actuel)
declare
not_grandchef_exception exception;
begin
if user <> 'GrandChef' then
raise not_grandchef_exception;
end if;
exception
when not_grandchef_exception then
raise_application_error(-20002, 'No modification is authorized');
end;

create or replace function fn_moyenne(ideleve IN number)
return float IS
  nb float;
begin
  select avg(points) into nb from resultats where num_eleve = ideleve;
  return nb;
end;

create or replace procedure pr_resultats
IS
CURSOR c_note IS  select num_eleve, avg(points) as moy from resultats group by num_eleve;
  decision varchar2(20);
BEGIN
  for note IN c_note LOOP
    if note.moy < 10 then decision := 'failure';
    elsif note.moy >= 10 and note.moy < 12 then decision := 'average,';
    elsif note.moy >= 12 and note.moy < 14 then decision := 'pretty good,';
    elsif note.moy >= 14 and note.moy < 16 then decision := 'good';
    elsif note.moy >= 16 then decision := 'very good';
    end if;    
  DBMS_OUTPUT.PUT(note.num_eleve || ':' || decision );
  end LOOP;
END;
