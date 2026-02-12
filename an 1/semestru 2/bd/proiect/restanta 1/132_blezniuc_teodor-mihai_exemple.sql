--- 12

SELECT c.nume, c.prenume
FROM calator c
WHERE EXISTS (
    SELECT 1
    FROM bilet b
    WHERE b.id_calator = c.id_calator
      AND b.pret_final > 50
      AND EXISTS (
          SELECT 1
          FROM tarif t
          WHERE t.id_tip_bilet = b.id_tip_bilet
            AND t.id_clasa = b.id_clasa
      )
      AND b.id_promotie IS NOT NULL
)
AND c.email IS NULL
ORDER BY c.nume;

SELECT
    (SELECT COUNT(*) FROM calator) AS total_calatori,
    (SELECT COUNT(*) FROM tren) AS total_trenuri
FROM dual;

SELECT id_ruta, AVG(valoare_tarif) AS tarif_mediu
FROM tarif
GROUP BY id_ruta
HAVING AVG(valoare_tarif) > (
    SELECT AVG(valoare_tarif) FROM tarif
);

SELECT
    denumire,
    NVL(suprataxa, 0) AS suprataxa_afisata,
    DECODE(
        TRUNC(suprataxa),
        0, 'ZERO',
        1, 'MICĂ',
        5, 'MICĂ',
        15, 'MARE',
        25, 'MARE',
        'ALTE'
    ) AS categorie_suprataxa
FROM clasa
ORDER BY suprataxa DESC;

WITH bilete_extinse AS (
    SELECT
        b.id_bilet,
        b.data_calatorie,
        c.nume,
        c.email
    FROM bilet b
    JOIN calator c ON b.id_calator = c.id_calator
)
SELECT
    id_bilet,
    INITCAP(nume) AS nume_formatat,
    SUBSTR(email, 1, 10) AS email_partial,
    TO_CHAR(data_calatorie, 'YYYY-MM-DD') AS data_calatorie,
    TO_CHAR(data_calatorie, 'HH24:MI:SS') AS ora,
    CASE
        WHEN TO_NUMBER(TO_CHAR(data_calatorie, 'HH24')) BETWEEN 6 AND 11 THEN 'Dimineața'
        WHEN TO_NUMBER(TO_CHAR(data_calatorie, 'HH24')) BETWEEN 12 AND 17 THEN 'După-amiaza'
        WHEN TO_NUMBER(TO_CHAR(data_calatorie, 'HH24')) BETWEEN 18 AND 21 THEN 'Seara'
        ELSE 'Noapte'
    END AS perioada_zi
FROM bilete_extinse;

--- 13

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
      AND r.data_start < TRUNC(SYSDATE)
);

DELETE FROM legitimatie l
WHERE NOT EXISTS (
    SELECT 1
    FROM bilet b
    WHERE b.id_calator = l.id_calator
      AND b.data_calatorie >= TRUNC(SYSDATE)
);

--- 14

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
    b.data_calatorie,
    b.pret_final
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


-- OK
SELECT * FROM VIZUALIZARE_BILETE_DETALII WHERE Nume_Calator LIKE 'Popescu%';

--- 15

SELECT
    c.id_calator,
    c.nume || ' ' || c.prenume AS Nume_Calator,
    b.id_bilet,
    b.data_calatorie,
    b.pret_final,
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
        SUM(b.pret_final) AS Total_Platit
    FROM calator c
    JOIN bilet b ON c.id_calator = b.id_calator
    GROUP BY c.id_calator, c.nume, c.prenume
    ORDER BY Total_Platit DESC
)
WHERE ROWNUM <= 3;


--- 16

WITH BILETE_RECENTE AS (
    SELECT
        b.id_calator,
        b.id_tip_bilet,
        b.id_promotie,
        b.pret_final,
        b.data_emitere
    FROM bilet b
    WHERE b.data_emitere >= TO_DATE('2025-01-01', 'YYYY-MM-DD')
)
SELECT
    c.nume || ' ' || c.prenume AS nume_calator,
    tb.denumire AS tip_bilet,
    p.denumire AS promotie,
    COUNT(b.id_calator) AS nr_bilete,
    SUM(b.pret_final) AS suma_totala_platita
FROM BILETE_RECENTE b
JOIN calator c ON c.id_calator = b.id_calator
LEFT JOIN promotie p ON p.id_promotie = b.id_promotie
JOIN tip_bilet tb ON tb.id_tip_bilet = b.id_tip_bilet
GROUP BY c.nume, c.prenume, tb.denumire, p.denumire
ORDER BY suma_totala_platita DESC;

-- Șterg indexurile dacă există (ca să eviți erori)
DROP INDEX IDX_BILET_DATA_EMITERE;

-- Creează index simplu pe data_emitere (folosită la filtrare)
CREATE INDEX IDX_BILET_DATA_EMITERE ON bilet(data_emitere);