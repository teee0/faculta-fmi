---12a
SELECT c.nume, c.email
FROM calator c
WHERE EXISTS (
    SELECT 1 FROM bilet b
    JOIN tarif t ON b.id_ruta = t.id_ruta
                AND b.id_clasa = t.id_clasa
                AND b.id_tip_bilet = t.id_tip_bilet
    WHERE b.id_calator = c.id_calator
      AND t.valoare_tarif > 50
      AND EXISTS (
          SELECT 1 FROM promotie p
          JOIN legitimatie l ON p.id_promotie = l.id_promotie
          WHERE l.id_calator = c.id_calator
          AND EXISTS (
              SELECT 1 FROM tren tr
              JOIN ruta r ON tr.id_ruta = r.id_ruta
              WHERE tr.id_tren = b.id_tren
          )
      )
)
AND NOT EXISTS (
    SELECT 1 FROM legitimatie lg
    WHERE lg.id_calator = c.id_calator
)
ORDER BY c.nume;

---12b
SELECT
   calatori.total_calatori,
   trenuri.total_trenuri
FROM
   (SELECT COUNT(*) AS total_calatori FROM calator) calatori,
   (SELECT COUNT(*) AS total_trenuri FROM tren) trenuri;

---12c
WITH tarif_extins AS (
    SELECT
        t.id_ruta,
        t.valoare_tarif
    FROM tarif t
    JOIN ruta r ON t.id_ruta = r.id_ruta
    JOIN clasa c ON t.id_clasa = c.id_clasa
)
SELECT
    id_ruta,
    AVG(valoare_tarif) AS tarif_mediu
FROM tarif_extins
GROUP BY id_ruta
HAVING AVG(valoare_tarif) > (
    SELECT AVG(valoare_tarif) FROM tarif
);


---12d
SELECT
   denumire,
   NVL(suprataxa, 0) AS suprataxa_afisata,
   DECODE(
       TRUNC(suprataxa),
       0, 'ZERO',
       15, 'MICĂ',
       50, 'MICĂ',
       100, 'MARE',
       150, 'MARE',
       'ALTE'
   ) AS categorie_suprataxa
FROM clasa
ORDER BY suprataxa DESC;


---12e f
WITH bilete_extinse AS (
    SELECT
        b.id_bilet,
        b.data_emitere,
        t.valoare_tarif,
        c.nume,
        c.email
    FROM bilet b
    JOIN calator c ON b.id_calator = c.id_calator
    JOIN tarif t ON b.id_ruta = t.id_ruta
                AND b.id_clasa = t.id_clasa
                AND b.id_tip_bilet = t.id_tip_bilet
)
SELECT
    id_bilet,
    SUBSTR(email, 1, 10) AS email_partial,
    TO_CHAR(data_emitere, 'YYYY-MM-DD') AS data_bilet,
    TO_CHAR(data_emitere, 'HH24:MI:SS') AS ora_emitere,
    CASE
        WHEN TO_NUMBER(TO_CHAR(data_emitere, 'HH24')) BETWEEN 6 AND 11 THEN 'Dimineața'
        WHEN TO_NUMBER(TO_CHAR(data_emitere, 'HH24')) BETWEEN 12 AND 17 THEN 'După-amiaza'
        WHEN TO_NUMBER(TO_CHAR(data_emitere, 'HH24')) BETWEEN 18 AND 21 THEN 'Seara'
        ELSE 'Noapte'
    END AS perioada_zi,
    INITCAP(nume) AS nume_formatat
FROM bilete_extinse;

---13
UPDATE calator c
SET c.email = NULL
WHERE c.id_calator IN (
    SELECT c2.id_calator
    FROM calator c2
    WHERE NOT EXISTS (
        SELECT 1
        FROM bilet b
        WHERE b.id_calator = c2.id_calator
    )
);

DELETE FROM bilet b
WHERE EXISTS (
    SELECT 1
    FROM tren t
    JOIN ruta r ON t.id_ruta = r.id_ruta
    WHERE t.id_tren = b.id_tren
      AND r.statie_plecare = 'București Nord'
      AND r.statie_sosire = 'Brașov'
      AND b.data_calatorie < TRUNC(SYSDATE)
);

DELETE FROM legitimatie l
WHERE NOT EXISTS (
    SELECT 1
    FROM bilet b
    WHERE b.id_calator = l.id_calator
      AND b.data_calatorie >= TRUNC(SYSDATE)
);

---14
CREATE OR REPLACE VIEW VIZUALIZARE_BILETE_DETALII AS
SELECT
    b.id_bilet,
    c.nume || ' ' || c.prenume AS Nume_Calator,
    t.numar_tren,
    r.statie_plecare,
    r.statie_sosire,
    cl.denumire AS Clasa_Bilet,
    tb.denumire AS Tip_Bilet,
    p.denumire AS Promotie_Aplicata,
    b.data_calatorie

FROM
    bilet b
JOIN
    calator c ON b.id_calator = c.id_calator
JOIN
    tren t ON b.id_tren = t.id_tren
JOIN
    ruta r ON t.id_ruta = r.id_ruta
JOIN
    clasa cl ON b.id_clasa = cl.id_clasa
JOIN
    tip_bilet tb ON b.id_tip_bilet = tb.id_tip_bilet
LEFT JOIN
    promotie p ON b.id_promotie = p.id_promotie;

--ok
SELECT * FROM VIZUALIZARE_BILETE_DETALII WHERE Nume_Calator LIKE 'Popescu%';
-- --da eroare
-- UPDATE VIZUALIZARE_BILETE_DETALII
-- SET Nume_Calator = 'Ion Popescu'
-- WHERE id_bilet = 1;

---15

SELECT
    c.id_calator,
    c.nume || ' ' || c.prenume AS Nume_Calator,
    b.id_bilet,
    b.data_calatorie,
    t.numar_tren,
    r.statie_plecare,
    r.statie_sosire,
    cl.denumire AS Clasa_Bilet,
    tb.denumire AS Tip_Bilet,
    p.denumire AS Promotie_Aplicata
FROM
    calator c
LEFT JOIN bilet b ON c.id_calator = b.id_calator
LEFT JOIN tren t ON b.id_tren = t.id_tren
LEFT JOIN ruta r ON t.id_ruta = r.id_ruta
LEFT JOIN clasa cl ON b.id_clasa = cl.id_clasa
LEFT JOIN tip_bilet tb ON b.id_tip_bilet = tb.id_tip_bilet
LEFT JOIN promotie p ON b.id_promotie = p.id_promotie
WHERE
    ROWNUM <= 100
ORDER BY
    Nume_Calator;

SELECT DISTINCT c.id_calator, c.nume || ' ' || c.prenume AS Nume_Calator
FROM calator c
WHERE NOT EXISTS (
    SELECT r.id_ruta
    FROM ruta r
    WHERE NOT EXISTS (
        SELECT b.id_bilet
        FROM bilet b
        JOIN tren t ON b.id_tren = t.id_tren
        WHERE b.id_calator = c.id_calator
          AND t.id_ruta = r.id_ruta
    )
);

SELECT *
FROM (
    SELECT
        c.nume || ' ' || c.prenume AS Nume_Calator,
        SUM(t.valoare_tarif) AS Total_Platit
    FROM calator c
    JOIN bilet b ON c.id_calator = b.id_calator
    JOIN tarif t ON b.id_ruta = t.id_ruta
                 AND b.id_clasa = t.id_clasa
                 AND b.id_tip_bilet = t.id_tip_bilet
    GROUP BY c.id_calator, c.nume, c.prenume
    ORDER BY Total_Platit DESC
)
WHERE ROWNUM <= 3;
