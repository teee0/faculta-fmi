## Laborator 6, JO 7 noi, ora 10-12

# L = [4,6,13,17,2,14]

# L.sort()
# print(L)
#
# L2 = sorted(L, reverse=True)
# print(L2)

# ## Problema 1
#
# L = [4,6,13,17,2,14]
#
# ## a)
# print(sorted(L, key=str))
#
# ## b)
# print(sorted(L, key=lambda x: str(x)[::-1]))
#
# ## c)
# print(sorted(L, key = lambda x: len(str(x)), reverse=True))
# print(sorted(L, key = lambda x: -len(str(x))))
#
# ## d)
# L = [4,6,13,173,2,142, 189, 2222]
# print(sorted(L, key=lambda x: len(set(str(x)))))
#
# ## e)
# print(sorted(L, key=lambda x: (len(str(x)), -x) ))

d = {} ## dictionarul vid
m = set() ## multimea vida

## Problema 2
## a)
f= open("pb2_elevi.in", "r")
d= {}

for linie in f:
    # cnp,nume,prenume,*note = linie.split() #note e lista de str-uri
    # cnp,nume,prenume,note = linie.split(" ", 3) #note e str
    cnp, nume, prenume,note = linie.split(maxsplit=3) #note e str
    cnp=int(cnp)
    L_note = [int(i) for i in note.split()]
    d[cnp]=[nume,prenume,L_note]

f.close()
# print(d)

## b)
"""
b) Scrieți o funcție care primește ca parametri un cnp și structura 
de date în care s-au memorat datele despre elevi la punctul a) și 
crește cu 1 prima notă a elevului cu cnp-ul primit ca parametru. 
Funcția returnează nota după modificare sau None dacă cnp-ul nu există.
 Apelați funcția pentru un cnp citit de la tastatură.
"""
def creste_note(cnp, d):
    if cnp not in d:
        return None
    d[cnp][2][0]+=1
    return d[cnp][2][0]

# cnp1=int(input("cnp= "))
# print(creste_note(cnp1,d))
# print(d)

## c)
"""
Scrieți o funcție care primește ca parametri un cnp, o listă de note 
și structura de date în care s-au memorat datele despre elevi la 
punctul a) și adaugă lista de note la notele elevului  cu cnp-ul
 primit ca parametru. Funcția returnează lista de note după 
 modificare sau None dacă cnp-ul nu există. Apelați funcția pentru 
 un cnp citit de la tastatură si lista l_note=[10,8].
"""
def adauga_note(cnp, L_note, d):
    if cnp in d:
        # d[cnp][2] += L_note
        # sau
        d[cnp][2].extend(L_note)
        return d[cnp][2]


# cnp = int(input("CNP = "))
# print(adauga_note(cnp, [10, 8], d))
# print(d)

## d)
"""
Scrieți o funcție care primește ca parametri un cnp și structura
 de date în care s-au memorat datele despre elevi la punctul a)
  și șterge informațiile despre elevul cu acest cnp. Apelați 
  funcția pentru un cnp citit de la tastatură (dacă cnp-ul nu 
  este în listă funcția nu va modifica nimic și nu va da eroare) 
"""
def sterge_elev(cnp,d):
    if cnp in d:
        del d[cnp]

# cnp = int(input("CNP = "))
# print(sterge_elev(cnp, d))
# print(d)


## e)
"""
Folosind structura de date în care s-au memorat datele despre 
elevi la punctul a) (nu citind din nou datele) construiți în 
memorie o lista de liste cu elevii din fișier, un element din 
lista fiind de forma [nume, prenume, lista de note] ordonată 
descrescător după medie și, în caz de egalitate, după nume și
 afișați elementele listei în fișierul „elevi.out”.
 """

# L_rez=sorted(d.values(),
#              key=lambda x: (-sum(x[2])/len(x[2]), x[0]))
# # print(L_rez)
#
# g=open("pb2_elevi.out","w")
# for elev in L_rez :
#     g.write(str(elev)+"\n")
# g.close()


## f)
"""
Scrieți o funcție care primește ca parametru structura de
 date în care s-au memorat datele despre elevi la punctul a) 
 și adaugă la informațiile asociate unui student un
  cod de lungime 6 generat aleator care conține 3 litere urmate
   de 3 cifre. Exemplu de apel: 
genereaza_coduri(d) 
print(d)
"""
import random
import string

# print(random.choices(string.ascii_letters , k=3))

def genereaza_coduri(d):
    for cnp in d:
        cod = "".join(random.choices(string.ascii_letters, k = 3)
                      + random.choices("0123456789", k=3))
        d[cnp].append(cod)

# genereaza_coduri(d)
# print(d)


# ## Problema 3
#
# f = open("pb3.in")
# L_cuvinte = f.read().split()
# print(L_cuvinte)
# f.close()
#
# p = int(input("p = "))
# d = {}
# for cuv in L_cuvinte:
#     if cuv[-p:] not in d:
#         d[cuv[-p:]] = [cuv]
#     else:
#         d[cuv[-p:]].append(cuv)
#         #sau
#         # d[cuv[-p:]] += [cuv]
# print(d)
#
# L_rez = sorted(d.values(), key = lambda L_cuv: -len(L_cuv))
#
# g = open("pb3_rime.txt","w")
# for L_cuv in L_rez:
#     g.write(" ".join(sorted(L_cuv, reverse = True)) + "\n")
# g.close()

