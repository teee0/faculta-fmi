-- Lab 4 PLSQL

-- 1

DECLARE
    nume employees.last_name%TYPE := INITCAP('&nume');
    FUNCTION f1 RETURN employees.salary%TYPE
    IS 
        rez employees.salary%TYPE;
    BEGIN
        SELECT salary INTO rez
        FROM employees
        WHERE last_name = nume;
        
        RETURN rez;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('Niciun angajat');
            RETURN -1;
        WHEN TOO_MANY_ROWS THEN
            dbms_output.put_line('Mai multe linii');
            RETURN -1;
    END;
BEGIN
    IF f1 >= 0 THEN
        dbms_output.put_line(f1);
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(SQLCODE || ' ' || SQLERRM);
END;
/

-- 2

CREATE OR REPLACE FUNCTION f2_gid(nume employees.last_name%TYPE)
RETURN employees.salary%TYPE
    IS 
        rez employees.salary%TYPE;
    BEGIN
        SELECT salary INTO rez
        FROM employees
        WHERE last_name = nume;
        
        RETURN rez;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20000, 'Niciun angajat');
        WHEN TOO_MANY_ROWS THEN
            RAISE_APPLICATION_ERROR(-20001, 'Mai multi angajati');
END;
/

BEGIN
    dbms_output.put_line(f2_gid('Bell'));
END;
/

SELECT f2_gid('Bell') FROM dual;

VAR sal NUMBER;
EXEC :sal := f2_gid('King');
PRINT sal;

-- 3

-- varianta 1 (fara parametru OUT)
DECLARE
    nume employees.last_name%TYPE := INITCAP('&nume');
    PROCEDURE p3
    IS 
        rez employees.salary%TYPE;
    BEGIN
        SELECT salary INTO rez
        FROM employees
        WHERE last_name = nume;
        
        dbms_output.put_line(rez);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('Niciun angajat');
        WHEN TOO_MANY_ROWS THEN
            dbms_output.put_line('Mai multe linii');
    END;
BEGIN
    p3;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(SQLCODE || ' ' || SQLERRM);
END;
/

-- varianta 2 (cu parametru OUT)
DECLARE
    nume employees.last_name%TYPE := INITCAP('&nume');
    rez employees.salary%TYPE;
    PROCEDURE p3(sal OUT employees.salary%TYPE)
    IS 
    BEGIN
        SELECT salary INTO sal
        FROM employees
        WHERE last_name = nume;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20000, 'Niciun angajat');
        WHEN TOO_MANY_ROWS THEN
            RAISE_APPLICATION_ERROR(-20001, 'Mai multi angajati');
    END;
BEGIN
    p3(rez);
    dbms_output.put_line(rez);
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(SQLCODE || ' ' || SQLERRM);
END;
/

-- 4

-- varianta 1 (fara parametru OUT)
CREATE OR REPLACE PROCEDURE p4_gid(nume employees.last_name%TYPE)
    IS 
        rez employees.salary%TYPE;
    BEGIN
        SELECT salary INTO rez
        FROM employees
        WHERE last_name = nume;
        
        dbms_output.put_line(rez);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20000, 'Niciun angajat');
        WHEN TOO_MANY_ROWS THEN
            RAISE_APPLICATION_ERROR(-20001, 'Mai multi angajati');
END;
/

BEGIN
    p4_gid('Bell');
END;
/

EXEC p4_gid('Bell');

-- varianta 2 (cu parametru OUT)
CREATE OR REPLACE PROCEDURE p4_gid
    (nume employees.last_name%TYPE DEFAULT 'Bell',
     sal OUT employees.salary%TYPE)
    IS 
    BEGIN
        SELECT salary INTO sal
        FROM employees
        WHERE last_name = nume;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20000, 'Niciun angajat');
        WHEN TOO_MANY_ROWS THEN
            RAISE_APPLICATION_ERROR(-20001, 'Mai multi angajati');
END;
/

DECLARE
    rez employees.salary%TYPE;
BEGIN
    p4_gid(sal => rez);
    dbms_output.put_line(rez);
END;
/

VAR rez NUMBER;
EXEC p4_gid('Bell', :rez);
PRINT rez;


-- 5

CREATE OR REPLACE PROCEDURE p5_gid
    (cod_ang IN OUT employees.employee_id%TYPE)
IS
BEGIN
    SELECT manager_id INTO cod_ang
    FROM employees
    WHERE employee_id = cod_ang;
END;
/

VAR ang NUMBER;
BEGIN
    :ang := 200;
    p5_gid(:ang);
END;
/
PRINT ang;

-- 6

DECLARE
    nume employees.last_name%TYPE;
    PROCEDURE p6
        (rezultat OUT employees.last_name%TYPE,
         comision IN employees.commission_pct%TYPE DEFAULT null,
         cod IN employees.employee_id%TYPE := null)
    IS
    BEGIN
        IF comision IS NOT NULL THEN
            SELECT last_name INTO rezultat
            FROM employees
            WHERE commission_pct = comision;
        ELSE
            SELECT last_name INTO rezultat
            FROM employees
            WHERE employee_id = cod;
        END IF;
    END;
BEGIN
    p6(nume, 0.4);
    dbms_output.put_line(nume);
    p6(nume, cod => 200);
    dbms_output.put_line(nume);
END;
/

-- 7

DECLARE
    FUNCTION f7(cod_dept employees.department_id%TYPE)
    RETURN NUMBER
    IS
        rez NUMBER;
    BEGIN   
        SELECT AVG(salary) INTO rez
        FROM employees
        WHERE department_id = cod_dept;
        RETURN rez;
    END;
    
    FUNCTION f7(cod_dept employees.department_id%TYPE,
                cod_job employees.job_id%TYPE)
    RETURN NUMBER
    IS
        rez NUMBER;
    BEGIN   
        SELECT AVG(salary) INTO rez
        FROM employees
        WHERE department_id = cod_dept
        AND job_id = cod_job;
        RETURN rez;
    END;
BEGIN
    dbms_output.put_line(f7(80));
    dbms_output.put_line(f7(80, 'SA_MAN'));
END;
/

-- 8

CREATE OR REPLACE FUNCTION factorial_gid(n NUMBER)
RETURN INTEGER
DETERMINISTIC
RESULT_CACHE
IS
BEGIN
    IF n = 0 THEN RETURN 1;
    ELSE RETURN n * factorial_gid(n-1);
    END IF;
END;
/

SELECT factorial_gid(10) FROM dual;

-- 9

CREATE OR REPLACE FUNCTION f9_gid
RETURN NUMBER
IS
    rez NUMBER;
BEGIN
    SELECT AVG(salary) INTO rez
    FROM employees;
    RETURN rez;
END;
/

SELECT * FROM user_objects
WHERE object_name LIKE '%GID'
AND object_type IN ('FUNCTION', 'PROCEDURE');

SELECT * FROM user_dependencies
WHERE name = 'F9_GID';

SELECT f9_gid FROM dual;

SELECT * FROM employees
WHERE salary > f9_gid;

DROP FUNCTION f9_gid;
DROP PROCEDURE p4_gid;


-- Tema T6 - Ex E4 (e nevoie si de crearea tabelului info_*** cu structura descrisa in E1) 
-- din fisierul Laborator PLSQL 4.pdf
-- Deadline - miercuri 26.11.2025 ora 21:59

-- Tema T7 - Ex E5
-- din fisierul Laborator PLSQL 4.pdf
-- Deadline - miercuri 03.12.2025 ora 21:59
