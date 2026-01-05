-- Ștergere tabele
DROP TABLE POZITII_PREFERATE CASCADE CONSTRAINTS;
DROP TABLE JUCATOR CASCADE CONSTRAINTS;
DROP TABLE ANTRENOR CASCADE CONSTRAINTS;
DROP TABLE DOCTOR CASCADE CONSTRAINTS;
DROP TABLE MECI CASCADE CONSTRAINTS;
DROP TABLE CONTRACT CASCADE CONSTRAINTS;
DROP TABLE OM CASCADE CONSTRAINTS;
DROP TABLE POZITII CASCADE CONSTRAINTS;
DROP TABLE ETAPA CASCADE CONSTRAINTS;
DROP TABLE COMPETITIE CASCADE CONSTRAINTS;
DROP TABLE STADION CASCADE CONSTRAINTS;
DROP TABLE SPONSOR CASCADE CONSTRAINTS;
DROP TABLE CLUB CASCADE CONSTRAINTS;
COMMIT;

-- Ștergere secvențe
DROP SEQUENCE seq_club;
DROP SEQUENCE seq_stadion;
DROP SEQUENCE seq_sponsor;
DROP SEQUENCE seq_competitie;
DROP SEQUENCE seq_etapa;
DROP SEQUENCE seq_om;
DROP SEQUENCE seq_pozitie;
COMMIT;

-- Creare secvențe
CREATE SEQUENCE seq_club START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_stadion START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_sponsor START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_competitie START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_etapa START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_om START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_pozitie START WITH 1 INCREMENT BY 1;
COMMIT;

-- Creare tabele
CREATE TABLE CLUB (
    id_club NUMBER PRIMARY KEY,
    nume_club VARCHAR2(100),
    trofee NUMBER,
    meciuri_castigate NUMBER
);

CREATE TABLE STADION (
    id_stadion NUMBER PRIMARY KEY,
    id_club NUMBER REFERENCES CLUB(id_club),
    nume_stadion VARCHAR2(100),
    adresa VARCHAR2(200)
);

CREATE TABLE SPONSOR (
    id_sponsor NUMBER PRIMARY KEY,
    nume_sponsor VARCHAR2(100)
);

CREATE TABLE COMPETITIE (
    id_competitie NUMBER PRIMARY KEY,
    nume_competitie VARCHAR2(100)
);

CREATE TABLE ETAPA (
    id_etapa NUMBER PRIMARY KEY,
    id_competitie NUMBER REFERENCES COMPETITIE(id_competitie)
);

CREATE TABLE OM (
    id_om NUMBER PRIMARY KEY,
    id_club NUMBER REFERENCES CLUB(id_club),
    nume_om VARCHAR2(100),
    CNP CHAR(13),
    varsta_om NUMBER,
    salariu NUMBER(10,2)
);

CREATE TABLE JUCATOR (
    id_om NUMBER PRIMARY KEY REFERENCES OM(id_om),
    calitati_sportive CLOB,
    numar_meciuri_jucate NUMBER
);

CREATE TABLE ANTRENOR (
    id_om NUMBER PRIMARY KEY REFERENCES OM(id_om),
    ani_experienta NUMBER,
    meciuri_castigate NUMBER
);

CREATE TABLE DOCTOR (
    id_om NUMBER PRIMARY KEY REFERENCES OM(id_om),
    ani_experienta NUMBER,
    specializare VARCHAR2(100)
);

CREATE TABLE POZITII (
    id_pozitie NUMBER PRIMARY KEY,
    nume_pozitie VARCHAR2(50)
);

CREATE TABLE POZITII_PREFERATE (
    id_om NUMBER REFERENCES OM(id_om),
    id_pozitie NUMBER REFERENCES POZITII(id_pozitie),
    prioritate_poz NUMBER,
    PRIMARY KEY (id_om, id_pozitie)
);

CREATE TABLE CONTRACT (
    id_sponsor NUMBER REFERENCES SPONSOR(id_sponsor),
    id_club NUMBER REFERENCES CLUB(id_club),
    id_competitie NUMBER REFERENCES COMPETITIE(id_competitie),
    suma_sponsorizare NUMBER(10,2),
    durata_contract NUMBER,
    data_semnarii DATE,
    PRIMARY KEY (id_sponsor, id_club, id_competitie)
);

CREATE TABLE MECI (
    id_echipa_gazda NUMBER REFERENCES CLUB(id_club),
    id_echipa_oaspete NUMBER REFERENCES CLUB(id_club),
    id_etapa NUMBER REFERENCES ETAPA(id_etapa),
    id_competitie NUMBER REFERENCES COMPETITIE(id_competitie),
    goluri_marcate NUMBER,
    rezultate VARCHAR2(20),
    PRIMARY KEY (id_echipa_gazda, id_echipa_oaspete, id_etapa, id_competitie)
);
COMMIT;

-- Inserare date CLUB
INSERT INTO CLUB (id_club, nume_club, trofee, meciuri_castigate) VALUES (seq_club.NEXTVAL, 'Steaua București', 25, 350);
INSERT INTO CLUB (id_club, nume_club, trofee, meciuri_castigate) VALUES (seq_club.NEXTVAL, 'Dinamo București', 18, 290);
INSERT INTO CLUB (id_club, nume_club, trofee, meciuri_castigate) VALUES (seq_club.NEXTVAL, 'Rapid București', 12, 220);
INSERT INTO CLUB (id_club, nume_club, trofee, meciuri_castigate) VALUES (seq_club.NEXTVAL, 'CFR Cluj', 14, 310);
INSERT INTO CLUB (id_club, nume_club, trofee, meciuri_castigate) VALUES (seq_club.NEXTVAL, 'Universitatea Craiova', 10, 200);
COMMIT;

-- Inserare date STADION
INSERT INTO STADION (id_stadion, id_club, nume_stadion, adresa) VALUES (seq_stadion.NEXTVAL, 1, 'Arena Națională', 'Bd. Basarabia, București');
INSERT INTO STADION (id_stadion, id_club, nume_stadion, adresa) VALUES (seq_stadion.NEXTVAL, 2, 'Stadion Dinamo', 'Ștefan cel Mare, București');
INSERT INTO STADION (id_stadion, id_club, nume_stadion, adresa) VALUES (seq_stadion.NEXTVAL, 3, 'Giulești', 'Calea Giulești, București');
INSERT INTO STADION (id_stadion, id_club, nume_stadion, adresa) VALUES (seq_stadion.NEXTVAL, 4, 'Dr. Constantin Rădulescu', 'Cluj-Napoca');
INSERT INTO STADION (id_stadion, id_club, nume_stadion, adresa) VALUES (seq_stadion.NEXTVAL, 5, 'Ion Oblemenco', 'Craiova');
COMMIT;

-- Inserare date SPONSOR
INSERT INTO SPONSOR (id_sponsor, nume_sponsor) VALUES (seq_sponsor.NEXTVAL, 'Nike');
INSERT INTO SPONSOR (id_sponsor, nume_sponsor) VALUES (seq_sponsor.NEXTVAL, 'Adidas');
INSERT INTO SPONSOR (id_sponsor, nume_sponsor) VALUES (seq_sponsor.NEXTVAL, 'Puma');
INSERT INTO SPONSOR (id_sponsor, nume_sponsor) VALUES (seq_sponsor.NEXTVAL, 'Pepsi');
INSERT INTO SPONSOR (id_sponsor, nume_sponsor) VALUES (seq_sponsor.NEXTVAL, 'Orange');
COMMIT;

-- Inserare date COMPETITIE
INSERT INTO COMPETITIE (id_competitie, nume_competitie) VALUES (seq_competitie.NEXTVAL, 'Liga 1');
INSERT INTO COMPETITIE (id_competitie, nume_competitie) VALUES (seq_competitie.NEXTVAL, 'Cupa României');
INSERT INTO COMPETITIE (id_competitie, nume_competitie) VALUES (seq_competitie.NEXTVAL, 'Supercupa');
INSERT INTO COMPETITIE (id_competitie, nume_competitie) VALUES (seq_competitie.NEXTVAL, 'Europa League');
INSERT INTO COMPETITIE (id_competitie, nume_competitie) VALUES (seq_competitie.NEXTVAL, 'Champions League');
COMMIT;

-- Inserare date ETAPA
INSERT INTO ETAPA (id_etapa, id_competitie) VALUES (seq_etapa.NEXTVAL, 1);
INSERT INTO ETAPA (id_etapa, id_competitie) VALUES (seq_etapa.NEXTVAL, 2);
INSERT INTO ETAPA (id_etapa, id_competitie) VALUES (seq_etapa.NEXTVAL, 3);
INSERT INTO ETAPA (id_etapa, id_competitie) VALUES (seq_etapa.NEXTVAL, 4);
INSERT INTO ETAPA (id_etapa, id_competitie) VALUES (seq_etapa.NEXTVAL, 5);
COMMIT;

-- Inserare date POZITII
INSERT INTO POZITII (id_pozitie, nume_pozitie) VALUES (seq_pozitie.NEXTVAL, 'Portar');
INSERT INTO POZITII (id_pozitie, nume_pozitie) VALUES (seq_pozitie.NEXTVAL, 'Fundas');
INSERT INTO POZITII (id_pozitie, nume_pozitie) VALUES (seq_pozitie.NEXTVAL, 'Mijlocas');
INSERT INTO POZITII (id_pozitie, nume_pozitie) VALUES (seq_pozitie.NEXTVAL, 'Atacant');
INSERT INTO POZITII (id_pozitie, nume_pozitie) VALUES (seq_pozitie.NEXTVAL, 'Extrema');
COMMIT;

-- Inserare date OM și entități dependente

-- Jucători
-- Jucator 1
INSERT INTO OM (id_om, id_club, nume_om, CNP, varsta_om, salariu) VALUES (seq_om.NEXTVAL, 2, 'Jucator 1', '5000000000001', 21, 3010);
INSERT INTO JUCATOR (id_om, calitati_sportive, numar_meciuri_jucate) VALUES (seq_om.CURRVAL, 'Calitati 1', 51);

-- Jucator 2
INSERT INTO OM (id_om, id_club, nume_om, CNP, varsta_om, salariu) VALUES (seq_om.NEXTVAL, 3, 'Jucator 2', '5000000000002', 22, 3020);
INSERT INTO JUCATOR (id_om, calitati_sportive, numar_meciuri_jucate) VALUES (seq_om.CURRVAL, 'Calitati 2', 52);

-- Jucator 3
INSERT INTO OM (id_om, id_club, nume_om, CNP, varsta_om, salariu) VALUES (seq_om.NEXTVAL, 4, 'Jucator 3', '5000000000003', 23, 3030);
INSERT INTO JUCATOR (id_om, calitati_sportive, numar_meciuri_jucate) VALUES (seq_om.CURRVAL, 'Calitati 3', 53);

-- Jucator 4
INSERT INTO OM (id_om, id_club, nume_om, CNP, varsta_om, salariu) VALUES (seq_om.NEXTVAL, 5, 'Jucator 4', '5000000000004', 24, 3040);
INSERT INTO JUCATOR (id_om, calitati_sportive, numar_meciuri_jucate) VALUES (seq_om.CURRVAL, 'Calitati 4', 54);

-- Jucator 5
INSERT INTO OM (id_om, id_club, nume_om, CNP, varsta_om, salariu) VALUES (seq_om.NEXTVAL, 1, 'Jucator 5', '5000000000005', 25, 3050);
INSERT INTO JUCATOR (id_om, calitati_sportive, numar_meciuri_jucate) VALUES (seq_om.CURRVAL, 'Calitati 5', 55);

-- Jucator 6
INSERT INTO OM (id_om, id_club, nume_om, CNP, varsta_om, salariu) VALUES (seq_om.NEXTVAL, 2, 'Jucator 6', '5000000000006', 26, 3060);
INSERT INTO JUCATOR (id_om, calitati_sportive, numar_meciuri_jucate) VALUES (seq_om.CURRVAL, 'Calitati 6', 56);

-- Jucator 7
INSERT INTO OM (id_om, id_club, nume_om, CNP, varsta_om, salariu) VALUES (seq_om.NEXTVAL, 3, 'Jucator 7', '5000000000007', 27, 3070);
INSERT INTO JUCATOR (id_om, calitati_sportive, numar_meciuri_jucate) VALUES (seq_om.CURRVAL, 'Calitati 7', 57);

-- Jucator 8
INSERT INTO OM (id_om, id_club, nume_om, CNP, varsta_om, salariu) VALUES (seq_om.NEXTVAL, 4, 'Jucator 8', '5000000000008', 28, 3080);
INSERT INTO JUCATOR (id_om, calitati_sportive, numar_meciuri_jucate) VALUES (seq_om.CURRVAL, 'Calitati 8', 58);

-- Jucator 9
INSERT INTO OM (id_om, id_club, nume_om, CNP, varsta_om, salariu) VALUES (seq_om.NEXTVAL, 5, 'Jucator 9', '5000000000009', 29, 3090);
INSERT INTO JUCATOR (id_om, calitati_sportive, numar_meciuri_jucate) VALUES (seq_om.CURRVAL, 'Calitati 9', 59);

-- Jucator 10
INSERT INTO OM (id_om, id_club, nume_om, CNP, varsta_om, salariu) VALUES (seq_om.NEXTVAL, 1, 'Jucator 10', '5000000000010', 30, 3100);
INSERT INTO JUCATOR (id_om, calitati_sportive, numar_meciuri_jucate) VALUES (seq_om.CURRVAL, 'Calitati 10', 60);

-- Antrenori
-- Antrenor 11
INSERT INTO OM (id_om, id_club, nume_om, CNP, varsta_om, salariu) VALUES (seq_om.NEXTVAL, 2, 'Antrenor 11', '6000000000011', 46, 5220);
INSERT INTO ANTRENOR (id_om, ani_experienta, meciuri_castigate) VALUES (seq_om.CURRVAL, 21, 111);

-- Antrenor 12
INSERT INTO OM (id_om, id_club, nume_om, CNP, varsta_om, salariu) VALUES (seq_om.NEXTVAL, 3, 'Antrenor 12', '6000000000012', 47, 5240);
INSERT INTO ANTRENOR (id_om, ani_experienta, meciuri_castigate) VALUES (seq_om.CURRVAL, 22, 112);

-- Antrenor 13
INSERT INTO OM (id_om, id_club, nume_om, CNP, varsta_om, salariu) VALUES (seq_om.NEXTVAL, 4, 'Antrenor 13', '6000000000013', 48, 5260);
INSERT INTO ANTRENOR (id_om, ani_experienta, meciuri_castigate) VALUES (seq_om.CURRVAL, 23, 113);

-- Antrenor 14
INSERT INTO OM (id_om, id_club, nume_om, CNP, varsta_om, salariu) VALUES (seq_om.NEXTVAL, 5, 'Antrenor 14', '6000000000014', 49, 5280);
INSERT INTO ANTRENOR (id_om, ani_experienta, meciuri_castigate) VALUES (seq_om.CURRVAL, 24, 114);

-- Antrenor 15
INSERT INTO OM (id_om, id_club, nume_om, CNP, varsta_om, salariu) VALUES (seq_om.NEXTVAL, 1, 'Antrenor 15', '6000000000015', 50, 5300);
INSERT INTO ANTRENOR (id_om, ani_experienta, meciuri_castigate) VALUES (seq_om.CURRVAL, 25, 115);

-- Doctori
-- Doctor 16
INSERT INTO OM (id_om, id_club, nume_om, CNP, varsta_om, salariu) VALUES (seq_om.NEXTVAL, 2, 'Doctor 16', '7000000000016', 35, 4100);
INSERT INTO DOCTOR (id_om, ani_experienta, specializare) VALUES (seq_om.CURRVAL, 10, 'Generalist');

-- Doctor 17
INSERT INTO OM (id_om, id_club, nume_om, CNP, varsta_om, salariu) VALUES (seq_om.NEXTVAL, 3, 'Doctor 17', '7000000000017', 38, 4200);
INSERT INTO DOCTOR (id_om, ani_experienta, specializare) VALUES (seq_om.CURRVAL, 13, 'Ortopedie');

-- Doctor 18
INSERT INTO OM (id_om, id_club, nume_om, CNP, varsta_om, salariu) VALUES (seq_om.NEXTVAL, 4, 'Doctor 18', '7000000000018', 40, 4300);
INSERT INTO DOCTOR (id_om, ani_experienta, specializare) VALUES (seq_om.CURRVAL, 15, 'Cardiologie');

-- Doctor 19
INSERT INTO OM (id_om, id_club, nume_om, CNP, varsta_om, salariu) VALUES (seq_om.NEXTVAL, 5, 'Doctor 19', '7000000000019', 32, 4000);
INSERT INTO DOCTOR (id_om, ani_experienta, specializare) VALUES (seq_om.CURRVAL, 7, 'Kinetoterapie');

-- Doctor 20
INSERT INTO OM (id_om, id_club, nume_om, CNP, varsta_om, salariu) VALUES (seq_om.NEXTVAL, 1, 'Doctor 20', '7000000000020', 45, 4500);
INSERT INTO DOCTOR (id_om, ani_experienta, specializare) VALUES (seq_om.CURRVAL, 20, 'Medicina sportiva');
COMMIT;

-- Inserare date POZITII_PREFERATE
-- Jucatorul 1
INSERT INTO POZITII_PREFERATE (id_om, id_pozitie, prioritate_poz) VALUES (1, 4, 1); -- Atacant
INSERT INTO POZITII_PREFERATE (id_om, id_pozitie, prioritate_poz) VALUES (1, 5, 2); -- Extrema

-- Jucatorul 2
INSERT INTO POZITII_PREFERATE (id_om, id_pozitie, prioritate_poz) VALUES (2, 3, 1); -- Mijlocas
INSERT INTO POZITII_PREFERATE (id_om, id_pozitie, prioritate_poz) VALUES (2, 4, 2); -- Atacant

-- Jucatorul 3
INSERT INTO POZITII_PREFERATE (id_om, id_pozitie, prioritate_poz) VALUES (3, 2, 1); -- Fundas

-- Jucatorul 4
INSERT INTO POZITII_PREFERATE (id_om, id_pozitie, prioritate_poz) VALUES (4, 1, 1); -- Portar

-- Jucatorul 5
INSERT INTO POZITII_PREFERATE (id_om, id_pozitie, prioritate_poz) VALUES (5, 3, 1); -- Mijlocas
INSERT INTO POZITII_PREFERATE (id_om, id_pozitie, prioritate_poz) VALUES (5, 5, 2); -- Extrema

-- Jucatorul 6
INSERT INTO POZITII_PREFERATE (id_om, id_pozitie, prioritate_poz) VALUES (6, 4, 1); -- Atacant

-- Jucatorul 7
INSERT INTO POZITII_PREFERATE (id_om, id_pozitie, prioritate_poz) VALUES (7, 2, 1); -- Fundas
INSERT INTO POZITII_PREFERATE (id_om, id_pozitie, prioritate_poz) VALUES (7, 3, 2); -- Mijlocas

-- Jucatorul 8
INSERT INTO POZITII_PREFERATE (id_om, id_pozitie, prioritate_poz) VALUES (8, 1, 1); -- Portar

-- Jucatorul 9 (ID 9)ITII_PREFERATE (id_om, id_pozitie, prioritate_poz) VALUES (9, 5, 1); -- Extrema

-- Jucator 10
INSERT INTO POZITII_PREFERATE (id_om, id_pozitie, prioritate_poz) VALUES (10, 4, 1); -- Atacant

COMMIT;

-- Inserare date CONTRACT
INSERT INTO CONTRACT (id_sponsor, id_club, id_competitie, suma_sponsorizare, durata_contract, data_semnarii) VALUES (1, 1, 1, 100000, 3, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO CONTRACT (id_sponsor, id_club, id_competitie, suma_sponsorizare, durata_contract, data_semnarii) VALUES (2, 2, 1, 80000, 2, TO_DATE('2022-03-20', 'YYYY-MM-DD'));
INSERT INTO CONTRACT (id_sponsor, id_club, id_competitie, suma_sponsorizare, durata_contract, data_semnarii) VALUES (3, 3, 2, 50000, 1, TO_DATE('2024-06-01', 'YYYY-MM-DD'));
INSERT INTO CONTRACT (id_sponsor, id_club, id_competitie, suma_sponsorizare, durata_contract, data_semnarii) VALUES (4, 4, 3, 75000, 4, TO_DATE('2023-11-10', 'YYYY-MM-DD'));
INSERT INTO CONTRACT (id_sponsor, id_club, id_competitie, suma_sponsorizare, durata_contract, data_semnarii) VALUES (5, 5, 4, 120000, 5, TO_DATE('2022-09-25', 'YYYY-MM-DD'));
INSERT INTO CONTRACT (id_sponsor, id_club, id_competitie, suma_sponsorizare, durata_contract, data_semnarii) VALUES (1, 2, 5, 90000, 3, TO_DATE('2023-04-01', 'YYYY-MM-DD'));
INSERT INTO CONTRACT (id_sponsor, id_club, id_competitie, suma_sponsorizare, durata_contract, data_semnarii) VALUES (2, 1, 2, 60000, 2, TO_DATE('2024-01-05', 'YYYY-MM-DD'));
INSERT INTO CONTRACT (id_sponsor, id_club, id_competitie, suma_sponsorizare, durata_contract, data_semnarii) VALUES (3, 4, 1, 70000, 3, TO_DATE('2023-07-18', 'YYYY-MM-DD'));
INSERT INTO CONTRACT (id_sponsor, id_club, id_competitie, suma_sponsorizare, durata_contract, data_semnarii) VALUES (4, 5, 2, 95000, 4, TO_DATE('2022-12-01', 'YYYY-MM-DD'));
INSERT INTO CONTRACT (id_sponsor, id_club, id_competitie, suma_sponsorizare, durata_contract, data_semnarii) VALUES (5, 3, 3, 55000, 1, TO_DATE('2024-02-14', 'YYYY-MM-DD'));
INSERT INTO CONTRACT (id_sponsor, id_club, id_competitie, suma_sponsorizare, durata_contract, data_semnarii) VALUES (1, 3, 1, 85000, 2, TO_DATE('2023-03-01', 'YYYY-MM-DD'));
INSERT INTO CONTRACT (id_sponsor, id_club, id_competitie, suma_sponsorizare, durata_contract, data_semnarii) VALUES (2, 4, 4, 110000, 5, TO_DATE('2022-10-10', 'YYYY-MM-DD'));
INSERT INTO CONTRACT (id_sponsor, id_club, id_competitie, suma_sponsorizare, durata_contract, data_semnarii) VALUES (3, 5, 5, 78000, 3, TO_DATE('2023-05-01', 'YYYY-MM-DD'));
INSERT INTO CONTRACT (id_sponsor, id_club, id_competitie, suma_sponsorizare, durata_contract, data_semnarii) VALUES (4, 1, 1, 92000, 4, TO_DATE('2022-11-20', 'YYYY-MM-DD'));
INSERT INTO CONTRACT (id_sponsor, id_club, id_competitie, suma_sponsorizare, durata_contract, data_semnarii) VALUES (5, 2, 2, 65000, 2, TO_DATE('2024-04-05', 'YYYY-MM-DD'));
COMMIT;

-- Inserare date MECI
INSERT INTO MECI (id_echipa_gazda, id_echipa_oaspete, id_etapa, id_competitie, goluri_marcate, rezultate) VALUES (1, 2, 1, 1, 3, '3-1');
INSERT INTO MECI (id_echipa_gazda, id_echipa_oaspete, id_etapa, id_competitie, goluri_marcate, rezultate) VALUES (3, 4, 1, 1, 2, '2-2');
INSERT INTO MECI (id_echipa_gazda, id_echipa_oaspete, id_etapa, id_competitie, goluri_marcate, rezultate) VALUES (5, 1, 1, 1, 1, '0-1');
INSERT INTO MECI (id_echipa_gazda, id_echipa_oaspete, id_etapa, id_competitie, goluri_marcate, rezultate) VALUES (2, 3, 2, 1, 4, '4-0');
INSERT INTO MECI (id_echipa_gazda, id_echipa_oaspete, id_etapa, id_competitie, goluri_marcate, rezultate) VALUES (4, 5, 2, 1, 1, '1-1');
INSERT INTO MECI (id_echipa_gazda, id_echipa_oaspete, id_etapa, id_competitie, goluri_marcate, rezultate) VALUES (1, 3, 2, 1, 0, '0-0');
INSERT INTO MECI (id_echipa_gazda, id_echipa_oaspete, id_etapa, id_competitie, goluri_marcate, rezultate) VALUES (2, 4, 3, 1, 5, '5-2');
INSERT INTO MECI (id_echipa_gazda, id_echipa_oaspete, id_etapa, id_competitie, goluri_marcate, rezultate) VALUES (5, 3, 3, 1, 2, '2-1');
INSERT INTO MECI (id_echipa_gazda, id_echipa_oaspete, id_etapa, id_competitie, goluri_marcate, rezultate) VALUES (1, 4, 3, 1, 3, '3-0');
INSERT INTO MECI (id_echipa_gazda, id_echipa_oaspete, id_etapa, id_competitie, goluri_marcate, rezultate) VALUES (2, 5, 4, 1, 1, '1-0');
INSERT INTO MECI (id_echipa_gazda, id_echipa_oaspete, id_etapa, id_competitie, goluri_marcate, rezultate) VALUES (3, 1, 4, 1, 2, '2-3');
INSERT INTO MECI (id_echipa_gazda, id_echipa_oaspete, id_etapa, id_competitie, goluri_marcate, rezultate) VALUES (4, 2, 4, 1, 0, '0-0');
INSERT INTO MECI (id_echipa_gazda, id_echipa_oaspete, id_etapa, id_competitie, goluri_marcate, rezultate) VALUES (5, 1, 5, 1, 4, '4-2');
INSERT INTO MECI (id_echipa_gazda, id_echipa_oaspete, id_etapa, id_competitie, goluri_marcate, rezultate) VALUES (2, 3, 5, 1, 1, '1-1');
INSERT INTO MECI (id_echipa_gazda, id_echipa_oaspete, id_etapa, id_competitie, goluri_marcate, rezultate) VALUES (4, 5, 5, 1, 3, '3-1');
COMMIT;




ALTER TABLE CLUB
ADD id_antrenor NUMBER;


ALTER TABLE CLUB
ADD CONSTRAINT fk_antrenor
FOREIGN KEY (id_antrenor)
REFERENCES OM(id_om);

CREATE TABLE GOL (
    id_gol NUMBER PRIMARY KEY,
    id_echipa_gazda NUMBER,
    id_echipa_oaspete NUMBER,
    id_etapa NUMBER,
    id_competitie NUMBER,
    id_marcator NUMBER NOT NULL,
    minut NUMBER,
    id_jucator_pasa_decisiva NUMBER,
    FOREIGN KEY (id_echipa_gazda, id_echipa_oaspete, id_etapa, id_competitie)
        REFERENCES MECI(id_echipa_gazda, id_echipa_oaspete, id_etapa, id_competitie),
    FOREIGN KEY (id_marcator)
        REFERENCES JUCATOR(id_om),
    FOREIGN KEY (id_jucator_pasa_decisiva)
        REFERENCES JUCATOR(id_om)
);

UPDATE OM o
SET salariu =
    CASE
        WHEN (SELECT a.meciuri_castigate FROM ANTRENOR a WHERE a.id_om = o.id_om) <= 10 THEN o.salariu * 1.10
        WHEN (SELECT a.meciuri_castigate FROM ANTRENOR a WHERE a.id_om = o.id_om) > 10 THEN o.salariu * 1.20
        ELSE o.salariu
    END
WHERE o.id_om IN (
    SELECT a.id_om
    FROM ANTRENOR a
    JOIN CLUB c ON o.id_club = c.id_club
    WHERE c.nume_club = 'Dinamo București'
);