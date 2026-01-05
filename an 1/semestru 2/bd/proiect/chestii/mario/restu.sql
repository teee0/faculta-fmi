-- 12. Formulează în limbaj natural și implementează 5 interogări SQL complexe care să utilizeze:
-- a) subinterogări sincronizate cu cel puțin 3 tabele
-- b) subinterogări nesincronizate în clauza FROM
-- c) grupări de date, funcții de grup, filtrare la nivel de grupuri cu subinterogări nesincronizate (în HAVING)
-- d) sortări și utilizarea funcțiilor NVL și DECODE (în aceeași interogare)
-- e) utilizarea a minim 2 funcții pentru șiruri, 2 funcții pentru date, și cel puțin o expresie CASE
-- f) utilizarea a minim 1 bloc WITH

-- I. Afișează numele cluburilor care au cel puțin un jucător al cărui nume începe cu litera 'J' și salariul este mai
--   mare decât salariul mediu al jucătorilor din clubul respectiv. Afișează primele 7 caractere din numele jucătorului și
--   numele clubului. Rezultatele vor fi ordonate alfabetic după numele clubului.

    SELECT
    c.nume_club,
    SUBSTR(om.nume_om, 1, 7) AS nume_jucator_scurtat,
    om.salariu
FROM
    CLUB c
JOIN
    OM om ON c.id_club = om.id_club
JOIN
    JUCATOR j ON om.id_om = j.id_om                                           -- îndeplinește a)
WHERE
    om.nume_om LIKE 'J%'
    AND om.salariu > (SELECT
                          AVG(om2.salariu)
                      FROM
                          OM om2
                      JOIN
                          JUCATOR j2 ON om2.id_om = j2.id_om
                      WHERE
                          om2.id_club = om.id_club)
ORDER BY
    c.nume_club;


-- II. Pentru fiecare club, afișează numele clubului, numărul de jucători și categoria clubului ("MARE" pentru peste
--    15 jucători, "MIC" pentru restul). Afișează doar cluburile care au mai mulți jucători decât media. Ordonează
--    descrescător după numărul de jucători.

SELECT
    c.nume_club,
    NVL(stats.nr_jucatori, 0) AS numar_jucatori,
    DECODE(
        SIGN(NVL(stats.nr_jucatori, 0) - 15),
        1, 'MARE',
        'MIC'
    ) AS categoria_club

FROM
    CLUB c
LEFT JOIN (
    SELECT
        o.id_club,
        COUNT(j.id_om) AS nr_jucatori                                           -- îndeplinește b) și d)
    FROM OM o
    LEFT JOIN JUCATOR j ON o.id_om = j.id_om
    GROUP BY o.id_club
) stats ON c.id_club = stats.id_club

WHERE NVL(stats.nr_jucatori, 0) > (
    SELECT AVG(COUNT(j.id_om))
    FROM OM o
    LEFT JOIN JUCATOR j ON o.id_om = j.id_om
    GROUP BY o.id_club
)

ORDER BY NVL(stats.nr_jucatori, 0) DESC;

-- III. Afișează numele clubului și salariul mediu al personalului (jucători, antrenori, doctori) pentru cluburile al
--     căror salariu mediu pe club este mai mare decât salariul mediu global al tuturor jucătorilor.

SELECT
    c.nume_club,
    AVG(om.salariu) AS salariu_mediu_club
FROM
    CLUB c
JOIN
    OM om ON c.id_club = om.id_club
GROUP BY
    c.nume_club                                           -- îndeplinește c)
HAVING
    AVG(om.salariu) > (SELECT
                           AVG(salariu)
                       FROM
                           OM o
                       JOIN
                           JUCATOR j ON o.id_om = j.id_om);

-- IV. Pentru fiecare contract, afișează numele sponsorului (majuscule), numele clubului (format "Nume Club(ID: X)",
--    unde X este ID-ul clubului), data semnării contractului, data de expirare a contractului și statutul acestuia
--    ('Activ' dacă data de expirare este în viitor față de 21 Mai 2025,'Expirat' altfel).

SELECT
    UPPER(s.nume_sponsor) AS sponsor_majuscule,
    c.nume_club || ' (ID: ' || c.id_club || ')' AS club_cu_id,
    ctr.data_semnarii,
    ADD_MONTHS(ctr.data_semnarii, ctr.durata_contract * 12) AS data_expirare_contract,
    CASE
        WHEN ADD_MONTHS(ctr.data_semnarii, ctr.durata_contract * 12) >= TO_DATE('21-05-2025', 'DD-MM-YYYY') THEN 'Activ'   -- îndeplinește e)
        ELSE 'Expirat'
    END AS statut_contract
FROM
    CONTRACT ctr
JOIN
    SPONSOR s ON ctr.id_sponsor = s.id_sponsor
JOIN
    CLUB c ON ctr.id_club = c.id_club;

-- V. Gășește numele cluburilor care au cel puțin un antrenor cu mai mult de 20 de ani experiență și un salariu egal
--   cu salariul mediu al antrenorilor din același club. Afișează numele clubului, numele antrenorului și experiența
--   acestuia, asigurându-te că numele antrenorului este afișat cu prima literă mare și restul mici.

WITH AntrenoriCalificati AS (
    SELECT
        om.id_club,
        om.nume_om AS nume_antrenor,
        a.ani_experienta,
        om.salariu AS salariu_antrenor,
        (SELECT
             AVG(om2.salariu)                                           -- îndeplinește f)
         FROM
             OM om2
         JOIN
             ANTRENOR a2 ON om2.id_om = a2.id_om
         WHERE
             om2.id_club = om.id_club) AS salariu_mediu_antrenori_club
    FROM
        OM om
    JOIN
        ANTRENOR a ON om.id_om = a.id_om
    WHERE
        a.ani_experienta > 20
)
SELECT
    cl.nume_club,
    INITCAP(ace.nume_antrenor) AS nume_antrenor_formatat,
    ace.ani_experienta
FROM
    CLUB cl
JOIN
    AntrenoriCalificati ace ON cl.id_club = ace.id_club
WHERE
    ace.salariu_antrenor = ace.salariu_mediu_antrenori_club;

--13. Implementarea a 3 operații de actualizare și de suprimare a datelor utilizând subcereri.

-- I. Actualizări

-- 1. Mărește salariul cu 15% pentru toți jucătorii care au jucat mai mult de 55 de meciuri și care aparțin clubului
--   cu cele mai multe trofee.

UPDATE OM
SET salariu = salariu * 1.15
WHERE id_om IN (SELECT id_om FROM JUCATOR WHERE numar_meciuri_jucate > 55)
AND id_club = (SELECT id_club FROM (SELECT id_club, trofee FROM CLUB ORDER BY trofee DESC) WHERE ROWNUM = 1);
COMMIT;

-- 2. Actualizează specializarea doctorilor la 'Fizioterapie' pentru acei doctori care lucrează pentru cluburi care au
--   sponsorizări în competiția 'Cupa României' cu o sumă mai mare de 60000.

UPDATE DOCTOR
SET specializare = 'Fizioterapie'
WHERE id_om IN (
    SELECT o.id_om
    FROM OM o
    JOIN CLUB cl ON o.id_club = cl.id_club
    WHERE cl.id_club IN (
        SELECT ctr.id_club
        FROM CONTRACT ctr
        JOIN COMPETITIE comp ON ctr.id_competitie = comp.id_competitie
        WHERE comp.nume_competitie = 'Cupa României' AND ctr.suma_sponsorizare > 60000
    )
);
COMMIT;

-- 3. Mărește numărul de meciuri câștigate cu 5 pentru toți antrenorii care au mai mult de 22 de ani experiență și
--   salariul lor este mai mare decât salariul minim al oricărui jucător.

UPDATE ANTRENOR
SET meciuri_castigate = meciuri_castigate + 5
WHERE ani_experienta > 22
AND id_om IN (
    SELECT id_om
    FROM OM
    WHERE salariu > (SELECT MIN(salariu) FROM OM WHERE id_om IN (SELECT id_om FROM JUCATOR))
);
COMMIT;

-- II. Ștergeri

-- 1. Șterge toți antrenorii care au mai puțin de 25 de ani experiență, au câștigat mai puțin de 113 meciuri și
--   cluburile la care sunt afiliați au mai puțin de 20 de trofee.

DELETE FROM ANTRENOR
WHERE id_om IN (
    SELECT o.id_om
    FROM OM o
    JOIN ANTRENOR a ON o.id_om = a.id_om
    JOIN CLUB c ON o.id_club = c.id_club
    WHERE a.ani_experienta < 25
    AND a.meciuri_castigate < 113
    AND c.trofee < 20
);

DELETE FROM OM
WHERE id_om IN (
    SELECT o.id_om
    FROM OM o
    JOIN ANTRENOR a ON o.id_om = a.id_om
    JOIN CLUB c ON o.id_club = c.id_club
    WHERE a.ani_experienta < 25
    AND a.meciuri_castigate < 113
    AND c.trofee < 20
);
COMMIT;

-- 2. Șterge toți jucătorii al căror număr de meciuri jucate este mai mic de 54 și care aparțin unui club cu mai
--   puțin de 20 de trofee.

DELETE FROM JUCATOR
WHERE numar_meciuri_jucate < 54
AND id_om IN (
    SELECT o.id_om
    FROM OM o
    JOIN CLUB c ON o.id_club = c.id_club
    WHERE c.trofee < 20
);

DELETE FROM OM
WHERE id_om IN (
    SELECT o.id_om
    FROM JUCATOR
    JOIN OM o ON JUCATOR.id_om = o.id_om
    JOIN CLUB c ON o.id_club = c.id_club
    WHERE JUCATOR.numar_meciuri_jucate < 54
    AND c.trofee < 20
);
COMMIT;

-- 3. Șterge toți sponsorii care nu au niciun contract activ (unde data de expirare este în viitor față de 21 Mai
--   2025) și al căror nume conține litera 'E'.

DELETE FROM SPONSOR
WHERE UPPER(nume_sponsor) LIKE '%E%'
AND id_sponsor NOT IN (
    SELECT ctr.id_sponsor
    FROM CONTRACT ctr
    WHERE ADD_MONTHS(ctr.data_semnarii, ctr.durata_contract * 12) >= TO_DATE('21-05-2025', 'DD-MM-YYYY')
);
COMMIT;


-- 14. Crearea unei vizualizări complexe. Dați un exemplu de operație LMD permisă pe
--   vizualizarea respectivă și un exemplu de operație LMD nepermisă.


-- Enunț: Afișează suma totală de sponsorizare pentru competițiile în care participă mai mult
-- de 3 cluburi și suma totală de goluri marcate luând in considerare doar meciurile în
-- care s-au dat mai multe goluri decât media pe meci.

CREATE VIEW CERINTA_14 AS
SELECT
    SUM(SUMA_SPONSORIZARE) sponsorizare_totala,
    NVL(SUM(GOLURI_MARCATE), 0) goluri,
    c.nume_competitie
FROM COMPETITIE c
JOIN CONTRACT cnt ON c.ID_COMPETITIE = cnt.ID_COMPETITIE
JOIN CLUB cl ON cl.id_club = cnt.id_club
LEFT JOIN MECI m ON c.ID_COMPETITIE = m.ID_COMPETITIE
WHERE m.GOLURI_MARCATE > (SELECT
                          AVG(GOLURI_MARCATE)
                          FROM MECI)
GROUP BY NUME_COMPETITIE HAVING COUNT(cl.ID_CLUB) > 3;

-- Exemplu permis (SELECT):
-- SELECT * FROM CERINTA_14;

-- Exemplu nepermis (INSERT):
-- INSERT INTO CERINTA_14 VALUES (100000, 50, 'Liga 1');
-- Motiv: Vizualizarea implică agregări și JOIN-uri complexe, deci nu acceptă operații de modificare.


-- 15. Formulați în limbaj natural și implementați în SQL: o cerere ce utilizează operația outerjoin pe minimum 4 tabele,
--   o cerere ce utilizează operația division și o cerere care implementează analiza top-n.
--   Observație: Cele 3 cereri sunt diferite de cererile de la exercițiul 12.

-- I. Afișează numele fiecărui club (doar pe cele care au un număr total de meciuri câștigate mai mare decât media
--   meciurilor câștigate de toate cluburile), numele stadionului asociat, numele sponsorului și numele competiției
--   pentru toate contractele. Pentru cluburile care au jucători, salariul mediu al jucătorilor din club trebuie să fie
--   mai mare decât salariul minim al unui jucător cu mai mult de 55 de meciuri jucate. Ordonează rezultatele după numele
--   clubului, numele sponsorului și numele competiției.

SELECT
    cl.nume_club,
    s.nume_stadion,
    sp.nume_sponsor,
    comp.nume_competitie
FROM
    CLUB cl
LEFT OUTER JOIN
    STADION s ON cl.id_club = s.id_club
LEFT OUTER JOIN
    CONTRACT ctr ON cl.id_club = ctr.id_club
LEFT OUTER JOIN
    SPONSOR sp ON ctr.id_sponsor = sp.id_sponsor
LEFT OUTER JOIN
    COMPETITIE comp ON ctr.id_competitie = comp.id_competitie
WHERE
    cl.meciuri_castigate > (SELECT AVG(meciuri_castigate) FROM CLUB)
    AND (
        NOT EXISTS (SELECT 1 FROM OM om_j JOIN JUCATOR j_sub ON om_j.id_om = j_sub.id_om WHERE om_j.id_club = cl.id_club)
        OR
        (SELECT AVG(om_sub.salariu)
         FROM OM om_sub
         JOIN JUCATOR j_sub ON om_sub.id_om = j_sub.id_om
         WHERE om_sub.id_club = cl.id_club) >(SELECT MIN(om_min_sal.salariu)
                                              FROM OM om_min_sal
                                              JOIN JUCATOR j_min_meci ON om_min_sal.id_om = j_min_meci.id_om
                                              WHERE j_min_meci.numar_meciuri_jucate > 55)
    )
ORDER BY
    cl.nume_club, sp.nume_sponsor, comp.nume_competitie;

SELECT
    c.ID_ANTRENOR,
    o.nume_om
FROM
    CLUB c
LEFT JOIN
    OM o ON
WHERE




-- II. Afișează numele sponsorului, suma totală a contractelor și numele cluburilor cu care au contracte, împreună cu
--    suma contractată pentru fiecare club pentru sponsorii care au contracte cu toate cluburile care au câștigat peste
--    15 trofee, au un stadion cu nume ce conține "București" și au cel puțin 3 jucători cu salariu peste 3000

WITH CluburiCalificate AS (
    SELECT c.id_club, c.nume_club
    FROM CLUB c
    WHERE c.trofee > 15
    AND EXISTS (
        SELECT 1
        FROM STADION st
        WHERE st.id_club = c.id_club
        AND st.nume_stadion LIKE '%București%'
    )
    AND (
        SELECT COUNT(*)
        FROM OM o
        JOIN JUCATOR j ON o.id_om = j.id_om
        WHERE o.id_club = c.id_club
        AND o.salariu > 3000
    ) >= 3
),
SponsoriCompleti AS (
    SELECT s.id_sponsor, s.nume_sponsor
    FROM SPONSOR s
    WHERE NOT EXISTS (
        SELECT q.id_club                            -- Nu există niciun club calificat pentru care să nu existe contract cu sponsorul curent
        FROM CluburiCalificate q                    --                                        adică
        WHERE NOT EXISTS (                          --           Pentru fiecare club calificat, există contract cu sponsorul curent
            SELECT 1
            FROM CONTRACT cnt
            WHERE cnt.id_sponsor = s.id_sponsor
            AND cnt.id_club = q.id_club
        )
    )
)
SELECT
    sc.nume_sponsor,
    (SELECT SUM(suma_sponsorizare)
     FROM CONTRACT cnt
     WHERE cnt.id_sponsor = sc.id_sponsor) AS suma_totala_contracte,
     LISTAGG(c.nume_club || ' (' || cnt.suma_sponsorizare || ' €)', ', ')
        WITHIN GROUP (ORDER BY c.nume_club) AS cluburi_contracte
FROM SponsoriCompleti sc
JOIN CONTRACT cnt ON sc.id_sponsor = cnt.id_sponsor
JOIN CLUB c ON cnt.id_club = c.id_club
GROUP BY sc.nume_sponsor, sc.id_sponsor;


-- III. Afișează top 2 jucători cu cele mai multe meciuri jucate din fiecare club, dar doar pentru cluburile cu
--     salariu mediu peste 3000. Include doar jucătorii cu cel puțin 2 poziții preferate.

WITH CluburiFiltrate AS (
    SELECT c.id_club, c.nume_club
    FROM CLUB c
    WHERE (
        SELECT AVG(o.salariu)
        FROM OM o
        WHERE o.id_club = c.id_club
    ) > 3000
),
JucatoriPozitii AS (
    SELECT
        o.id_om,
        o.nume_om,
        o.id_club,
        j.numar_meciuri_jucate,
        (SELECT COUNT(*)
         FROM POZITII_PREFERATE pp
         WHERE pp.id_om = o.id_om) AS numar_pozitii
    FROM OM o
    JOIN JUCATOR j ON o.id_om = j.id_om
),
Clasament AS (
    SELECT
        cf.nume_club,
        jp.nume_om,
        jp.numar_meciuri_jucate,
        jp.numar_pozitii,
        ROW_NUMBER() OVER (
            PARTITION BY cf.id_club
            ORDER BY jp.numar_meciuri_jucate DESC
        ) AS rang
    FROM CluburiFiltrate cf
    JOIN JucatoriPozitii jp ON cf.id_club = jp.id_club
    WHERE jp.numar_pozitii >= 2
)
SELECT
    nume_club AS "NUMER_CLUB",
    nume_om AS "NUMER_ON",
    numar_meciuri_jucate AS "NUMAR_MECIURT_JUCATE",
    numar_pozitii AS "NUMAR_POZITII"
FROM Clasament
WHERE rang <= 2
ORDER BY nume_club, numar_meciuri_jucate DESC;


-- 16. La alegere: a) Optimizarea unei cereri, aplicând regulile de optimizare ce derivă din
--    proprietățile operatorilor algebrei relaționale. Cererea va fi exprimată prin expresie
--    algebrică, arbore algebric și limbaj (SQL), atât anterior cât și ulterior optimizării.

-- Enunț: Selectează numele cluburilor și numărul de trofee pentru cluburile care au jucători cu vârsta peste
--       25 de ani și care au semnat un contract cu un sponsor numit 'Nike'.

-- Varianta neoptimizată:

-- SQL:
SELECT c.nume_club, c.trofee
FROM CLUB c
CROSS JOIN OM o
CROSS JOIN  JUCATOR j
CROSS JOIN  CONTRACT co
CROSS JOIN  SPONSOR s
WHERE o.varsta_om > 25
AND s.nume_sponsor = 'Nike';

-- Expresii algebrice:
--     R1 = PRODUCT(JUCATOR, OM)
--     R2 = PRODUCT(R1, CLUB)
--     R3 = PRODUCT(R2, SPONSOR)
--     R4 = PRODUCT(R3, CONTRACT)
--     R5 = SELECT(R5, nume_sponsor = 'Nike' AND varsta_om > 25)
--     Rezultat = PROJECT(R5, nume_club, trofee)

-- Arbore (în fișierul pdf cu rezolvările)


-- Varianta optimizată:

-- SQL:
SELECT c.nume_club, c.trofee
FROM CLUB c
JOIN OM o ON c.id_club = o.id_club
JOIN JUCATOR j ON o.id_om = j.id_om
JOIN CONTRACT co ON c.id_club = co.id_club
JOIN SPONSOR s ON co.id_sponsor = s.id_sponsor
WHERE o.varsta_om > 25
AND s.nume_sponsor = 'Nike';

-- Expresii algebrice:

-- R1 = SELECT(OM, varsta_om > 25)
-- R2 = PROJECT(R1, id_club, id_om)
-- R3 = SELECT(SPONSOR, nume_sponsor = 'Nike')
-- R4 = PROJECT(R3, id_sponsor)
-- R5 = PROJECT(CLUB, id_club, nume_club, trofee)
-- R6 = JOIN(R5, R2, R5.id_club = R2.id_club)
-- R7 = PROJECT(JUCATOR, id_om)
-- R8 = JOIN(R6, R7, R7.id_om = R6.id_om)
-- R9 = PROJECT(CONTRACT, id_sponsor)
-- R10 = JOIN(R9, R4, R4.id_sponsor = R9.id_sponsor)
-- R11 = JOIN(R8, R10, R10.id_club = R8.id_club)
-- Rezultat = PROJECT(R11, nume_club, trofee)

-- Arbore (în fișierul pdf cu rezolvările)


-- 17. a. Realizarea normalizării BCNF, FN4, FN5.
--     b. Aplicarea denormalizării, justificând necesitatea acesteia.

            -- Rezolvarea în fișierul pdf cu rezolvările