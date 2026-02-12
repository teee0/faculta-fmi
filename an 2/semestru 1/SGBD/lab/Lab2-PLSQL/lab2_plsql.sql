-- Lab 2 PLSQL

-- 1

DECLARE 
    x NUMBER(1) := 5; 
    y x%TYPE  := NULL; 
BEGIN 
    IF x <> y THEN  
        DBMS_OUTPUT.PUT_LINE ('valoare <> null este = true'); 
    ELSE  
        DBMS_OUTPUT.PUT_LINE ('valoare <> null este != true'); 
    END IF; 
   
    x := NULL;  
    IF x = y THEN  
        DBMS_OUTPUT.PUT_LINE ('null = null este = true'); 
    ELSE  
       DBMS_OUTPUT.PUT_LINE ('null = null este != true'); 
    END IF; 
END; 
/ 
 
-- 2

-- a
DECLARE
    TYPE emp_record IS RECORD 
        (cod_ang employees.employee_id%TYPE,
         sal employees.salary%TYPE,
         cod_job employees.job_id%TYPE);
    ang emp_record;
BEGIN
--    ang.cod_ang := 300;
--    ang.sal := 10000;
--    ang.cod_job := 'Job';
    ang := emp_record(300, 10000, 'Job');

--    SELECT 300, 10000, 'Job'
--    INTO ang
--    FROM dual;
    
    dbms_output.put_line(ang.cod_ang || ' ' || ang.sal
        || ' ' || ang.cod_job);
END;
/

-- b
DECLARE
    TYPE emp_record IS RECORD 
        (cod_ang employees.employee_id%TYPE,
         sal employees.salary%TYPE,
         cod_job employees.job_id%TYPE);
    ang emp_record;
BEGIN
    SELECT employee_id, salary, job_id
    INTO ang
    FROM employees
    WHERE employee_id = 101;
    
    dbms_output.put_line(ang.cod_ang || ' ' || ang.sal
        || ' ' || ang.cod_job);
END;
/

-- c
DECLARE
    TYPE emp_record IS RECORD 
        (cod_ang emp_gid.employee_id%TYPE,
         sal emp_gid.salary%TYPE,
         cod_job emp_gid.job_id%TYPE);
    ang emp_record;
BEGIN
    DELETE FROM emp_gid
    WHERE employee_id = 100
    RETURNING employee_id, salary, job_id
    INTO ang; -- ang.cod_ang, ang.sal, ang.cod_job
    
    dbms_output.put_line(ang.cod_ang || ' ' || ang.sal
        || ' ' || ang.cod_job);
END;
/

SELECT * FROM emp_gid WHERE employee_id = 100;
rollback;

-- 3
DESC emp_gid;

DECLARE
    ang1 emp_gid%ROWTYPE;
    ang2 emp_gid%ROWTYPE;
BEGIN
    DELETE FROM emp_gid
    WHERE employee_id = 100
    RETURNING employee_id, first_name, last_name, email,
              phone_number, hire_date, job_id, salary,
              commission_pct, manager_id, department_id
    INTO ang1;
    
    INSERT INTO emp_gid
    VALUES ang1;
    
    DELETE FROM emp_gid
    WHERE employee_id = 101;
    
    SELECT * INTO ang2
    FROM employees
    WHERE employee_id = 101;
    
    INSERT INTO emp_gid
    VALUES (1000, 'Prenume', 'Nume', 'Email', null, sysdate,
            'Job', 10000, null, null, null);
    
    UPDATE emp_gid
    SET ROW = ang2
    WHERE employee_id = 1000;
END;
/

SELECT * FROM emp_gid
WHERE employee_id IN (100, 101);

-- 4

DECLARE
    TYPE tab_idx IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
    t tab_idx;
BEGIN  
    FOR i IN 1..10 LOOP
        t(i) := i;
    END LOOP;
    
    dbms_output.put_line(t.count);
    FOR i IN t.first..t.last LOOP
        dbms_output.put(t(i) || ' ');
    END LOOP;
    dbms_output.new_line;
    
    FOR i IN t.first..t.last LOOP
        IF i MOD 2 = 1 THEN
            t(i) := null;
        END IF;
    END LOOP;
    
    dbms_output.put_line(t.count);
    FOR i IN t.first..t.last LOOP
        dbms_output.put(nvl(to_char(t(i)), 'null') || ' ');
    END LOOP;
    dbms_output.new_line;
    
    t.delete(t.first);
    t.delete(5, 7);
    t.delete(t.last);
    
    dbms_output.put_line(t.first || ' ' 
        || nvl(to_char(t(t.first)), 'null'));
    dbms_output.put_line(t.last || ' ' 
        || nvl(to_char(t(t.last)), 'null'));
        
    dbms_output.put_line(t.count);
    FOR i IN t.first..t.last LOOP
        IF t.exists(i) THEN
            dbms_output.put(nvl(to_char(t(i)), 'null') || ' ');
        END IF;
    END LOOP;
    dbms_output.new_line;
    
    t.delete;
    dbms_output.put_line(t.count);
END;
/
    
-- 5

DECLARE
    TYPE tab_emp IS TABLE OF emp_gid%ROWTYPE
        INDEX BY PLS_INTEGER;
    t tab_emp;
BEGIN
    SELECT * BULK COLLECT INTO t
    FROM emp_gid
    WHERE rownum <= 2;
    
    FOR i IN t.first..t.last LOOP
        dbms_output.put_line(t(i).employee_id || 
            ' ' || t(i).last_name);
        DELETE FROM emp_gid
        WHERE employee_id = t(i).employee_id;
        INSERT INTO emp_gid
        VALUES t(i);
    END LOOP;
END;
/

DECLARE
    TYPE tab_emp IS TABLE OF emp_gid%ROWTYPE
        INDEX BY PLS_INTEGER;
    t tab_emp;
BEGIN
    DELETE FROM emp_gid
    WHERE rownum <= 2
    RETURNING employee_id, first_name, last_name, email,
              phone_number, hire_date, job_id, salary,
              commission_pct, manager_id, department_id
    BULK COLLECT INTO t;
    
    FOR i IN t.first..t.last LOOP
        dbms_output.put_line(t(i).employee_id || 
            ' ' || t(i).last_name);
    END LOOP;
    
    FOR i IN t.first..t.last LOOP
        INSERT INTO emp_gid
        VALUES t(i);
    END LOOP;
END;
/

rollback;

SELECT * FROM emp_gid;
SELECT * 
FROM emp_gid
WHERE employee_id IN (198, 199);


/*
Definiti un tablou indexat de perechi (employee_id, last_name) 
in care pe cheia n din tablou sa se afle id-ul si numele agajatului cu id-ul n.
Afisati continutul tabloului.
*/

-- Varianta 1
DECLARE
    TYPE emp_rec IS RECORD (employee_id employees.employee_id%TYPE,
                            last_name employees.last_name%TYPE);
    TYPE tab_emp IS TABLE OF emp_rec INDEX BY PLS_INTEGER;
    t_aux tab_emp;
    t tab_emp;
BEGIN
    SELECT employee_id, last_name 
    BULK COLLECT INTO t_aux 
    FROM employees;
    
    FOR i IN t_aux.first..t_aux.last LOOP
        t(t_aux(i).employee_id) := emp_rec(t_aux(i).employee_id, t_aux(i).last_name);
    END LOOP;
    
    FOR i IN t.first..t.last LOOP
        IF t.exists(i) THEN
            dbms_output.put_line(i || ' ' || t(i).employee_id || ' ' || t(i).last_name);
        END IF;
    END LOOP;
END;
/

-- Varianta 2
DECLARE
    TYPE emp_rec IS RECORD (employee_id employees.employee_id%TYPE,
                            last_name employees.last_name%TYPE);
    TYPE tab_emp IS TABLE OF emp_rec INDEX BY PLS_INTEGER;
    TYPE tab_nr IS TABLE OF employees.employee_id%TYPE INDEX BY PLS_INTEGER;
    ids tab_nr;
    t tab_emp;
BEGIN
    SELECT employee_id BULK COLLECT INTO ids FROM employees;
    
    FOR i IN ids.first..ids.last LOOP
        SELECT employee_id, last_name
        INTO t(ids(i))
        FROM employees
        WHERE employee_id = ids(i);
    END LOOP;
    
    FOR i IN t.first..t.last LOOP
        IF t.exists(i) THEN
            dbms_output.put_line(i || ' ' || t(i).employee_id || ' ' || t(i).last_name);
        END IF;
    END LOOP;
END;
/


-- 6

DECLARE
    TYPE tab_imb IS TABLE OF NUMBER;
    t tab_imb := tab_imb();
BEGIN  
    FOR i IN 1..10 LOOP
        t.extend;
        t(i) := i;
    END LOOP;
    
    dbms_output.put_line(t.count);
    FOR i IN t.first..t.last LOOP
        dbms_output.put(t(i) || ' ');
    END LOOP;
    dbms_output.new_line;
    
    FOR i IN t.first..t.last LOOP
        IF i MOD 2 = 1 THEN
            t(i) := null;
        END IF;
    END LOOP;
    
    dbms_output.put_line(t.count);
    FOR i IN t.first..t.last LOOP
        dbms_output.put(nvl(to_char(t(i)), 'null') || ' ');
    END LOOP;
    dbms_output.new_line;
    
    t.delete(t.first);
    t.delete(5, 7);
    t.delete(t.last);
    
    dbms_output.put_line(t.first || ' ' 
        || nvl(to_char(t(t.first)), 'null'));
    dbms_output.put_line(t.last || ' ' 
        || nvl(to_char(t(t.last)), 'null'));
        
    dbms_output.put_line(t.count);
    FOR i IN t.first..t.last LOOP
        IF t.exists(i) THEN
            dbms_output.put(nvl(to_char(t(i)), 'null') || ' ');
        END IF;
    END LOOP;
    dbms_output.new_line;
    
    t.delete;
    dbms_output.put_line(t.count);
END;
/

DECLARE
    TYPE tab_chr IS TABLE OF CHAR(1);
    t tab_chr := tab_chr('m', 'a', 'x', 'i', 'm');
    j INTEGER;
BEGIN
    FOR i IN t.first..t.last LOOP
        dbms_output.put(t(i));
    END LOOP;
    dbms_output.new_line;
    
    FOR i IN REVERSE t.first..t.last LOOP
        dbms_output.put(t(i));
    END LOOP;
    dbms_output.new_line;
    
    t.delete(2);
    t.delete(4);
    
    j := t.first;
    WHILE j IS NOT NULL LOOP
        dbms_output.put(t(j));
        j := t.next(j);
    END LOOP;
    dbms_output.new_line;
    
    j := t.last;
    WHILE j IS NOT NULL LOOP
        dbms_output.put(t(j));
        j := t.prior(j);
    END LOOP;
    dbms_output.new_line;
END;
/

-- 8

DECLARE
    TYPE vec IS VARRAY(20) OF NUMBER;
    t vec := vec();
BEGIN  
    FOR i IN 1..10 LOOP
        t.extend;
        t(i) := i;
    END LOOP;
    
    dbms_output.put_line(t.count);
    FOR i IN t.first..t.last LOOP
        dbms_output.put(t(i) || ' ');
    END LOOP;
    dbms_output.new_line;
    
    FOR i IN t.first..t.last LOOP
        IF i MOD 2 = 1 THEN
            t(i) := null;
        END IF;
    END LOOP;
    
    dbms_output.put_line(t.count);
    FOR i IN t.first..t.last LOOP
        dbms_output.put(nvl(to_char(t(i)), 'null') || ' ');
    END LOOP;
    dbms_output.new_line;
    
--    t.delete(t.first);
--    t.delete(5, 7);
    t.trim;
    
    dbms_output.put_line(t.first || ' ' 
        || nvl(to_char(t(t.first)), 'null'));
    dbms_output.put_line(t.last || ' ' 
        || nvl(to_char(t(t.last)), 'null'));
        
    dbms_output.put_line(t.count);
    FOR i IN t.first..t.last LOOP
        IF t.exists(i) THEN
            dbms_output.put(nvl(to_char(t(i)), 'null') || ' ');
        END IF;
    END LOOP;
    dbms_output.new_line;
    
    t.delete;
    dbms_output.put_line(t.count);
END;
/

-- 9

CREATE OR REPLACE TYPE subordonati_gid IS 
VARRAY(10) OF NUMBER;
/

CREATE TABLE manageri_gid (cod_mgr NUMBER(10),
                           nume VARCHAR2(20),
                           lista subordonati_gid);
                           
DECLARE
    sub subordonati_gid := subordonati_gid(100, 200, 300);
    lst manageri_gid.lista%TYPE;
BEGIN
    INSERT INTO manageri_gid
    VALUES (1, 'Mgr 1', sub);
    
    INSERT INTO manageri_gid
    VALUES (2, 'Mgr 2', null);
    
    INSERT INTO manageri_gid
    VALUES (3, 'Mgr 3', subordonati_gid(400, 500));

    SELECT lista INTO lst
    FROM manageri_gid
    WHERE cod_mgr = 1;
    
    FOR i IN lst.first..lst.last LOOP
        dbms_output.put_line(lst(i));
    END LOOP;
END;
/

SELECT * FROM manageri_gid;

DROP TABLE manageri_gid;
DROP TYPE subordonati_gid;

-- 10

CREATE TABLE emp_test_gid AS 
SELECT employee_id, last_name FROM employees
WHERE rownum <= 2;

CREATE OR REPLACE TYPE tip_tel_gid IS TABLE OF VARCHAR2(12);
/

ALTER TABLE emp_test_gid
ADD (telefon tip_tel_gid)
NESTED TABLE telefon STORE AS tabel_tel_gid;

SELECT * FROM emp_test_gid;

INSERT INTO emp_test_gid
VALUES (500, 'Nume', tip_tel_gid('12345', '67890'));

UPDATE emp_test_gid
SET telefon = tip_tel_gid('222', '333', '444')
WHERE employee_id = 198;

SELECT a.employee_id, b.*
FROM emp_test_gid a, TABLE(a.telefon) b;

SELECT a.employee_id, b.COLUMN_VALUE
FROM emp_test_gid a, TABLE(a.telefon) b;

DROP TABLE emp_test_gid;
DROP TYPE tip_tel_gid;

-- 11

DECLARE
    TYPE vec IS VARRAY(10) OF emp_gid.employee_id%TYPE;
    coduri vec := vec(205, 206);
BEGIN
    FOR i IN coduri.first..coduri.last LOOP
        DELETE FROM emp_gid
        WHERE employee_id = coduri(i);
    END LOOP;
END;
/

rollback;
SELECT * FROM emp_gid WHERE employee_id IN (205, 206);

DECLARE
    TYPE vec IS VARRAY(10) OF emp_gid.employee_id%TYPE;
    coduri vec := vec(205, 206);
BEGIN
    FORALL i IN coduri.first..coduri.last
        DELETE FROM emp_gid
        WHERE employee_id = coduri(i);
END;
/

-- Tema T3 - Ex E2 din fisierul Laborator PLSQL 2.pdf
-- Deadline - miercuri 12.11.2025 ora 21:59

