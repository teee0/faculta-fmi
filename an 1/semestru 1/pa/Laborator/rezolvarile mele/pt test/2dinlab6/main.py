f = open("elevi.in", "r")
D = {}
for linie in f:

    cnp, nume, prenume, note = linie.split(maxsplit=3)  # note este str

    cnp = int(cnp)
    L_note = [int(x) for x in note.split()]
    D[cnp] = [nume, prenume, L_note]

f.close()
# print(D)


## b)


def creste_nota(cnp, d):
    if cnp not in d:
        return None
    d[cnp][2][0] += 1
    return d[cnp][2][0]


#c)
'''Scrieți o funcție care primește ca parametri un cnp,
o listă de note și structura de date în care s-au memorat
datele despre elevi la punctul a) și adaugă lista de note la notele elevului
 cu cnp-ul primit ca parametru. Funcția returnează lista de note după modificare
 sau None dacă cnp-ul nu există.
 Apelați funcția pentru un cnp citit de la tastatură si lista l_note=[10,8].
'''
def adaugă_note(cnp,L_note,d):
    if cnp not in d:
        return None
    else:
        d[cnp][2].extend(L_note)
        return d[cnp][2]#lista de note a elevului cu cnpu cnp

adaugă_note(1412900000041,[1,2,3,3],D)
print(D)

#d
'''Scrieți o funcție care primește ca parametri un cnp
și structura de date în care s-au memorat datele despre elevi la punctul a)
și șterge informațiile despre elevul cu acest cnp.
Apelați funcția pentru un cnp citit de la tastatură
(dacă cnp-ul nu este în listă funcția nu va modifica nimic și nu va da eroare) '''

def șterge_elev(cnp,d):
    if cnp in d:
        del d[cnp]
#e
''' Folosind structura de date în care s-au memorat datele despre elevi la punctul a)
(nu citind din nou datele) construiți în memorie o lista de liste cu elevii din fișier,
 un element din lista fiind de forma [nume, prenume, lista de note]
 ordonată descrescător după medie și, în caz de egalitate, după nume
 și afișați elementele listei în fișierul „elevi.out”.'''

with open("elevi.out","w") as fout:
    lista_rez=sorted([D.values()], key = lambda x: -(sum(x[2])/len(x[2]),x[0]) )

    fout.writeLines(lista_rez)
