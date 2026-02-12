DROP SEQUENCE seq_calator;
DROP SEQUENCE seq_legitimatie;
DROP SEQUENCE seq_promotie;
DROP SEQUENCE seq_tip_bilet;
DROP SEQUENCE seq_clasa;
DROP SEQUENCE seq_bilet;
DROP SEQUENCE seq_tren;
DROP SEQUENCE seq_vagon;
DROP SEQUENCE seq_ruta;
DROP SEQUENCE seq_operator_feroviar;

DROP TABLE legitimatie CASCADE CONSTRAINTS;
DROP TABLE bilet CASCADE CONSTRAINTS;
DROP TABLE tarif CASCADE CONSTRAINTS;
DROP TABLE program_tren CASCADE CONSTRAINTS;
DROP TABLE vagon CASCADE CONSTRAINTS;
DROP TABLE tren CASCADE CONSTRAINTS;
DROP TABLE ruta CASCADE CONSTRAINTS;
DROP TABLE statie CASCADE CONSTRAINTS;
DROP TABLE operator_feroviar CASCADE CONSTRAINTS;
DROP TABLE clasa CASCADE CONSTRAINTS;
DROP TABLE tip_bilet CASCADE CONSTRAINTS;
DROP TABLE promotie CASCADE CONSTRAINTS;
DROP TABLE calator CASCADE CONSTRAINTS;

CREATE SEQUENCE seq_calator START WITH 1;
CREATE SEQUENCE seq_legitimatie START WITH 1;
CREATE SEQUENCE seq_promotie START WITH 1;
CREATE SEQUENCE seq_tip_bilet START WITH 1;
CREATE SEQUENCE seq_clasa START WITH 1;
CREATE SEQUENCE seq_bilet START WITH 1;
CREATE SEQUENCE seq_tren START WITH 1;
CREATE SEQUENCE seq_vagon START WITH 1;
CREATE SEQUENCE seq_ruta START WITH 1;
CREATE SEQUENCE seq_operator_feroviar START WITH 1;

-- CALATOR
CREATE TABLE calator (
    id_calator 	NUMBER PRIMARY KEY,
    nume 				VARCHAR2(50) NOT NULL,
    prenume 		VARCHAR2(50) NOT NULL,
    cnp 				CHAR(13) 		 UNIQUE NOT NULL,
    email 			VARCHAR2(100)
);

-- Inserări
INSERT INTO calator VALUES (seq_calator.NEXTVAL, 'Popescu', 'Andrei', '1980101123456', 'andrei@email.com');
INSERT INTO calator VALUES (seq_calator.NEXTVAL, 'Ionescu', 'Maria', '2990101789012', 'maria@email.com');
INSERT INTO calator VALUES (seq_calator.NEXTVAL, 'Georgescu', 'Vlad', '3000525123456', NULL);
INSERT INTO calator VALUES (seq_calator.NEXTVAL, 'Dumitrescu', 'Irina', '2950601134987', 'irina@email.com');
INSERT INTO calator VALUES (seq_calator.NEXTVAL, 'Radu', 'Mihai', '1960825102030', 'mihai@email.com');

-- PROMOTIE
CREATE TABLE promotie (
    id_promotie NUMBER PRIMARY KEY,
    denumire VARCHAR2(100) NOT NULL UNIQUE,
    procent_reducere NUMBER(3) CHECK (procent_reducere BETWEEN 1 AND 100) NOT NULL,
    conditie VARCHAR2(200)
);

-- Inserări
INSERT INTO promotie VALUES (seq_promotie.NEXTVAL, 'Student', 50, 'Legitimație student valabilă');
INSERT INTO promotie VALUES (seq_promotie.NEXTVAL, 'Pensionar', 100, 'Act de pensionare');
INSERT INTO promotie VALUES (seq_promotie.NEXTVAL, 'Elev', 75, 'Carnet vizat');
INSERT INTO promotie VALUES (seq_promotie.NEXTVAL, 'Militar', 25, 'Ordin de deplasare');
INSERT INTO promotie VALUES (seq_promotie.NEXTVAL, 'Weekend', 10, 'Călătorie în weekend');

-- TIP_BILET
CREATE TABLE tip_bilet (
    id_tip_bilet NUMBER PRIMARY KEY,
    denumire VARCHAR2(30) NOT NULL UNIQUE,
    descriere VARCHAR2(200)
);

-- Inserări
INSERT INTO tip_bilet VALUES (seq_tip_bilet.NEXTVAL, 'Dus', 'Călătorie simplă dus');
INSERT INTO tip_bilet VALUES (seq_tip_bilet.NEXTVAL, 'Dus-întors', 'Călătorie dus-întors');
INSERT INTO tip_bilet VALUES (seq_tip_bilet.NEXTVAL, 'Abonament', 'Valabil pentru 30 zile');
INSERT INTO tip_bilet VALUES (seq_tip_bilet.NEXTVAL, 'Reducere 50%', 'Reducere permanentă');
INSERT INTO tip_bilet VALUES (seq_tip_bilet.NEXTVAL, 'Flex', 'Modificabil cu taxă');

-- CLASA
CREATE TABLE clasa (
    id_clasa NUMBER PRIMARY KEY,
    denumire VARCHAR2(30) NOT NULL UNIQUE,
    suprataxa NUMBER(4,2) DEFAULT 0 CHECK (suprataxa >= 0)
);

-- Inserări
INSERT INTO clasa VALUES (seq_clasa.NEXTVAL, 'Clasa I', 15.00);
INSERT INTO clasa VALUES (seq_clasa.NEXTVAL, 'Clasa a II-a', 0.00);
INSERT INTO clasa VALUES (seq_clasa.NEXTVAL, 'Clasa business', 25.00);
INSERT INTO clasa VALUES (seq_clasa.NEXTVAL, 'Clasa eco', 0.00);
INSERT INTO clasa VALUES (seq_clasa.NEXTVAL, 'Clasa turistic', 5.00);

-- OPERATOR_FEROVIAR
CREATE TABLE operator_feroviar (
    id_operator_feroviar NUMBER PRIMARY KEY,
    denumire VARCHAR2(100) NOT NULL UNIQUE,
    tip VARCHAR2(20) CHECK (tip IN ('public', 'privat')) NOT NULL,
    cod_inregistrare VARCHAR2(30) UNIQUE NOT NULL
);

-- Inserări
INSERT INTO operator_feroviar VALUES (seq_operator_feroviar.NEXTVAL, 'CFR Călători', 'public', 'RO123456');
INSERT INTO operator_feroviar VALUES (seq_operator_feroviar.NEXTVAL, 'RegioTrans', 'privat', 'RO654321');
INSERT INTO operator_feroviar VALUES (seq_operator_feroviar.NEXTVAL, 'Transferoviar', 'privat', 'RO789000');
INSERT INTO operator_feroviar VALUES (seq_operator_feroviar.NEXTVAL, 'Softrans', 'privat', 'RO111222');
INSERT INTO operator_feroviar VALUES (seq_operator_feroviar.NEXTVAL, 'CFR Marfă', 'public', 'RO333444');

-- STATIE
CREATE TABLE statie (
    nume VARCHAR2(100) PRIMARY KEY,
    oras VARCHAR2(100) NOT NULL,
    judet VARCHAR2(100) NOT NULL
);

-- Inserări
INSERT INTO statie VALUES ('București Nord', 'București', 'Ilfov');
INSERT INTO statie VALUES ('Brașov', 'Brașov', 'Brașov');
INSERT INTO statie VALUES ('Sinaia', 'Sinaia', 'Prahova');
INSERT INTO statie VALUES ('Sibiu', 'Sibiu', 'Sibiu');
INSERT INTO statie VALUES ('Timișoara Nord', 'Timișoara', 'Timiș');

-- RUTA
CREATE TABLE ruta (
    id_ruta NUMBER PRIMARY KEY,
    data_start DATE NOT NULL,
    statie_plecare VARCHAR2(100) NOT NULL,
    statie_sosire VARCHAR2(100) NOT NULL,
    FOREIGN KEY (statie_plecare) REFERENCES statie(nume),
    FOREIGN KEY (statie_sosire) REFERENCES statie(nume)
);

-- Inserări
INSERT INTO ruta VALUES (seq_ruta.NEXTVAL, TO_DATE('2025-07-01', 'YYYY-MM-DD'), 'București Nord', 'Brașov');
INSERT INTO ruta VALUES (seq_ruta.NEXTVAL, TO_DATE('2025-07-01', 'YYYY-MM-DD'), 'Brașov', 'Sibiu');
INSERT INTO ruta VALUES (seq_ruta.NEXTVAL, TO_DATE('2025-07-02', 'YYYY-MM-DD'), 'Sibiu', 'Timișoara Nord');
INSERT INTO ruta VALUES (seq_ruta.NEXTVAL, TO_DATE('2025-07-02', 'YYYY-MM-DD'), 'Timișoara Nord', 'Sinaia');
INSERT INTO ruta VALUES (seq_ruta.NEXTVAL, TO_DATE('2025-07-03', 'YYYY-MM-DD'), 'Sinaia', 'București Nord');

-- TREN
CREATE TABLE tren (
    id_tren NUMBER PRIMARY KEY,
    numar_tren VARCHAR2(10) UNIQUE NOT NULL,
    categorie VARCHAR2(20) CHECK (categorie IN ('IR', 'R', 'RE')) NOT NULL,
    id_operator_feroviar NUMBER NOT NULL,
    id_ruta NUMBER NOT NULL,
    FOREIGN KEY (id_operator_feroviar) REFERENCES operator_feroviar(id_operator_feroviar),
    FOREIGN KEY (id_ruta) REFERENCES ruta(id_ruta)
);

-- Inserări
INSERT INTO tren VALUES (seq_tren.NEXTVAL, 'IR123', 'IR', 1, 1);
INSERT INTO tren VALUES (seq_tren.NEXTVAL, 'R456', 'R', 2, 2);
INSERT INTO tren VALUES (seq_tren.NEXTVAL, 'IR789', 'IR', 3, 3);
INSERT INTO tren VALUES (seq_tren.NEXTVAL, 'RE321', 'RE', 4, 4);
INSERT INTO tren VALUES (seq_tren.NEXTVAL, 'R654', 'R', 1, 5);

-- VAGON
CREATE TABLE vagon (
    id_vagon NUMBER PRIMARY KEY,
    id_tren NUMBER NOT NULL,
    id_clasa NUMBER NOT NULL,
    numar_vagon NUMBER NOT NULL CHECK (numar_vagon >= 1),
    FOREIGN KEY (id_tren) REFERENCES tren(id_tren),
    FOREIGN KEY (id_clasa) REFERENCES clasa(id_clasa)
);

-- Inserări
INSERT INTO vagon VALUES (seq_vagon.NEXTVAL, 1, 1, 1);
INSERT INTO vagon VALUES (seq_vagon.NEXTVAL, 1, 2, 2);
INSERT INTO vagon VALUES (seq_vagon.NEXTVAL, 2, 2, 1);
INSERT INTO vagon VALUES (seq_vagon.NEXTVAL, 3, 1, 1);
INSERT INTO vagon VALUES (seq_vagon.NEXTVAL, 3, 2, 2);

-- PROGRAM_TREN (entitate asociativă între RUTA și STATIE)
CREATE TABLE program_tren (
    id_ruta NUMBER NOT NULL,
    nume_statie VARCHAR2(100) NOT NULL,
    pozitie NUMBER NOT NULL CHECK (pozitie >= 1),
    ora_sosire DATE,
    ora_plecare DATE,
    PRIMARY KEY (id_ruta, nume_statie),
    FOREIGN KEY (id_ruta) REFERENCES ruta(id_ruta),
    FOREIGN KEY (nume_statie) REFERENCES statie(nume)
);

-- Inserări
INSERT INTO program_tren VALUES (1, 'București Nord', 1, NULL, TO_DATE('08:00', 'HH24:MI'));
INSERT INTO program_tren VALUES (1, 'Sinaia', 2, TO_DATE('09:15', 'HH24:MI'), TO_DATE('09:17', 'HH24:MI'));
INSERT INTO program_tren VALUES (1, 'Brașov', 3, TO_DATE('10:30', 'HH24:MI'), NULL);
INSERT INTO program_tren VALUES (2, 'Brașov', 1, NULL, TO_DATE('11:00', 'HH24:MI'));
INSERT INTO program_tren VALUES (2, 'Sibiu', 2, TO_DATE('13:15', 'HH24:MI'), NULL);
INSERT INTO program_tren VALUES (3, 'Sibiu', 1, NULL, TO_DATE('14:00', 'HH24:MI'));
INSERT INTO program_tren VALUES (3, 'Timișoara Nord', 2, TO_DATE('18:00', 'HH24:MI'), NULL);
INSERT INTO program_tren VALUES (4, 'Timișoara Nord', 1, NULL, TO_DATE('07:30', 'HH24:MI'));
INSERT INTO program_tren VALUES (4, 'Sinaia', 2, TO_DATE('13:45', 'HH24:MI'), NULL);
INSERT INTO program_tren VALUES (5, 'Sinaia', 1, NULL, TO_DATE('16:00', 'HH24:MI'));

-- TARIF (relație ternară)
CREATE TABLE tarif (
    id_ruta NUMBER NOT NULL,
    id_clasa NUMBER NOT NULL,
    id_tip_bilet NUMBER NOT NULL,
    valoare_tarif NUMBER(6,2) NOT NULL CHECK (valoare_tarif > 0),
    PRIMARY KEY (id_ruta, id_clasa, id_tip_bilet),
    FOREIGN KEY (id_ruta) REFERENCES ruta(id_ruta),
    FOREIGN KEY (id_clasa) REFERENCES clasa(id_clasa),
    FOREIGN KEY (id_tip_bilet) REFERENCES tip_bilet(id_tip_bilet)
);

-- Inserări
INSERT INTO tarif VALUES (1, 1, 1, 80.00);
INSERT INTO tarif VALUES (1, 2, 1, 50.00);
INSERT INTO tarif VALUES (1, 1, 2, 140.00);
INSERT INTO tarif VALUES (2, 1, 1, 60.00);
INSERT INTO tarif VALUES (2, 2, 1, 40.00);
INSERT INTO tarif VALUES (3, 1, 1, 120.00);
INSERT INTO tarif VALUES (3, 2, 2, 180.00);
INSERT INTO tarif VALUES (4, 1, 1, 90.00);
INSERT INTO tarif VALUES (5, 1, 1, 85.00);
INSERT INTO tarif VALUES (5, 2, 2, 130.00);

-- BILET
CREATE TABLE bilet (
    id_bilet NUMBER PRIMARY KEY,
    id_calator NUMBER NOT NULL,
    id_tren NUMBER NOT NULL,
    id_clasa NUMBER NOT NULL,
    id_tip_bilet NUMBER NOT NULL,
    id_promotie NUMBER,
    data_emitere DATE DEFAULT SYSDATE NOT NULL,
    data_calatorie DATE NOT NULL,
    pret_final NUMBER(6,2) NOT NULL CHECK (pret_final > 0),
    FOREIGN KEY (id_calator) REFERENCES calator(id_calator),
    FOREIGN KEY (id_tren) REFERENCES tren(id_tren),
    FOREIGN KEY (id_clasa) REFERENCES clasa(id_clasa),
    FOREIGN KEY (id_tip_bilet) REFERENCES tip_bilet(id_tip_bilet),
    FOREIGN KEY (id_promotie) REFERENCES promotie(id_promotie)
);

-- Inserări
INSERT INTO bilet VALUES (seq_bilet.NEXTVAL, 1, 1, 1, 1, 1, SYSDATE, TO_DATE('2025-07-01', 'YYYY-MM-DD'), 40.00);
INSERT INTO bilet VALUES (seq_bilet.NEXTVAL, 2, 1, 2, 1, 2, SYSDATE, TO_DATE('2025-07-01', 'YYYY-MM-DD'), 25.00);
INSERT INTO bilet VALUES (seq_bilet.NEXTVAL, 3, 2, 2, 2, NULL, SYSDATE, TO_DATE('2025-07-01', 'YYYY-MM-DD'), 80.00);
INSERT INTO bilet VALUES (seq_bilet.NEXTVAL, 4, 3, 1, 2, 1, SYSDATE, TO_DATE('2025-07-02', 'YYYY-MM-DD'), 70.00);
INSERT INTO bilet VALUES (seq_bilet.NEXTVAL, 5, 4, 2, 1, NULL, SYSDATE, TO_DATE('2025-07-03', 'YYYY-MM-DD'), 60.00);

-- LEGITIMATIE
CREATE TABLE legitimatie (
    id_legitimatie NUMBER PRIMARY KEY,
    id_calator NUMBER NOT NULL,
    id_promotie NUMBER NOT NULL,
    emitent VARCHAR2(100) NOT NULL,
    valabil_pana_la DATE NOT NULL,
    UNIQUE (id_calator, id_promotie),
    FOREIGN KEY (id_calator) REFERENCES calator(id_calator),
    FOREIGN KEY (id_promotie) REFERENCES promotie(id_promotie)
);

-- Inserări
INSERT INTO legitimatie VALUES (seq_legitimatie.NEXTVAL, 1, 1, 'UBB', TO_DATE('2025-12-31', 'YYYY-MM-DD'));
INSERT INTO legitimatie VALUES (seq_legitimatie.NEXTVAL, 2, 2, 'Casa de Pensii', TO_DATE('2025-12-31', 'YYYY-MM-DD'));
INSERT INTO legitimatie VALUES (seq_legitimatie.NEXTVAL, 4, 1, 'ASE', TO_DATE('2025-10-31', 'YYYY-MM-DD'));
INSERT INTO legitimatie VALUES (seq_legitimatie.NEXTVAL, 5, 5, 'Platforma Weekend', TO_DATE('2025-08-31', 'YYYY-MM-DD'));
INSERT INTO legitimatie VALUES (seq_legitimatie.NEXTVAL, 3, 4, 'Ministerul Apărării', TO_DATE('2025-09-30', 'YYYY-MM-DD'));

