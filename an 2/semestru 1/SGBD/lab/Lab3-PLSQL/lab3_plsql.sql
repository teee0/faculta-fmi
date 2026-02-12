-- Lab 3 PLSQL

-- 1

DECLARE
    CURSOR c IS (SELECT department_name, COUNT(employee_id)
                 FROM departments d, employees e
                 WHERE d.department_id = e.department_id(+) 
                 -- AND 1=0
                 GROUP BY department_name);
--    dept departments.department_name%TYPE;
--    nr NUMBER;
    TYPE rec IS RECORD (dept departments.department_name%TYPE,
                        nr NUMBER);
    d rec;
BEGIN
    OPEN c;
    LOOP
        FETCH c INTO d;
        EXIT WHEN c%NOTFOUND;
        IF d.nr = 0 THEN
            dbms_output.put_line('In departamentul ' || d.dept ||
                ' nu lucreaza angajati');
        ELSIF d.nr = 1 THEN
            dbms_output.put_line('In departamentul ' || d.dept ||
                ' lucreaza un angajat');
        ELSE
            dbms_output.put_line('In departamentul ' || d.dept ||
                ' lucreaza ' || d.nr || ' angajati');
        END IF;
    END LOOP;
    
    IF c%ROWCOUNT = 0 THEN
        dbms_output.put_line('Nicio linie');
    END IF;
    
    CLOSE c;
END;
/

-- 2

DECLARE
    CURSOR c IS (SELECT department_name, COUNT(employee_id)
                 FROM departments d, employees e
                 WHERE d.department_id = e.department_id(+)
                 GROUP BY department_name);
    TYPE t_dept IS TABLE OF departments.department_name%TYPE;
    TYPE t_nr IS TABLE OF NUMBER;
    d t_dept;
    n t_nr;
BEGIN
    OPEN c;
    -- FETCH c BULK COLLECT INTO d, n; -- daca vrem sa incarcam toate liniile deodata
    LOOP
        FETCH c BULK COLLECT INTO d, n LIMIT 5;
        EXIT WHEN d.count = 0;
        FOR i IN d.first..d.last LOOP
            IF n(i) = 0 THEN
                dbms_output.put_line('In departamentul ' || d(i) ||
                    ' nu lucreaza angajati');
            ELSIF n(i) = 1 THEN
                dbms_output.put_line('In departamentul ' || d(i) ||
                    ' lucreaza un angajat');
            ELSE
                dbms_output.put_line('In departamentul ' || d(i) ||
                    ' lucreaza ' || n(i) || ' angajati');
            END IF;
        END LOOP;
    END LOOP;
    CLOSE c;
END;
/

-- 3

DECLARE
    CURSOR c IS (SELECT department_name dept, COUNT(employee_id) nr
                 FROM departments d, employees e
                 WHERE d.department_id = e.department_id(+) AND 1=0
                 GROUP BY department_name);
    contor NUMBER := 0;
BEGIN
    FOR i IN c LOOP
        contor := contor + 1;
        IF i.nr = 0 THEN
            dbms_output.put_line('In departamentul ' || i.dept ||
                ' nu lucreaza angajati');
        ELSIF i.nr = 1 THEN
            dbms_output.put_line('In departamentul ' || i.dept ||
                ' lucreaza un angajat');
        ELSE
            dbms_output.put_line('In departamentul ' || i.dept ||
                ' lucreaza ' || i.nr || ' angajati');
        END IF;
    END LOOP;
    
    IF contor = 0 THEN
        dbms_output.put_line('Nicio linie');
    END IF;
END;
/

-- 4

DECLARE
    contor NUMBER := 0;
BEGIN
    FOR i IN (SELECT department_name dept, COUNT(employee_id) nr
                 FROM departments d, employees e
                 WHERE d.department_id = e.department_id(+) 
                 -- AND 1=0
                 GROUP BY department_name) LOOP
        contor := contor + 1;
        IF i.nr = 0 THEN
            dbms_output.put_line('In departamentul ' || i.dept ||
                ' nu lucreaza angajati');
        ELSIF i.nr = 1 THEN
            dbms_output.put_line('In departamentul ' || i.dept ||
                ' lucreaza un angajat');
        ELSE
            dbms_output.put_line('In departamentul ' || i.dept ||
                ' lucreaza ' || i.nr || ' angajati');
        END IF;
    END LOOP;
    
    IF contor = 0 THEN
        dbms_output.put_line('Nicio linie');
    END IF;
END;
/

-- 5

-- primii 3/4
DECLARE
    CURSOR c IS 
        SELECT m.employee_id, m.last_name, COUNT(e.employee_id) nr
         FROM employees e, employees m
         WHERE e.manager_id = m.employee_id
         GROUP BY m.employee_id, m.last_name
         ORDER BY nr DESC;
    emp_id employees.employee_id%TYPE;
    nume employees.last_name%TYPE;
    n NUMBER;
BEGIN
    OPEN c;
    LOOP
        FETCH c INTO emp_id, nume, n;
        EXIT WHEN c%NOTFOUND OR c%ROWCOUNT > 4;
        dbms_output.put_line(emp_id || ' ' || nume || ' ' || n);
    END LOOP;
    CLOSE c;
END;
/
    
-- top 3 in PL/SQL
DECLARE
    CURSOR c IS 
        SELECT m.employee_id, m.last_name, COUNT(e.employee_id) nr
         FROM employees e, employees m
         WHERE e.manager_id = m.employee_id
         GROUP BY m.employee_id, m.last_name
         ORDER BY nr DESC;
    emp_id employees.employee_id%TYPE;
    nume employees.last_name%TYPE;
    n NUMBER;
    top NUMBER := 1;
    n_prev NUMBER;
BEGIN
    OPEN c;
    FETCH c INTO emp_id, nume, n_prev;
    dbms_output.put_line(emp_id || ' ' || nume || ' ' || n_prev);
    LOOP
        FETCH c INTO emp_id, nume, n;
        IF n <> n_prev THEN
            top := top + 1;
        END IF;
        EXIT WHEN c%NOTFOUND OR top = 4;
        dbms_output.put_line(emp_id || ' ' || nume || ' ' || n);
        n_prev := n;
    END LOOP;
    CLOSE c;
END;
/ 
    
-- top 3 in SQL
WITH aux AS (SELECT m.employee_id, m.last_name, COUNT(e.employee_id) nr
            FROM employees e, employees m
            WHERE e.manager_id = m.employee_id
            GROUP BY m.employee_id, m.last_name)
SELECT employee_id, last_name, nr
FROM aux a
WHERE 2 >= (SELECT COUNT(DISTINCT nr)
            FROM aux
            WHERE nr > a.nr)
ORDER BY nr DESC;
    
-- 6

DECLARE
    CURSOR c IS 
        SELECT m.employee_id, m.last_name, COUNT(e.employee_id) nr
         FROM employees e, employees m
         WHERE e.manager_id = m.employee_id
         GROUP BY m.employee_id, m.last_name
         ORDER BY nr DESC;
BEGIN
    FOR i IN c LOOP
        EXIT WHEN c%ROWCOUNT > 3;
        dbms_output.put_line(i.employee_id || ' ' 
            || i.last_name || ' ' || i.nr);
    END LOOP;
END;
/
    
-- 7

DECLARE
    contor NUMBER := 0;
BEGIN
    FOR i IN (SELECT m.employee_id, m.last_name, COUNT(e.employee_id) nr
         FROM employees e, employees m
         WHERE e.manager_id = m.employee_id
         GROUP BY m.employee_id, m.last_name
         ORDER BY nr DESC) LOOP
         contor := contor + 1;
         EXIT WHEN contor > 3;
        dbms_output.put_line(i.employee_id || ' ' 
            || i.last_name || ' ' || i.nr);
    END LOOP;
END;
/
    
-- 8

-- cursor explicit
DECLARE
    x NUMBER := &nr;
    CURSOR c(p NUMBER) IS 
            (SELECT department_name, COUNT(employee_id)
                 FROM departments d, employees e
                 WHERE d.department_id = e.department_id(+)
                 GROUP BY department_name
                 HAVING COUNT(employee_id) >= p);
    TYPE rec IS RECORD (dept departments.department_name%TYPE,
                        nr NUMBER);
    d rec;
BEGIN
    OPEN c(x);
    LOOP
        FETCH c INTO d;
        EXIT WHEN c%NOTFOUND;
        IF d.nr = 0 THEN
            dbms_output.put_line('In departamentul ' || d.dept ||
                ' nu lucreaza angajati');
        ELSIF d.nr = 1 THEN
            dbms_output.put_line('In departamentul ' || d.dept ||
                ' lucreaza un angajat');
        ELSE
            dbms_output.put_line('In departamentul ' || d.dept ||
                ' lucreaza ' || d.nr || ' angajati');
        END IF;
    END LOOP;
    
    IF c%ROWCOUNT = 0 THEN
        dbms_output.put_line('Nicio linie');
    END IF;
    
    CLOSE c;
END;
/

-- ciclu cursor
DECLARE
    x NUMBER := &nr;
    CURSOR c(p NUMBER) IS 
        (SELECT department_name dept, COUNT(employee_id) nr
                 FROM departments d, employees e
                 WHERE d.department_id = e.department_id(+)
                 GROUP BY department_name
                 HAVING COUNT(employee_id) >= p);
    contor NUMBER := 0;
BEGIN
    FOR i IN c(x) LOOP
        contor := contor + 1;
        IF i.nr = 0 THEN
            dbms_output.put_line('In departamentul ' || i.dept ||
                ' nu lucreaza angajati');
        ELSIF i.nr = 1 THEN
            dbms_output.put_line('In departamentul ' || i.dept ||
                ' lucreaza un angajat');
        ELSE
            dbms_output.put_line('In departamentul ' || i.dept ||
                ' lucreaza ' || i.nr || ' angajati');
        END IF;
    END LOOP;
    
    IF contor = 0 THEN
        dbms_output.put_line('Nicio linie');
    END IF;
END;
/

-- ciclu cursor cu subcereri
DECLARE
    x NUMBER := &nr;
    contor NUMBER := 0;
BEGIN
    FOR i IN (SELECT department_name dept, COUNT(employee_id) nr
                 FROM departments d, employees e
                 WHERE d.department_id = e.department_id(+)
                 GROUP BY department_name
                 HAVING COUNT(employee_id) >= x) LOOP
        contor := contor + 1;
        IF i.nr = 0 THEN
            dbms_output.put_line('In departamentul ' || i.dept ||
                ' nu lucreaza angajati');
        ELSIF i.nr = 1 THEN
            dbms_output.put_line('In departamentul ' || i.dept ||
                ' lucreaza un angajat');
        ELSE
            dbms_output.put_line('In departamentul ' || i.dept ||
                ' lucreaza ' || i.nr || ' angajati');
        END IF;
    END LOOP;
    
    IF contor = 0 THEN
        dbms_output.put_line('Nicio linie');
    END IF;
END;
/
    
-- 10

-- a
-- ciclu cursor
DECLARE
    CURSOR d IS SELECT department_id, department_name 
                FROM departments
                WHERE department_id IN (10, 20, 30, 40);
    CURSOR a(dept_id departments.department_id%TYPE)
        IS SELECT employee_id, last_name
           FROM employees
           WHERE department_id = dept_id;
BEGIN
    FOR i IN d LOOP
        dbms_output.put_line(i.department_name);
        dbms_output.put_line('-------------');
        FOR j IN a(i.department_id) LOOP
            dbms_output.put_line(j.last_name);
        END LOOP;
        dbms_output.new_line;
    END LOOP;
END;
/

-- b
DECLARE
    TYPE refcursor IS REF CURSOR; 
    c refcursor; -- SYS_REFCURSOR
    CURSOR d IS SELECT department_name,
                    CURSOR (SELECT last_name
                           FROM employees
                           WHERE department_id = d.department_id)
                FROM departments d
                WHERE department_id IN (10, 20, 30, 40);
    dept departments.department_name%TYPE;
    ang employees.last_name%TYPE;
BEGIN
    OPEN d;
    LOOP
        FETCH d INTO dept, c;
        EXIT WHEN d%NOTFOUND;
        dbms_output.put_line(dept);
        dbms_output.put_line('-------------');
        LOOP
            FETCH c INTO ang;
            EXIT WHEN c%NOTFOUND;
            dbms_output.put_line(ang);
        END LOOP;
        dbms_output.new_line;
    END LOOP;
    CLOSE d;
END;
/

-- 9

SELECT *
FROM emp_gid
WHERE TO_CHAR(hire_date,'yyyy') = 2000;

-- in sesiunea curenta
DECLARE
    CURSOR c IS SELECT *
        FROM emp_gid
        WHERE TO_CHAR(hire_date,'yyyy') = 2000
        FOR UPDATE OF salary WAIT 5;
BEGIN
    FOR i IN c LOOP
        UPDATE emp_gid
        SET salary = salary + 1000
        WHERE CURRENT OF c;
    END LOOP;
END;
/

rollback;

-- intr-o sesiune separata
UPDATE emp_gid
SET salary = salary;

rollback;

-- 11

DECLARE
    TYPE emp_tip IS REF CURSOR RETURN emp_gid%ROWTYPE;
    c emp_tip;
    opt NUMBER := &nr;
    ang emp_gid%ROWTYPE;
BEGIN
    IF opt = 1 THEN
        OPEN c FOR SELECT * FROM emp_gid;
    ELSIF opt = 2 THEN
        OPEN c FOR SELECT * FROM emp_gid
                   WHERE salary BETWEEN 10000 AND 20000;
    ELSIF opt = 3 THEN
        OPEN c FOR SELECT * FROM emp_gid
                   WHERE TO_CHAR(hire_date, 'yyyy') = 2000;
    END IF;
    
    IF c%ISOPEN THEN
        LOOP
            FETCH c INTO ang;
            EXIT WHEN c%NOTFOUND;
            dbms_output.put_line(ang.last_name);
        END LOOP;
        CLOSE c;
    ELSE
        dbms_output.put_line('Optiune invalida');
    END IF;
END;
/

-- 12

DECLARE
    c SYS_REFCURSOR;
    n NUMBER := &sal;
    ang employees%ROWTYPE;
BEGIN
    OPEN c FOR 'SELECT * FROM employees WHERE salary > :var'
    USING n;

    LOOP
        FETCH c INTO ang;
        EXIT WHEN c%NOTFOUND;
        IF ang.commission_pct IS NULL THEN
            dbms_output.put_line(ang.last_name || ' ' || ang.salary);
        ELSE
            dbms_output.put_line(ang.last_name || ' ' || ang.salary
                || ' ' || ang.commission_pct);
        END IF;
    END LOOP;
END;
/

        
-- Tema T4 - Ex E1 din fisierul Laborator PLSQL 3.pdf
-- Tema T5 - Ex E2 din fisierul Laborator PLSQL 3.pdf
-- Deadline (pentru ambele) - miercuri 19.11.2025 ora 21:59
