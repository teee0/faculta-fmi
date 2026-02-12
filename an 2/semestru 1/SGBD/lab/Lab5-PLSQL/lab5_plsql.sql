-- Lab 5 PLSQL

-- Pachete definite de utilizator

-- 1

CREATE OR REPLACE PACKAGE pachet1_gid IS
    FUNCTION nr(cod_dept employees.department_id%TYPE)
    RETURN NUMBER;
    FUNCTION sal(cod_dept employees.department_id%TYPE)
    RETURN NUMBER;
END;
/

CREATE OR REPLACE PACKAGE BODY pachet1_gid IS
    FUNCTION nr(cod_dept employees.department_id%TYPE)
    RETURN NUMBER
    IS
        rez NUMBER;
    BEGIN
        SELECT COUNT(*) INTO rez
        FROM employees
        WHERE department_id = cod_dept;
        RETURN rez;
    END;
    
    FUNCTION sal(cod_dept employees.department_id%TYPE)
    RETURN NUMBER
    IS
        rez NUMBER;
    BEGIN
        SELECT SUM(salary + salary * NVL(commission_pct, 0))
        INTO rez
        FROM employees
        WHERE department_id = cod_dept;
        RETURN rez;
    END;
END;
/

SELECT pachet1_gid.nr(80), pachet1_gid.sal(80)
FROM dual;

-- 2

DESC dept_gid;

CREATE SEQUENCE emp_seq_gid START WITH 300;

CREATE OR REPLACE PACKAGE pachet2_gid IS
    PROCEDURE add_dept(cod dept_gid.department_id%TYPE,
                       nume dept_gid.department_name%TYPE,
                       mgr_id dept_gid.manager_id%TYPE,
                       loc_id dept_gid.location_id%TYPE);
    PROCEDURE add_emp(v_first_name emp_gid.first_name%TYPE, 
                 v_last_name emp_gid.last_name%TYPE, 
                 v_email emp_gid.email%TYPE, 
                 v_phone_number emp_gid.phone_number%TYPE:=NULL,  
                 v_hire_date emp_gid.hire_date%TYPE :=SYSDATE,      
                 v_job_id emp_gid.job_id%TYPE,         
                 v_salary   emp_gid.salary%TYPE :=0,       
                 v_commission_pct emp_gid.commission_pct%TYPE:=0, 
                 v_manager_id emp_gid.manager_id%TYPE,    
                 v_department_id emp_gid.department_id%TYPE);
END;
/

CREATE OR REPLACE PACKAGE BODY pachet2_gid IS
    FUNCTION exista(mgr_id dept_gid.manager_id%TYPE,
                       loc_id dept_gid.location_id%TYPE)
    RETURN BOOLEAN
    IS
        rez BOOLEAN := true;
        nr_mgr NUMBER;
        nr_loc NUMBER;
    BEGIN
        SELECT COUNT(*) INTO nr_mgr 
        FROM employees
        WHERE employee_id = mgr_id;
        
        SELECT COUNT(*) INTO nr_loc
        FROM locations
        WHERE location_id = loc_id;
        
        IF nr_mgr = 0 OR nr_loc = 0 THEN
            rez := false;
        END IF;
        RETURN rez;
    END;
            
                       
    PROCEDURE add_dept(cod dept_gid.department_id%TYPE,
                       nume dept_gid.department_name%TYPE,
                       mgr_id dept_gid.manager_id%TYPE,
                       loc_id dept_gid.location_id%TYPE)
    IS
    BEGIN
        IF exista(mgr_id, loc_id) THEN
            INSERT INTO dept_gid
            VALUES (cod, nume, mgr_id, loc_id);
        ELSE
            dbms_output.put_line('Manager sau locatie inexistenta');
        END IF;
    END;
                       
    PROCEDURE add_emp(v_first_name emp_gid.first_name%TYPE, 
                 v_last_name emp_gid.last_name%TYPE, 
                 v_email emp_gid.email%TYPE, 
                 v_phone_number emp_gid.phone_number%TYPE:=NULL,  
                 v_hire_date emp_gid.hire_date%TYPE :=SYSDATE,      
                 v_job_id emp_gid.job_id%TYPE,         
                 v_salary   emp_gid.salary%TYPE :=0,       
                 v_commission_pct emp_gid.commission_pct%TYPE:=0, 
                 v_manager_id emp_gid.manager_id%TYPE,    
                 v_department_id emp_gid.department_id%TYPE)
    IS BEGIN
        INSERT INTO emp_gid 
        VALUES (emp_seq_gid.NEXTVAL, v_first_name, v_last_name, v_email, 
            v_phone_number,v_hire_date, v_job_id, v_salary, 
            v_commission_pct, v_manager_id,v_department_id);
    END;
END;
/

EXEC pachet2_gid.add_dept(1000, 'Test', 200, 2000);
BEGIN 
    pachet2_gid.add_emp('Prenume', 'Nume', 'Email', v_job_id => 'SA_MAN',
                        v_salary => 4000, v_manager_id => 100,
                        v_department_id  => 1000);
END;
/

SELECT * FROM dept_gid;
SELECT * FROM emp_gid;

rollback;

-- 3

CREATE OR REPLACE PACKAGE pachet3_gid
IS
    CURSOR c_emp(nr NUMBER) RETURN employees%ROWTYPE;
    FUNCTION max_sal(oras locations.city%TYPE) 
    RETURN employees.salary%TYPE;
END;
/

CREATE OR REPLACE PACKAGE BODY pachet3_gid
IS
    CURSOR c_emp(nr NUMBER) RETURN employees%ROWTYPE
        IS SELECT *
           FROM employees
           WHERE salary > nr;
           
    FUNCTION max_sal(oras locations.city%TYPE) 
    RETURN employees.salary%TYPE
    IS
        rez employees.salary%TYPE;
    BEGIN
        SELECT MAX(salary) INTO rez
        FROM employees e, departments d, locations l
        WHERE e.department_id = d.department_id
        AND d.location_id = l.location_id
        AND lower(city) = lower(oras);
        
        RETURN rez;
    END;
END;
/

BEGIN
    FOR i IN pachet3_gid.c_emp(pachet3_gid.max_sal('Toronto')) LOOP
        dbms_output.put_line(i.employee_id || ' ' || i.last_name || ' ' 
            || i.salary);
    END LOOP;
END;
/

-- Pachete predefinite

-- 1

DECLARE
-- paramentrii de tip OUT pt procedura GET_LINE 
    linie1 VARCHAR2(255); 
    stare1 INTEGER; 
    linie2 VARCHAR2(255); 
    stare2 INTEGER; 
    linie3 VARCHAR2(255); 
    stare3 INTEGER; 
 
    v_emp  employees.employee_id%TYPE; 
    v_job  employees.job_id%TYPE; 
    v_dept employees.department_id%TYPE;    
BEGIN 
    SELECT employee_id, job_id, department_id 
    INTO   v_emp,v_job,v_dept 
    FROM   employees 
    WHERE  last_name='Lorentz'; 
 -- se introduce o linie in buffer fara caracter  -- de terminare linie 
    DBMS_OUTPUT.PUT(' 1 '||v_emp|| ' '); 
 -- se incearca extragerea liniei introdusa  -- in buffer si starea acesteia 
    DBMS_OUTPUT.GET_LINE(linie1,stare1);  
 -- se depunde informatie pe aceeasi linie in buffer 
    DBMS_OUTPUT.PUT(' 2 '||v_job|| ' '); 
 -- se inchide linia depusa in buffer si se extrage  -- linia din buffer 
    DBMS_OUTPUT.NEW_LINE; 
    DBMS_OUTPUT.GET_LINE(linie2,stare2);  
 -- se introduc informatii pe aceeasi linie  -- si se afiseaza informatia 
    DBMS_OUTPUT.PUT_LINE(' 3 ' ||v_emp|| ' '|| v_job); 
    DBMS_OUTPUT.GET_LINE(linie3,stare3);  
 -- se afiseaza ceea ce s-a extras 
    DBMS_OUTPUT.PUT_LINE('linie1 = '|| linie1|| 
                         '; stare1 = '||stare1); 
    DBMS_OUTPUT.PUT_LINE('linie2 = '|| linie2|| 
                         '; stare2 = '||stare2); 
    DBMS_OUTPUT.PUT_LINE('linie3 = '|| linie3|| 
                         '; stare3 = '||stare3); 
END; 
/  

DECLARE
-- parametru de tip OUT pentru NEW_LINES   -- tablou de siruri de caractere 
    linii DBMS_OUTPUT.CHARARR; -- paramentru de tip IN OUT pentru NEW_LINES 
    nr_linii INTEGER; 
 
    v_emp  employees.employee_id%TYPE; 
    v_job  employees.job_id%TYPE; 
    v_dept employees.department_id%TYPE; 
BEGIN 
    SELECT employee_id, job_id, department_id 
    INTO   v_emp,v_job,v_dept 
    FROM   employees 
    WHERE  last_name='Lorentz'; 
 -- se mareste dimensiunea bufferului  
    DBMS_OUTPUT.ENABLE(1000000); 
    DBMS_OUTPUT.PUT(' 1 '||v_emp|| ' '); 
    DBMS_OUTPUT.PUT(' 2 '||v_job|| ' '); 
    DBMS_OUTPUT.NEW_LINE; 
    DBMS_OUTPUT.PUT_LINE(' 3 ' ||v_emp|| ' '|| v_job); 
    DBMS_OUTPUT.PUT_LINE(' 4 ' ||v_emp|| ' '||  
                         v_job||' ' ||v_dept); -- se afiseaza ceea ce s-a extras 
    nr_linii := 4; 
    DBMS_OUTPUT.GET_LINES(linii,nr_linii);  
    DBMS_OUTPUT.put_line('In buffer sunt '||  
                          nr_linii ||' linii'); 
    FOR i IN 1..nr_linii LOOP 
        DBMS_OUTPUT.put_line(linii(i)); 
    END LOOP; 
   
    nr_linii := 4; 
    DBMS_OUTPUT.GET_LINES(linii,nr_linii);  
    DBMS_OUTPUT.put_line('Acum in buffer sunt '|| nr_linii ||' linii'); 
    FOR i IN 1..nr_linii LOOP 
        DBMS_OUTPUT.put_line(linii(i)); 
    END LOOP; 
END; 
/

-- 2

CREATE OR REPLACE PROCEDURE marire_sal_gid
    (ang employees.employee_id%TYPE,
     val NUMBER)
IS
BEGIN
    UPDATE emp_gid
    SET salary = salary + val
    WHERE employee_id = ang;
END;
/

VAR nr_job NUMBER;

BEGIN
    dbms_job.submit(JOB => :nr_job,
                    WHAT => 'marire_sal_gid(100, 1000);',
                    NEXT_DATE => sysdate + 10/86400,
                    INTERVAL => 'SYSDATE+1');
    commit;
END;
/

SELECT * FROM emp_gid
WHERE employee_id = 100;

PRINT nr_job;

BEGIN
    dbms_job.run(145);
END;
/

BEGIN
    dbms_job.remove(job => 145);
END;
/

SELECT * FROM user_jobs;

UPDATE emp_gid SET salary = 24000 WHERE employee_id = 100;
commit;

-- 3

CREATE OR REPLACE PROCEDURE scriu_fisier_gid 
 (director VARCHAR2, 
  fisier VARCHAR2) 
IS 
    v_file UTL_FILE.FILE_TYPE; 
    CURSOR cursor_rez IS 
        SELECT department_id departament, SUM(salary) suma 
        FROM employees 
        GROUP BY department_id 
        ORDER BY SUM(salary); 
    v_rez cursor_rez%ROWTYPE; 
BEGIN 
    v_file:=UTL_FILE.FOPEN(director, fisier, 'w'); 
    UTL_FILE.PUTF(v_file, 'Suma salariilor pe departamente \n Raport generat pe data  '); 
    UTL_FILE.PUT(v_file, SYSDATE); 
    UTL_FILE.NEW_LINE(v_file); 
    OPEN cursor_rez; 
    LOOP 
        FETCH cursor_rez INTO v_rez; 
        EXIT WHEN cursor_rez%NOTFOUND; 
        UTL_FILE.NEW_LINE(v_file); 
        UTL_FILE.PUT(v_file, v_rez.departament); 
        UTL_FILE.PUT(v_file, '         '); 
        UTL_FILE.PUT(v_file, v_rez.suma); 
    END LOOP; 
    CLOSE cursor_rez; 
    UTL_FILE.FCLOSE(v_file); 
END; 
/ 

EXECUTE scriu_fisier_gid('C:\Users\Ioana\Desktop\Laboratoare SGBD\','test.txt');


-- Tema T8 - Ex E1 din fisierul Laborator PLSQL 5.pdf
-- Deadline - miercuri 10.12.2025 ora 21:59
