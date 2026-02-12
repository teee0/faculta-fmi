-- Lab 8 PLSQL

-- 1

CREATE OR REPLACE PROCEDURE sterg_gid(tabel VARCHAR2) IS
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE ' || tabel;
END;
/

CREATE TABLE tab_gid(a NUMBER);
SELECT * FROM tab_gid;
EXEC sterg_gid('tab_gid');

-- 2

CREATE OR REPLACE FUNCTION numar_gid(val NUMBER)
RETURN NUMBER
IS
    sir VARCHAR2(500);
    rez NUMBER;
BEGIN
    sir := 'SELECT COUNT(*) FROM emp_gid WHERE salary >= :x';
    EXECUTE IMMEDIATE sir
    INTO rez
    USING val;
    RETURN rez;
END;
/

SELECT numar_gid(10000) FROM dual;

-- 3

DECLARE
    sir VARCHAR2(100);
    bloc VARCHAR2(500);
BEGIN 
    EXECUTE IMMEDIATE 'CREATE TABLE tab_gid(col VARCHAR2(15))';
    FOR i IN 1..10 LOOP
        sir := 'INSERT INTO tab_gid VALUES (:x)';
        EXECUTE IMMEDIATE sir USING 'Contor' || i;
    END LOOP;
    bloc := 'BEGIN
                FOR i IN (SELECT * FROM tab_gid) LOOP
                    dbms_output.put_line(i.col);
                END LOOP;
             END;';
    EXECUTE IMMEDIATE bloc;
    EXECUTE IMMEDIATE 'DROP TABLE tab_gid';
END;
/

-- 4

CREATE OR REPLACE PACKAGE pac_gid IS
    FUNCTION f1 (conditie VARCHAR2) RETURN SYS_REFCURSOR;
    FUNCTION f2 (id_job emp_gid.job_id%TYPE) RETURN SYS_REFCURSOR;
END;
/

CREATE OR REPLACE PACKAGE BODY pac_gid IS
    FUNCTION f1 (conditie VARCHAR2) RETURN SYS_REFCURSOR
    IS 
        sir VARCHAR2(500);
        c SYS_REFCURSOR;
    BEGIN 
        sir := 'SELECT * FROM emp_gid ' || conditie;
        OPEN c FOR sir;
        RETURN c;
    END;
    
    FUNCTION f2 (id_job emp_gid.job_id%TYPE) RETURN SYS_REFCURSOR
    IS 
        sir VARCHAR2(500);
        c SYS_REFCURSOR;
    BEGIN 
        sir := 'SELECT * FROM emp_gid WHERE job_id = :x';
        OPEN c FOR sir USING id_job;
        RETURN c;
    END;
END;
/

DECLARE
    ang emp_gid%ROWTYPE;
    c SYS_REFCURSOR;
BEGIN
    c := pac_gid.f1('WHERE salary > 10000');
    LOOP
        FETCH c INTO ang;
        EXIT WHEN c%NOTFOUND;
        dbms_output.put_line(ang.last_name || ' ' || ang.salary);
    END LOOP;
    CLOSE c;
    
    dbms_output.put_line('----------------------------');
    
    c := pac_gid.f2('SA_MAN');
    LOOP
        FETCH c INTO ang;
        EXIT WHEN c%NOTFOUND;
        dbms_output.put_line(ang.last_name || ' ' || ang.job_id);
    END LOOP;
    CLOSE c;
END;
/

-- 5

DECLARE
    TYPE t_cod IS TABLE OF departments.department_id%TYPE;
    TYPE t_nume IS TABLE OF departments.department_name%TYPE;
    coduri t_cod;
    nume t_nume;
    c SYS_REFCURSOR;
BEGIN
    OPEN c FOR 'SELECT department_id, department_name
                FROM departments';
    FETCH c BULK COLLECT INTO coduri, nume;
    CLOSE c;
    
    FOR i IN coduri.first..coduri.last LOOP
        dbms_output.put_line(coduri(i) || ' ' || nume(i));
    END LOOP;
    
    dbms_output.put_line('-------------------------------');
    
    EXECUTE IMMEDIATE 'SELECT department_id, department_name
                       FROM departments'
    BULK COLLECT INTO coduri, nume;
    
    FOR i IN coduri.first..coduri.last LOOP
        dbms_output.put_line(coduri(i) || ' ' || nume(i));
    END LOOP;
END;
/
    
-- 6

DECLARE
    TYPE tablou IS TABLE OF emp_gid.last_name%TYPE;
    t tablou;
    sir VARCHAR2(500);
    val NUMBER := 1000;
BEGIN
    sir := 'UPDATE emp_gid SET salary = salary + :x
            WHERE job_id = ''SA_MAN''
            RETURNING last_name INTO :b';
    EXECUTE IMMEDIATE sir
    USING val
    RETURNING BULK COLLECT INTO t;
    
    FOR i IN t.first..t.last LOOP
        dbms_output.put_line(t(i));
    END LOOP;
END;
/
    
SELECT * FROM emp_gid WHERE job_id = 'SA_MAN';
rollback; 

DECLARE
    TYPE t_nume IS TABLE OF emp_gid.last_name%TYPE;
    nume t_nume;
    TYPE t_cod IS TABLE OF emp_gid.employee_id%TYPE;
    coduri t_cod;
BEGIN
    coduri := t_cod(110, 120, 130, 140);
    FORALL i IN coduri.first..coduri.last
        EXECUTE IMMEDIATE 'UPDATE emp_gid SET salary = salary * 1.1
                            WHERE employee_id = :1
                            RETURNING last_name INTO :2'
        USING coduri(i)
        RETURNING BULK COLLECT INTO nume;
    
    FOR i IN nume.first..nume.last LOOP
        dbms_output.put_line(nume(i));
    END LOOP;
END;
/

SELECT * FROM emp_gid WHERE employee_id IN (110, 120, 130, 140);
rollback;

