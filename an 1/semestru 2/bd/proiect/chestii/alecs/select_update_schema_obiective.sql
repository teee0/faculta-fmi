-- Exercițiu 12

-- Cerere 1: Subcerere sincronizată între 3 tabele

-- Selectează clienții care au realizat tranzacții cu valoare peste 500, doar dacă:
-- au oferit oferte în licitații la NFT-uri cu monede folosite în acele tranzacții,
-- și au cel puțin un NFT asociat cu un smart contract,
-- dar NU au fost validați în tabela validator.

-- * AICI AM MODIFICAT FATA DE VERSIUNEA PRECEDENTA
SELECT c.nume, c.email
FROM client c
WHERE EXISTS (
    SELECT 1 FROM tranzactie t
    WHERE t.id_client = c.id_client
    AND t.valoare > 500
    AND EXISTS (
        SELECT 1 FROM oferta o
        JOIN licitatie l ON o.id_licitatie = l.id_licitatie
        WHERE o.id_client = c.id_client
        AND EXISTS (
            SELECT 1 FROM nft n
            WHERE n.id_moneda = t.id_moneda
            AND EXISTS (
                SELECT 1 FROM smart_contract sc
                WHERE sc.id_nft = n.id_nft
            )
        )
    )
)
AND NOT EXISTS (
    SELECT 1 FROM validator v
    WHERE v.id_client = c.id_client
)
ORDER BY c.nume;

-- Cerere 2: Subcereri nesincronizate în clauza FROM
-- Afișează numărul total de clienți și numărul total de mineri.
SELECT
    clienti.total_clienti,
    mineri.total_miners
FROM
    (SELECT COUNT(*) AS total_clienti FROM client) clienti,
    (SELECT COUNT(*) AS total_miners FROM miner) mineri;


-- Cerere 3: Grupare + HAVING cu subcerere nesincronizată

-- Afișează ID-ul licitațiilor care au primit oferte cu o valoare
-- medie mai mare decât media tuturor ofertelor din sistem.
SELECT
    id_licitatie,
    AVG(valoare) AS medie_oferta
FROM oferta
GROUP BY id_licitatie
HAVING AVG(valoare) > (
    SELECT AVG(valoare) FROM oferta
);


-- Cerere 4: NVL + DECODE + ORDONARE

-- Afișează toate NFT-urile împreună cu simbolul monedei asociate
-- (sau „NECUNOSCUT” dacă nu există), și clasifică titlurile NFT-urilor
-- ca „SCURT”, „MEDIU” sau „LUNG” în funcție de lungimea titlului. Se vor
-- ordona rezultatele descrescător după lungimea titlului.
SELECT
    n.titlu,
    NVL(m.simbol, 'NECUNOSCUT') AS simbol_moneda,
    DECODE(
        LENGTH(n.titlu),
        0, 'GOL',
        1, 'SCURT',
        2, 'SCURT',
        3, 'SCURT',
        4, 'SCURT',
        5, 'SCURT',
        6, 'SCURT',
        7, 'SCURT',
        8, 'SCURT',
        9, 'SCURT',
        10, 'MEDIU',
        'LUNG'
    ) AS categorie_titlu
FROM nft n
LEFT JOIN moneda m ON n.id_moneda = m.id_moneda
ORDER BY LENGTH(n.titlu) DESC;


-- Cerere 5: Funcții pe șiruri, pe date calendaristice, expresie CASE, clauză WITH
-- Pentru fiecare ofertă, afișează numele clientului, primele 10 caractere din email,
-- data ofertei și un mesaj personalizat în funcție de ora ofertei: „Dimineața”,
-- „După-amiaza”, „Seara” sau „Noapte”.
WITH oferte_extinse AS (
    SELECT
        o.id_oferta,
        o.timestamp,
        o.valoare,
        c.nume,
        c.email
    FROM oferta o
    JOIN client c ON o.id_client = c.id_client
)
SELECT
    id_oferta,
    SUBSTR(email, 1, 10) AS email_partial,
    TO_CHAR(timestamp, 'YYYY-MM-DD') AS data_oferta,
    TO_CHAR(timestamp, 'HH24:MI:SS') AS ora_oferta,
    CASE
        WHEN EXTRACT(HOUR FROM timestamp) BETWEEN 6 AND 11 THEN 'Dimineața'
        WHEN EXTRACT(HOUR FROM timestamp) BETWEEN 12 AND 17 THEN 'După-amiaza'
        WHEN EXTRACT(HOUR FROM timestamp) BETWEEN 18 AND 21 THEN 'Seara'
        ELSE 'Noapte'
    END AS perioada_zi,
    INITCAP(nume) AS nume_formatat
FROM oferte_extinse;

----------------------------------------------------------------------------

-- Exercițiu 13

-- 1) UPDATE validatorii care nu au oferte
UPDATE validator v
SET nivel_validare = 'INACTIV'
WHERE v.id_client IN (
    SELECT v2.id_client
    FROM validator v2
    WHERE NOT EXISTS (
        SELECT 1 FROM oferta o WHERE o.id_client = v2.id_client
    )
);

-- 2) DELETE ofertele pentru licitații închise
DELETE FROM oferta
WHERE id_licitatie IN (
    SELECT l.id_licitatie
    FROM licitatie l
    WHERE l.data_sfarsit < SYSDATE
);

-- 3) DELETE tranzacțiile clienților care nu sunt validatori
DELETE FROM tranzactie
WHERE id_client IN (
    SELECT t.id_client
    FROM tranzactie t
    WHERE t.id_client NOT IN (
        SELECT v.id_client FROM validator v
    )
);
----------------------------------------------------------------------------

-- Exercițiu 14

-- GRANT CREATE VIEW TO alex;
CREATE OR REPLACE VIEW DETALII_NFT AS
SELECT
    n.titlu AS Titlu_NFT,
    m.simbol AS Simbol_Moneda,
    (SELECT ROUND(AVG(t.valoare), 2)
     FROM tranzactie t
     WHERE t.id_moneda = n.id_moneda) AS Pret_Mediu,
    (SELECT COUNT(DISTINCT t.id_client)
     FROM tranzactie t
     WHERE t.id_moneda = n.id_moneda) AS Numar_Clienti_Tranzactii,
    (SELECT MIN(t.data)
     FROM tranzactie t
     WHERE t.id_moneda = n.id_moneda) AS Prima_Tranzactie
FROM
    nft n
LEFT JOIN
    moneda m ON n.id_moneda = m.id_moneda;

-- OK
SELECT * FROM DETALII_NFT WHERE Simbol_Moneda = 'ETH';

-- NOT OK
INSERT INTO DETALII_NFT (Titlu_NFT, Simbol_Moneda) VALUES ('NFT Nou', 'ETH');

----------------------------------------------------------------------------

-- Exercițiu 15

-- 1) Afișează o listă de clienți împreună cu informații (dacă există) despre ofertele lor,
-- licitațiile corespunzătoare și un NFT arbitrar asociat printr-un smart contract.
SELECT
    c.id_client,
    c.nume AS nume_client,
    o.id_oferta,
    o.valoare AS valoare_oferta,
    l.id_licitatie,
    l.data_start,
    l.data_sfarsit,
    n.titlu AS titlu_nft
FROM client c
LEFT JOIN oferta o ON c.id_client = o.id_client
LEFT JOIN licitatie l ON o.id_licitatie = l.id_licitatie
LEFT JOIN smart_contract sc ON 1=1
LEFT JOIN nft n ON sc.id_nft = n.id_nft
WHERE ROWNUM <= 100
ORDER BY c.nume;

-- 2) Găsește toți clienții care au făcut oferte la toate licitațiile existente
SELECT UNIQUE c.id_client, c.nume
FROM client c
WHERE NOT EXISTS (
    (SELECT l.id_licitatie FROM licitatie l)
    MINUS
    (SELECT o.id_licitatie
     FROM oferta o
     WHERE o.id_client = c.id_client)
);

-- 3) Listează Top 3 clienți care au oferit cele mai mari sume totale în licitații
-- (oferta.valoare), ordonat descrescător.
SELECT ROWNUM AS RANK, nume_client, total_valoare
FROM (
    SELECT
        c.nume AS nume_client,
        SUM(o.valoare) AS total_valoare
    FROM client c
    JOIN oferta o ON c.id_client = o.id_client
    GROUP BY c.id_client, c.nume
    ORDER BY total_valoare DESC
)
WHERE ROWNUM <= 3;

----------------------------------------------------------------------------

-- Exercițiu 16 b)

WITH TRANZACTII_RECENTE AS (
    SELECT
           t.id_client,
           t.id_moneda,
           t.valoare,
           t.data
    FROM tranzactie t
    WHERE t.data >= TO_DATE('2024-01-01', 'YYYY-MM-DD')
)
SELECT
    c.nume AS nume_client,
    m.nume_moneda,
    COUNT(tr.id_client) AS nr_tranzactii,
    SUM(tr.valoare) AS suma_totala
FROM TRANZACTII_RECENTE tr
JOIN client c ON c.id_client = tr.id_client
JOIN moneda m ON m.id_moneda = tr.id_moneda
GROUP BY c.nume, m.nume_moneda
ORDER BY suma_totala DESC;

-- Optimizare 10 -> 9
DROP INDEX IDX_TRANZACTIE_DATA;
CREATE INDEX IDX_TRANZACTIE_DATA ON tranzactie(data);

-- Optimizare 10 -> 8
DROP INDEX IDX_TRANZACTIE_DATA_CLIENT_MONEDA_VAL;
CREATE INDEX IDX_TRANZACTIE_DATA_CLIENT_MONEDA_VAL ON tranzactie(data, id_client, id_moneda, valoare);
