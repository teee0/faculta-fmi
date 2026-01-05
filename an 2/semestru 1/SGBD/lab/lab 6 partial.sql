CREATE OR REPLACE TRIGGER t1_gid
BEFORE INSERT OR UPDATE OR DELETE ON emp_gid
BEGIN
    IF TO_CHAR(sysdate, 'D') = '1' OR
        TO_CHAR(sysdate, 'HH24') NOT BETWEEN 8 AND 12 THEN
        RAISE_APPLICATION_ERROR(-20000, 'Operație nepermisă');
    END IF;
END;
/

DELETE FROM emp_gid;

DROP TRIGGER t1_gid;

CREATE OR REPLACE TRIGGER t2_gid
BEFORE UPDATE OF salary ON emp_gid
FOR EACH ROW
BEGIN
    IF :new.salary < :old.salary THEN
        RAISE_APPLICATION_ERROR(-20001,'Operație nepermisă');
    END IF;
END;
/

UPDATE emp_gid
SET salary = salary-100
WHERE employee_id =101;

CREATE OR REPLACE TRIGGER t2_gid
BEFORE UPDATE OF salary ON emp_gid
FOR EACH ROW
WHEN (new.salary < old.salary)
BEGIN
    RAISE_APPLICATION_ERROR(-20001,'Operație nepermisă');
END;
/


DROP TRIGGER t2_gid;

SELECT * FROM job_grades;

CREATE TABLE job_grades_gid AS SELECT * FROM job_grades;

CREATE OR REPLACE TRIGGER t3_gid
BEFORE UPDATE OF highest_sal, lowest_sal ON job_grades_gid
FOR EACH ROW
DECLARE
    sal_min emp_gid.salary%TYPE
    sal_max emp_gid.salary%TYPE
    exceptie EXCEPTION
BEGIN
    SELECT MAX(salary), MIN(salary) INTO sal_max, sal_min
    FROM emp_gid;
    
    IF (:old.grade_level = 1 AND :new.lowest_sal > sal_min)
    --aici lipseste cod
    END IF;
EXCEPTION 
    WHEN exceptie THEN
        RAISE_APPLICATION_ERROR(-20003, 'Op. nepermisa');
END;



