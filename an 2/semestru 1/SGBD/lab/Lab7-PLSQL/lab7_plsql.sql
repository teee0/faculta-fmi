-- Lab 7 PLSQL

-- 1

DECLARE  
    v NUMBER; 
    CURSOR c IS 
        SELECT employee_id FROM employees; 
BEGIN  
    SELECT employee_id  
    INTO v 
    FROM employees 
    WHERE employee_id = 100;
    
    SELECT employee_id 
    INTO v 
    FROM employees
    WHERE employee_id = 100; 
    
    SELECT employee_id 
    INTO v 
    FROM employees
    WHERE employee_id = 100; 

    v := 4; 

    open c;  
EXCEPTION 
    WHEN NO_DATA_FOUND THEN  
        DBMS_OUTPUT.PUT_LINE (' no data found: ' ||SQLCODE || ' - ' || 
                                SQLERRM); 
    WHEN TOO_MANY_ROWS THEN  
        DBMS_OUTPUT.PUT_LINE (' too many rows:  ' ||SQLCODE || ' - ' 
                                || SQLERRM); 
    WHEN INVALID_NUMBER THEN  
        DBMS_OUTPUT.PUT_LINE (' invalid number: ' ||SQLCODE || ' - ' 
                                || SQLERRM); 
    WHEN CURSOR_ALREADY_OPEN THEN 
        DBMS_OUTPUT.PUT_LINE (' cursor already open: ' ||SQLCODE || ' - ' || SQLERRM); 
    WHEN OTHERS THEN  
        DBMS_OUTPUT.PUT_LINE (SQLCODE || ' - ' || SQLERRM); 
 END; 
/ 

-- 2

CREATE TABLE error_gid
(cod NUMBER,
 mesaj VARCHAR2(100));
 
-- Varianta 1

DECLARE
    cod NUMBER;
    mesaj VARCHAR2(100);
    x NUMBER;
    impartire_zero EXCEPTION;
BEGIN
    x := 1;
    IF x = 1 THEN
        RAISE impartire_zero;
    ELSE
        x := x/(x-1);
    END IF;
EXCEPTION
    WHEN impartire_zero THEN
        cod := -20000;
        mesaj := 'Impartire la zero';
        INSERT INTO error_gid
        VALUES (cod, mesaj);
END;
/

-- Varianta 2

DECLARE
    cod NUMBER;
    mesaj VARCHAR2(100);
    x NUMBER;
BEGIN
    x := 1;
    x := x/(x-1);
EXCEPTION
    WHEN ZERO_DIVIDE THEN
        cod := SQLCODE;
        mesaj := SUBSTR(SQLERRM, 1, 100);
        INSERT INTO error_gid
        VALUES (cod, mesaj);
END;
/

SELECT * FROM error_gid;
 

-- 3

ACCEPT p_loc PROMPT 'Dati locatia: ' 
 
DECLARE 
  v_loc      dept_gid.location_id%TYPE:= &p_loc; 
  v_nume     dept_gid.department_name%TYPE; 
BEGIN 
  SELECT   department_name 
  INTO     v_nume 
  FROM     dept_gid 
  WHERE    location_id = v_loc; 
  DBMS_OUTPUT.PUT_LINE('In locatia '|| v_loc || 
           ' functioneaza departamentul '||v_nume); 
EXCEPTION 
  WHEN NO_DATA_FOUND THEN 
     INSERT   INTO error_gid
     VALUES  ( -20002, 'nu exista departamente in locatia data'); 
     DBMS_OUTPUT.PUT_LINE('a aparut o exceptie '); 
  WHEN TOO_MANY_ROWS THEN 
     INSERT   INTO error_gid 
     VALUES   (-20003,  
                'exista mai multe departamente in locatia data'); 
     DBMS_OUTPUT.PUT_LINE('a aparut o exceptie '); 
  WHEN OTHERS THEN 
    INSERT   INTO error_gid (mesaj) 
    VALUES   ('au aparut alte erori'); 
END; 
/ 

-- 4

ALTER TABLE dept_gid
ADD CONSTRAINT pk_dept_gid PRIMARY KEY (department_id);
ALTER TABLE emp_gid
ADD CONSTRAINT fk_emp_dept_gid FOREIGN KEY (department_id)
REFERENCES dept_gid(department_id);

DELETE FROM dept_gid WHERE department_id = 10;

DECLARE
    exceptie EXCEPTION;
    PRAGMA EXCEPTION_INIT(exceptie, -02292);
BEGIN
    DELETE FROM dept_gid WHERE department_id = 10;
EXCEPTION
    WHEN exceptie THEN
        dbms_output.put_line('Departamentul are angajati');
END;
/

-- 5

DECLARE
    val NUMBER := &val;
    nr NUMBER;
    exceptie EXCEPTION;
BEGIN
    SELECT COUNT(*) INTO nr
    FROM emp_gid
    WHERE (salary + salary * NVL(commission_pct, 0)) * 12 > val;
    
    IF nr = 0 THEN
        RAISE exceptie;
    ELSE
        dbms_output.put_line(nr);
    END IF;
EXCEPTION
    WHEN exceptie THEN 
        dbms_output.put_line('Niciun angajat');
END;
/

-- 6

DECLARE
    cod emp_gid.employee_id%TYPE := &cod_ang;
BEGIN
    UPDATE emp_gid
    SET salary = salary + 1000
    WHERE employee_id = cod;
    
    IF SQL%NOTFOUND THEN
        RAISE_APPLICATION_ERROR(-20003, 'Niciun angajat');
    END IF;
END;
/

SELECT * FROM emp_gid
WHERE employee_id = 100;
rollback;

-- 7

DECLARE
    cod emp_gid.employee_id%TYPE := &cod_ang;
    nume emp_gid.last_name%TYPE;
    sal emp_gid.salary%TYPE;
BEGIN
    SELECT last_name, salary INTO nume, sal
    FROM emp_gid
    WHERE employee_id = cod;
    dbms_output.put_line(nume || ' ' || sal);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20004, 'Niciun angajat');
END;
/
    
-- 8

-- Varianta 1

DECLARE
  localizare NUMBER;
  v_nume  emp_gid.last_name%TYPE; 
  v_sal    emp_gid.salary%TYPE; 
  v_job    emp_gid.job_id%TYPE; 
BEGIN   
    localizare := 1;
    SELECT last_name 
    INTO   v_nume 
    FROM   emp_gid
    WHERE  employee_id=200; 
    DBMS_OUTPUT.PUT_LINE(v_nume); 
     
    localizare := 2;
    SELECT salary 
    INTO   v_sal 
    FROM   emp_gid
    WHERE  employee_id=455; 
    DBMS_OUTPUT.PUT_LINE(v_sal); 
     
    localizare := 3;
    SELECT job_id 
    INTO   v_job 
    FROM   emp_gid
    WHERE  employee_id=200; 
    DBMS_OUTPUT.PUT_LINE(v_job);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('Comanda ' || localizare);
END; 
/ 

-- Varianta 2

DECLARE
  v_nume  emp_gid.last_name%TYPE; 
  v_sal    emp_gid.salary%TYPE; 
  v_job    emp_gid.job_id%TYPE; 
BEGIN   
    BEGIN
        SELECT last_name 
        INTO   v_nume 
        FROM   emp_gid
        WHERE  employee_id=200; 
        DBMS_OUTPUT.PUT_LINE(v_nume); 
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('1');
    END;
     
    BEGIN
        SELECT salary 
        INTO   v_sal 
        FROM   emp_gid
        WHERE  employee_id=455; 
        DBMS_OUTPUT.PUT_LINE(v_sal); 
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('2');
    END;
     
    BEGIN
        SELECT job_id 
        INTO   v_job 
        FROM   emp_gid
        WHERE  employee_id=200; 
        DBMS_OUTPUT.PUT_LINE(v_job);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('3');
    END;
END; 
/ 


-- 9

DECLARE
    v_comm emp_gid.commission_pct%TYPE;
BEGIN
    SELECT commission_pct INTO v_comm
    FROM emp_gid
    WHERE employe_id = 455;
    
    <<eticheta>>
    dbms_output.put_line(v_comm);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        v_comm := 0;
        GOTO eticheta;
END;
/

-- 10

DECLARE
    v_comm emp_gid.commission_pct%TYPE;
BEGIN
    SELECT commission_pct INTO v_comm
    FROM emp_gid
    WHERE employe_id = 100;
    
    IF v_comm IS NULL THEN
        GOTO eticheta;
    END IF;
    dbms_output.put_line(v_comm);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
       <<eticheta>>
        v_comm := 0;
END;
/


-- Tema T11 - Ex E1 din fisierul Laborator PLSQL 7.pdf
-- Tema T12 - Ex E6 din fisierul Laborator PLSQL 7.pdf
-- Deadline (pentru ambele) - duminica 04.01.2026 ora 23:59
