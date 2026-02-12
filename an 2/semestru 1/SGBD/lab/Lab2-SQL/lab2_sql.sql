-- Lab2 - SQL - Recapitulare

SELECT * FROM member;
SELECT * FROM title;
SELECT * FROM title_copy;
SELECT * FROM rental;
SELECT * FROM reservation;

-- 4

SELECT category, COUNT(DISTINCT r.title_id),
                 COUNT(*)
FROM title t, rental r
WHERE t.title_id = r.title_id
GROUP BY category
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                    FROM title t, rental r
                    WHERE t.title_id = r.title_id
                    GROUP BY category);
                    
-- 5

-- nu e corect
SELECT title_id, COUNT(*)
FROM title_copy
WHERE status = 'AVAILABLE'
GROUP BY title_id;

SELECT title, (SELECT COUNT(*) FROM title_copy
               WHERE title_id = t.title_id)
               -
              (SELECT COUNT(*) FROM rental
               WHERE title_id = t.title_id
               AND act_ret_date IS NULL) AS nr
FROM title t;

-- 6

SELECT title, copy_id, status AS status_setat,
    CASE
        WHEN (tc.title_id, copy_id) IN (SELECT title_id, copy_id
                                        FROM rental
                                        WHERE act_ret_date IS NULL)
            THEN 'RENTED'
        ELSE 'AVAILABLE'
    END status_corect
FROM title t, title_copy tc
WHERE t.title_id = tc.title_id;

-- 8

-- nu e 100% corect
SELECT res_date, res.member_id, res.title_id
FROM rental re, reservation res
WHERE re.member_id = res.member_id
AND re.title_id = res.title_id
AND res_date <> book_date;

-- corect
SELECT CASE WHEN COUNT(*) = 0 THEN 'Da' ELSE 'Nu' END respuns
FROM (SELECT res_date, member_id, title_id
      FROM reservation
      MINUS
      SELECT book_date, member_id, title_id
      FROM rental);

-- 9

-- incomplet
SELECT first_name, last_name, title, COUNT(*)
FROM member m, title t, rental r
WHERE m.member_id = r.member_id
AND t.title_id = r.title_id
GROUP By first_name, last_name, title;

-- inclusiv cei care nu au imprumutat
SELECT last_name, first_name, title, COUNT(r.title_id)
FROM rental r,
     (SELECT last_name, first_name, title, title_id, member_id
      FROM member, title) mt
WHERE mt.member_id = r.member_id(+)
AND mt.title_id = r.title_id(+)
GROUP BY last_name, first_name, title
ORDER BY last_name, title;

-- 12

-- a

SELECT (SELECT COUNT(*) FROM rental
        WHERE EXTRACT(MONTH FROM book_date) = EXTRACT(MONTH FROM sysdate)
        AND EXTRACT(DAY FROM book_date) = 1) zi_1,
        (SELECT COUNT(*) FROM rental
        WHERE EXTRACT(MONTH FROM book_date) = EXTRACT(MONTH FROM sysdate)
        AND EXTRACT(DAY FROM book_date) = 2) zi_2
FROM dual;

-- b

SELECT TRUNC(book_date), COUNT(*)
FROM rental
WHERE EXTRACT(MONTH FROM book_date) = EXTRACT(MONTH FROM sysdate)
GROUP BY TRUNC(book_date);

-- c

WITH zile AS
(SELECT TRUNC(sysdate, 'MM') + level - 1 zi
FROM dual
CONNECT BY level <= EXTRACT(DAY FROM LAST_DAY(sysdate)))
SELECT zi, (SELECT COUNT(*) FROM rental 
            WHERE TRUNC(book_date) = zi) nr
FROM zile;

SELECT * FROM rental;

-- tema T1 - Ex 11 din fisierul Laborator SQL - An 2 - Recapitulare 2.pdf
-- Deadline - miercuri 15.10.2025 ora 21:59
