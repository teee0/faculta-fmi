-- Lab1 - SQL - Recapitulare

-- 11

CREATE TABLE emp_gid AS SELECT * FROM employees;
COMMENT ON TABLE emp_gid IS 'Informatii despre angajati';

-- 12

SELECT * 
FROM user_tab_comments
WHERE table_name LIKE '%_GID';

COMMENT ON COLUMN emp_gid.last_name IS 'Informatii despre nume';

SELECT * 
FROM user_col_comments
WHERE table_name LIKE '%_GID';

COMMENT ON COLUMN emp_gid.last_name IS '';

-- 13

SELECT sysdate FROM dual;

ALTER SESSION SET NLS_DATE_FORMAT = 'DD.MM.YYYY HH:MI:SS';

-- 14

SELECT EXTRACT(YEAR FROM sysdate)
FROM dual;

-- 15

SELECT EXTRACT(DAY FROM sysdate), EXTRACT(MONTH FROM sysdate)
FROM dual;

-- 16

CREATE TABLE dept_gid AS SELECT * FROM departments;

SELECT * FROM user_tables
WHERE table_name LIKE '%_GID';

-- 17-21

SET FEEDBACK OFF
SET PAGESIZE 0
SPOOL "C:\Users\Ioana\Desktop\Laboratoare SGBD\stergere_tabele.sql"

SELECT 'DROP TABLE ' || table_name || ';'
FROM user_tables
WHERE table_name LIKE '%_GID';

SPOOL OFF
SET FEEDBACK ON
SET PAGESIZE 10

-- 22

SET FEEDBACK OFF
SET PAGESIZE 0
SPOOL "C:\Users\Ioana\Desktop\Laboratoare SGBD\stergere_tabele.sql"

SELECT 'DROP TABLE ' || table_name || ' CASCADE CONSTRAINTS;'
FROM user_tables
WHERE table_name LIKE '%_GID';

SPOOL OFF
SET FEEDBACK ON
SET PAGESIZE 10

DROP TABLE departments;

