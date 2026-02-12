-- Lab 1 PLSQL

-- 1

-- a
DECLARE
    nume VARCHAR2(35); 
    prenume VARCHAR2(35);
BEGIN
    null;
END;
/

-- b
DECLARE
    nr NUMBER(5);
BEGIN
    null;
END;
/

-- c
DECLARE
    nr NUMBER(5, 2) := 10;
BEGIN
    null;
END;
/

-- d
DECLARE
    tst BOOLEAN := true;
BEGIN
    null;
END;
/

-- e
DECLARE
    v1 NUMBER := 10;
    v2 NUMBER := 15;
    v3 BOOLEAN := v1 < v2;
BEGIN
    null;
END;
/

-- 2

<<principal>>
DECLARE  
  v_client_id     NUMBER(4):= 1600; 
  v_client_nume   VARCHAR2(50):= 'N1'; 
  v_nou_client_id NUMBER(3):= 500; 
BEGIN 
 <<secundar>> 
 DECLARE 
   v_client_id       NUMBER(4) := 0; 
   v_client_nume     VARCHAR2(50) := 'N2'; 
   v_nou_client_id   NUMBER(3) := 300; 
   v_nou_client_nume VARCHAR2(50) := 'N3'; 
 BEGIN 
   v_client_id:= v_nou_client_id; 
   principal.v_client_nume:=  
             v_client_nume ||' '|| v_nou_client_nume; 
   --pozi?ia 1 
   dbms_output.put_line(v_client_id);
   dbms_output.put_line(v_client_nume);
   dbms_output.put_line(v_nou_client_id);
   dbms_output.put_line(v_nou_client_nume);
   -- 300
   -- N2
   -- 300
   -- N3
 END; 
 v_client_id:= (v_client_id *12)/10; 
 --pozi?ia 2 
 dbms_output.put_line(v_client_id);
dbms_output.put_line(v_client_nume);
 -- 1920
 -- N2 N3
END; 
/ 

-- 3

-- a
VARIABLE mesaj VARCHAR2(50)

BEGIN
    :mesaj := 'Invat PL/SQL';
END;
/

PRINT mesaj

-- b

BEGIN
    dbms_output.put_line('Invat PL/SQL');
END;
/

-- 4

DECLARE
    dept departments.department_name%TYPE;
BEGIN
    SELECT department_name 
    INTO dept
    FROM departments d, employees e
    WHERE d.department_id = e.department_id
    GROUP BY department_name
    HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                       FROM employees
                       GROUP BY department_id);
    dbms_output.put_line(dept);
END;
/

DECLARE
    dept departments.department_name%TYPE;
BEGIN
    SELECT department_name 
    INTO dept
    FROM departments d, employees e
    WHERE d.department_id = e.department_id
    GROUP BY department_name
    HAVING COUNT(*) = (SELECT MIN(COUNT(*))
                       FROM employees
                       GROUP BY department_id);
    dbms_output.put_line(dept);
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        dbms_output.put_line('Mai multe departamente');
END;
/

DECLARE
    dept departments.department_name%TYPE;
    nr NUMBER;
BEGIN
    SELECT COUNT(*) INTO nr
    FROM
    (SELECT department_name 
    FROM departments d, employees e
    WHERE d.department_id = e.department_id
    GROUP BY department_name
    HAVING COUNT(*) = (SELECT MIN(COUNT(*))
                       FROM employees
                       GROUP BY department_id));
                       
    IF nr > 1 THEN
        dbms_output.put_line('Mai multe departamente');
        GOTO fin;
    END IF;


    SELECT department_name 
    INTO dept
    FROM departments d, employees e
    WHERE d.department_id = e.department_id
    GROUP BY department_name
    HAVING COUNT(*) = (SELECT MIN(COUNT(*))
                       FROM employees
                       GROUP BY department_id);
    dbms_output.put_line(dept);
    
    <<fin>>
    null;
END;
/

-- 5

VARIABLE nume_dept VARCHAR2(35)

BEGIN
    SELECT department_name 
    INTO :nume_dept
    FROM departments d, employees e
    WHERE d.department_id = e.department_id
    GROUP BY department_name
    HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                       FROM employees
                       GROUP BY department_id);
    dbms_output.put_line(:nume_dept);
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        dbms_output.put_line('Mai multe departamente');
END;
/

PRINT nume_dept

-- 6

VARIABLE nume_dept VARCHAR2(35)
VARIABLE nr NUMBER

BEGIN
    SELECT department_name, COUNT(*)
    INTO :nume_dept, :nr
    FROM departments d, employees e
    WHERE d.department_id = e.department_id
    GROUP BY department_name
    HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                       FROM employees
                       GROUP BY department_id);
    dbms_output.put_line(:nume_dept);
    dbms_output.put_line(:nr);
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        dbms_output.put_line('Mai multe departamente');
END;
/

PRINT nume_dept
PRINT nr

-- 7

DECLARE
    ang_id employees.employee_id%TYPE := &id;
    salariu NUMBER;
    bonus NUMBER;
BEGIN
    SELECT salary * 12 INTO salariu
    FROM employees
    WHERE employee_id = ang_id;
    
    IF salariu >= 200001 THEN
        bonus := 20000;
    ELSIF salariu BETWEEN 100001 AND 200000 THEN
        bonus := 10000;
    ELSE
        bonus := 5000;
    END IF;
    
    dbms_output.put_line(bonus);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('Nu exista angajat cu codul ' || ang_id);
    WHEN OTHERS THEN
        dbms_output.put_line('Alta eroare');
END;
/

SELECT employee_id, salary * 12
FROM employees;

-- 8

DECLARE
    ang_id employees.employee_id%TYPE := &id;
    salariu NUMBER;
    bonus NUMBER;
BEGIN
    SELECT salary * 12 INTO salariu
    FROM employees
    WHERE employee_id = ang_id;
    
    CASE
        WHEN salariu >= 200001 THEN
            bonus := 20000;
        WHEN salariu BETWEEN 100001 AND 200000 THEN
            bonus := 10000;
        ELSE
            bonus := 5000;
    END CASE;
    
    dbms_output.put_line(bonus);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('Nu exista angajat cu codul ' || ang_id);
    WHEN OTHERS THEN
        dbms_output.put_line('Alta eroare');
END;
/

-- 9

-- CREATE TABLE emp_*** AS SELECT * FROM employees;

DEFINE cod_sal = 200
DEFINE cod_dept = 80
DEFINE procent = 20
DECLARE 
    cod_ang emp_gid.employee_id%TYPE := &cod_sal;
    dept emp_gid.department_id%TYPE := &cod_dept;
    proc NUMBER := &procent;
BEGIN
    UPDATE emp_gid
    SET department_id = dept,
        salary = salary + (salary * proc/100)
    WHERE employee_id = cod_ang;
    
    IF SQL%ROWCOUNT = 0 THEN
        dbms_output.put_line('Nu exista un angajat cu acest cod');
    ELSE
        dbms_output.put_line('Actualizare realizata');
    END IF;
END;
/

SELECT * FROM emp_gid WHERE employee_id = 200;
rollback;

-- 10

CREATE TABLE zile_gid
(id NUMBER,
 data DATE,
 nume_zi VARCHAR2(20));
 
DECLARE
    v_data DATE;
    contor NUMBER := 1;
    maxim NUMBER := LAST_DAY(sysdate) - sysdate;
BEGIN
    LOOP
        v_data := sysdate + contor;
        INSERT INTO zile_gid
        VALUES (contor, v_data, TO_CHAR(v_data, 'Day'));
        contor := contor + 1;
        EXIT WHEN contor > maxim;
    END LOOP;
END;
/

ALTER SESSION SET NLS_LANGUAGE = 'ROMANIAN';
ALTER SESSION SET NLS_LANGUAGE = 'ENGLISH';

SELECT * FROM zile_gid;
rollback;
    
-- 11

DECLARE
    v_data DATE;
    contor NUMBER := 1;
    maxim NUMBER := LAST_DAY(sysdate) - sysdate;
BEGIN
    WHILE contor <= maxim LOOP
        v_data := sysdate + contor;
        INSERT INTO zile_gid
        VALUES (contor, v_data, TO_CHAR(v_data, 'Day'));
        contor := contor + 1;
    END LOOP;
END;
/

SELECT * FROM zile_gid;
rollback;

-- 12

DECLARE
    v_data DATE;
    maxim NUMBER := LAST_DAY(sysdate) - sysdate;
BEGIN
    FOR contor IN 1..maxim LOOP
        v_data := sysdate + contor;
        INSERT INTO zile_gid
        VALUES (contor, v_data, TO_CHAR(v_data, 'Day'));
    END LOOP;
END;
/

SELECT * FROM zile_gid;
rollback;
    
-- 13

DECLARE
    i POSITIVE := 1;
    max_loop CONSTANT POSITIVE := 10;
BEGIN
    LOOP
        i := i+1;
        IF i > max_loop THEN
            dbms_output.put_line(i);
            GOTO urmator;
        END IF;
    END LOOP;
    <<urmator>>
    i := 1;
    dbms_output.put_line(i);
END;
/

DECLARE
    i POSITIVE := 1;
    max_loop CONSTANT POSITIVE := 10;
BEGIN
    LOOP
        i := i+1;
        dbms_output.put_line(i);
        EXIT WHEN i > max_loop;
    END LOOP;
    i := 1;
    dbms_output.put_line(i);
END;
/
    

-- Tema T2 - Ex E3 din fisierul Laborator PLSQL 1.pdf
-- Deadline - miercuri 29.10.2025 ora 21:59


