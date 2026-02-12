-- Lab 6 PLSQL

-- 1

CREATE OR REPLACE TRIGGER t1_gid
BEFORE INSERT OR UPDATE OR DELETE ON emp_gid
BEGIN
    IF TO_CHAR(sysdate, 'D') = 1 OR
        TO_CHAR(sysdate, 'HH24') NOT BETWEEN 10 AND 20 THEN
            RAISE_APPLICATION_ERROR(-20000, 'Operatie nepermisa');
    END IF;
END;
/

DELETE FROM emp_gid;

DROP TRIGGER t1_gid;

-- 2

CREATE OR REPLACE TRIGGER t2_gid
BEFORE UPDATE OF salary ON emp_gid
FOR EACH ROW
BEGIN
    IF :new.salary < :old.salary THEN
        RAISE_APPLICATION_ERROR(-20002, 'Operatie nepermisa');
    END IF;
END;
/

UPDATE emp_gid
SET salary = salary - 100
WHERE employee_id = 100;

rollback;

CREATE OR REPLACE TRIGGER t2_gid
BEFORE UPDATE OF salary ON emp_gid
FOR EACH ROW
WHEN (new.salary < old.salary)
BEGIN
    RAISE_APPLICATION_ERROR(-20002, 'Operatie nepermisa');
END;
/

DROP TRIGGER t2_gid;

-- 3

SELECT * FROM job_grades;
CREATE TABLE job_grades_gid AS SELECT * FROM job_grades;

CREATE OR REPLACE TRIGGER t3_gid
BEFORE UPDATE OF lowest_sal, highest_sal ON job_grades_gid
FOR EACH ROW
DECLARE
    sal_min employees.salary%TYPE;
    sal_max employees.salary%TYPE;
    exceptie EXCEPTION;
BEGIN
    SELECT MIN(salary), MAX(salary) INTO sal_min, sal_max
    FROM emp_gid;
    
    IF (:old.grade_level = 1 AND :new.lowest_sal > sal_min) OR
        (:old.grade_level = 7 AND :new.highest_sal < sal_max) THEN
        RAISE exceptie;
    END IF;
EXCEPTION
    WHEN exceptie THEN
        RAISE_APPLICATION_ERROR(-20003, 'Operatie nepermisa');
END;
/

UPDATE job_grades_gid
SET lowest_sal = 100000
WHERE grade_level = 1;

UPDATE job_grades_gid
SET highest_sal = 100
WHERE grade_level = 7;

DROP TRIGGER t3_gid;


-- 4

DESC dept_gid;

CREATE TABLE info_dept_gid
(id NUMBER(4) PRIMARY KEY,
 nume_dept VARCHAR2(30),
 plati NUMBER);
 
INSERT INTO info_dept_gid
SELECT d.department_id, department_name, SUM(salary)
FROM emp_gid e, dept_gid d
WHERE e.department_id(+) = d.department_id
GROUP BY d.department_id, department_name;

commit;

CREATE OR REPLACE PROCEDURE ad_plati_gid
    (cod info_dept_gid.id%TYPE,
     val NUMBER)
IS
BEGIN
    UPDATE info_dept_gid
    SET plati = NVL(plati, 0) + val
    WHERE id = cod;
END;
/

CREATE OR REPLACE TRIGGER t4_gid
AFTER INSERT OR UPDATE OF salary OR DELETE ON emp_gid
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        ad_plati_gid(:new.department_id, :new.salary);
    ELSIF DELETING THEN
        ad_plati_gid(:old.department_id, -:old.salary);
    ELSIF UPDATING THEN
        ad_plati_gid(:new.department_id, :new.salary-:old.salary);
    END IF;
END;
/

SELECT * FROM info_dept_gid
WHERE id = 90;

DESC emp_gid;
INSERT INTO emp_gid
VALUES (300, 'Prenume', 'Nume', 'Email', null, sysdate,
        'SA_REP', 2000, null, null, 90);

UPDATE emp_gid
SET salary = salary + 1000
WHERE employee_id = 300;

DELETE FROM emp_gid WHERE employee_id = 300;

rollback;

DROP TRIGGER t4_gid;

-- 5

DESC emp_gid;
CREATE TABLE info_emp_gid
(id NUMBER(6) PRIMARY KEY,
 nume VARCHAR2(25),
 prenume VARCHAR2(20),
 salariu NUMBER(8,2),
 id_dept NUMBER(4) REFERENCES info_dept_gid(id));
 
INSERT INTO info_emp_gid
SELECT employee_id, last_name, first_name, salary, department_id
FROM emp_gid;

commit;

CREATE OR REPLACE VIEW v_info_gid AS
SELECT e.id, e.nume, e.prenume, e.salariu, e.id_dept,
       d.nume_dept, d.plati
FROM info_emp_gid e, info_dept_gid d
WHERE e.id_dept = d.id;

SELECT * FROM v_info_gid;

SELECT * FROM user_updatable_columns
WHERE table_name = 'V_INFO_GID';

CREATE OR REPLACE TRIGGER t5_gid
INSTEAD OF INSERT OR DELETE OR UPDATE ON v_info_gid
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO info_emp_gid
        VALUES (:new.id, :new.nume, :new.prenume, :new.salariu,
                :new.id_dept);
        UPDATE info_dept_gid
        SET plati = NVL(plati, 0) + :new.salariu
        WHERE id = :new.id_dept;
    ELSIF DELETING THEN
        DELETE FROM info_emp_gid
        WHERE id = :old.id;
        UPDATE info_dept_gid
        SET plati = NVL(plati, 0) - :old.salariu
        WHERE id = :old.id_dept;
    ELSIF UPDATING('salariu') THEN
        UPDATE info_emp_gid
        SET salariu = :new.salariu
        WHERE id = :old.id;
        UPDATE info_dept_gid
        SET plati = NVL(plati, 0) + :new.salariu - :old.salariu
        WHERE id = :new.id_dept;
    ELSIF UPDATING('id_dept') THEN
        UPDATE info_emp_gid
        SET id_dept = :new.id_dept
        WHERE id = :old.id;
        UPDATE info_dept_gid
        SET plati = NVL(plati, 0) - :old.salariu
        WHERE id = :old.id_dept;
        UPDATE info_dept_gid
        SET plati = NVL(plati, 0) + :new.salariu
        WHERE id = :new.id_dept;
    END IF;
END;
/

SELECT * FROM info_dept_gid WHERE id = 10;
SELECT * FROM info_dept_gid WHERE id = 90;

INSERT INTO v_info_gid(id, nume, prenume, salariu, id_dept)
VALUES (300, 'Nume', 'Prenume', 3000, 10);

UPDATE v_info_gid
SET salariu = salariu - 1000
WHERE id = 300;

UPDATE v_info_gid
SET id_dept = 90
WHERE id = 300;

DELETE FROM v_info_gid
WHERE id = 300;

SELECT * FROM info_emp_gid WHERE id = 300;

-- 6

CREATE OR REPLACE TRIGGER t6_gid
BEFORE DELETE ON emp_gid
BEGIN
    IF lower(user) = 'grupa232' THEN
        RAISE_APPLICATION_ERROR(-20004, 'Operatie nepermisa');
    END IF;
END;
/

DELETE FROM emp_gid;

DROP TRIGGER t6_gid;

-- 7

CREATE TABLE audit_gid
(utilizator VARCHAR2(30),
 nume_bd VARCHAR2(50),
 eveniment VARCHAR2(20),
 nume_obiect VARCHAr2(30),
 data DATE);

CREATE OR REPLACE TRIGGER t7_gid
AFTER CREATE OR ALTER OR DROP ON SCHEMA
BEGIN
    INSERT INTO audit_gid
    VALUES (sys.login_user, sys.database_name, sys.sysevent,
            sys.dictionary_obj_name, sysdate);
END;
/

CREATE TABLE test_gid (a NUMBER);
DROP TABLE test_gid;

SELECT * FROM audit_gid;

DROP TRIGGER t7_gid;

-- 8

-- nu putem folosi in trigger tabelul asupra caruia e definit triggerul -> table mutating

CREATE OR REPLACE TRIGGER t8_gid 
BEFORE UPDATE OF salary ON emp_gid
FOR EACH ROW
DECLARE
    sal_max emp_gid.salary%TYPE;
    sal_min emp_gid.salary%TYPE;
    sal_med emp_gid.salary%TYPE;
BEGIN
    SELECT MAX(salary), MIN(salary), AVG(salary)
    INTO sal_max, sal_min, sal_med
    FROM emp_gid;
    
    IF (:old.salary = sal_max AND :new.salary < sal_med) OR
        (:old.salary = sal_min AND :new.salary > sal_max) THEN
        RAISE_APPLICATION_ERROR(-20000, 'Operatie nepermisa');
    END IF;
END;
/

-- pentru a evita eroarea table mutating cream un trigger aditional 
-- la nivel de instructiune ca retine salariile max, min, avg in variabilele unui pachet

CREATE OR REPLACE PACKAGE pachet_var_gid IS
    sal_max emp_gid.salary%TYPE;
    sal_min emp_gid.salary%TYPE;
    sal_med emp_gid.salary%TYPE;
END;
/

CREATE OR REPLACE TRIGGER t81_gid
BEFORE UPDATE OF salary ON emp_gid
BEGIN
    SELECT MAX(salary), MIN(salary), AVG(salary)
    INTO pachet_var_gid.sal_max, pachet_var_gid.sal_min, 
        pachet_var_gid.sal_med
    FROM emp_gid;
END;
/

CREATE OR REPLACE TRIGGER t8_gid 
BEFORE UPDATE OF salary ON emp_gid
FOR EACH ROW
BEGIN   
    IF (:old.salary = pachet_var_gid.sal_max AND 
        :new.salary < pachet_var_gid.sal_med) OR
        (:old.salary = pachet_var_gid.sal_min AND 
            :new.salary > pachet_var_gid.sal_med) THEN
        RAISE_APPLICATION_ERROR(-20000, 'Operatie nepermisa');
    END IF;
END;
/

UPDATE emp_gid
SET salary = 10000
WHERE salary = (SELECT MAX(salary) FROM emp_gid);

rollback;

DROP TRIGGER t81_gid;
DROP TRIGGER t8_gid;



-- Tema T9 - Ex E3 din fisierul Laborator PLSQL 6.pdf
-- Tema T10 - Ex E5 din fisierul Laborator PLSQL 6.pdf
-- Deadline (pentru ambele) - miercuri 17.12.2025 ora 21:59
