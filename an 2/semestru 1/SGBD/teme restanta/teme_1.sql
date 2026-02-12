select id_carte as "misc"
from carte_tmb
union
select cod_carte
from imprumuta_tmb;

select id_carte, titlu, cod_domeniu
from carte_tmb
where cod_domeniu is not null;

select * from domeniu_tmb;

select count(*)
from carte, domeniu
where cod_domeniu = 100;

--division 
select nume
from cititor_tmb ci
where not exists (
    select id_carte 
    from carte ca
    where ca.cod_domeniu = 200 and not exists (
            select cod_carte 
            from imprumuta_tmb i
            where i.cod_cititor = ci.id_cititor
              and i.cod_carte = ca.id_carte
    )
);
    

select i.dataef, c.nume
from imprumuta_tmb i, cititor_tmb c;
--where i.cod_carte = c.id_carte 

describe carte;

select d.denumire, c.nrex
from domeniu_tmb d,carte_tmb c
where nrex = (select max(nrex) as maxperdom from carte c2 where c2.cod_domeniu= d.id_domeniu);


--de cate ori a fost imprumutata fiecare carte




--chat
set serveroutput on;
BEGIN
    FOR r_carte IN (SELECT titlu, autor 
                    FROM carte
                    WHERE cod_domeniu = 100 
                      AND autor is not null) LOOP
        DBMS_OUTPUT.PUT_LINE('Titlu: ' || r_carte.titlu || ' de ' || r_carte.autor);
    END LOOP;
END;
/
select titlu 
from carte
join
select cod_carte from imprumuta_tmb
where dataim = (select min(dataim) from imprumuta_tmb);

BEGIN 
    select cod_carte from imprumuta_tmb
    where dataim = (select min(dataim) from imprumuta_tmb);
END;
/