# OBSERVATIE
L = [1, 2, 3, 4, 5, 6]
# for x in L:
#     if x % 2 == 0:
#         x = -x  # NU se modifica lista
# print(L)

# for i in range(len(L)):
#     if L[i] %2 == 0:
#         L[i] = -L[i] # se modifica lista
# print(L)


## Laborator 6, JO 7 noi, ora 14-16

# L = [4,6,13,173,2,142, 189, 2222]

# L.sort()
# print(L)
#
# L2 = sorted(L, reverse = True)
# print(L2)

# ## Problema 1
#
# L = [4,6,13,173,2,142, 189, 2222]
#
# ## a)
# print(sorted(L, key = str))
#
# ## b)
# print(sorted(L, key = lambda x: str(x)[::-1]))
#
# ## c)
# print(sorted(L, key = lambda x: len(str(x)), reverse=True ))
# print(sorted(L, key = lambda x: -len(str(x)) ))
#
# ## d)
# print(sorted(L, key = lambda x: len(set(str(x))) ))
#
# ## e)
# print(sorted(L, key = lambda x: (len(str(x)), -x) ))


# d = {} ## dictionarul vid
# m = set() ## multimea vida


## Problema 3
f = open("pb2_elevi.in", "r")
D = {}
for linie in f:
    # cnp, nume, prenume, *note = linie.split() #note este lista de str-uri
    # print(cnp, nume, prenume, note, sep = '\n')
    # cnp, nume, prenume, note = linie.split(' ', 3) #note este str
    cnp, nume, prenume, note = linie.split(maxsplit=3)  # note este str

    cnp = int(cnp)
    L_note = [int(x) for x in note.split()]
    D[cnp] = [nume, prenume, L_note]

f.close()
# print(D)


## b)
"""
b) Scrieți o funcție care primește ca parametri un cnp și structura 
de date în care s-au memorat datele despre elevi la punctul a) și 
crește cu 1 prima notă a elevului cu cnp-ul primit ca parametru. 
Funcția returnează nota după modificare sau None dacă cnp-ul nu există.
 Apelați funcția pentru un cnp citit de la tastatură.
"""


def creste_nota(cnp, d):
    if cnp not in d:
        return None
    d[cnp][2][0] += 1
    return d[cnp][2][0]


# cnp = int(input("CNP: "))
# print(creste_nota(cnp,D))
# print(D)


## c)
"""
Scrieți o funcție care primește ca parametri un cnp, o listă de note 
și structura de date în care s-au memorat datele despre elevi la 
punctul a) și adaugă lista de note la notele elevului  cu cnp-ul
 primit ca parametru. Funcția returnează lista de note după 
 modificare sau None dacă cnp-ul nu există. Apelați funcția pentru 
 un cnp citit de la tastatură si lista l_note=[10,8].
"""


def adauga_note(cnp, L, d):
    if cnp in d.keys():
        # d[cnp][2]+=L
        # sau
        d[cnp][2].extend(L)
        return d[cnp][2]


# cnp = int(input("CNP: "))
# print(adauga_note(cnp,[10,8],D))
# print(D)


## d)
"""
Scrieți o funcție care primește ca parametri un cnp și structura
 de date în care s-au memorat datele despre elevi la punctul a)
  și șterge informațiile despre elevul cu acest cnp. Apelați 
  funcția pentru un cnp citit de la tastatură (dacă cnp-ul nu 
  este în listă funcția nu va modifica nimic și nu va da eroare) 
"""


def sterge_elev(cnp, d):
    if cnp in d:
        del d[cnp]


# cnp = int(input("CNP: "))
# print(sterge_elev(cnp, D))
# print(D)


## e)
"""
Folosind structura de date în care s-au memorat datele despre 
elevi la punctul a) (nu citind din nou datele) construiți în 
memorie o lista de liste cu elevii din fișier, un element din 
lista fiind de forma [nume, prenume, lista de note] ordonată 
descrescător după medie și, în caz de egalitate, după nume și
 afișați elementele listei în fișierul „elevi.out”.
 """

# Lrez = sorted(D.values(),
#               key=lambda L: (-sum(L[2])/len(L[2]), L[0]))
# print(Lrez)
#
# g=open("pb2_elevi.out", "w")
# for elev in Lrez:
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

# import random
# import string
#
#
# #print(random.choices(string.ascii_letters , k=3))
#
# def genereaza_coduri(d):
#     for cnp in d:
#         cod = ''.join(random.choices(string.ascii_letters , k=3)
#                       +
#                       random.choices('0123456789' , k=3))
#         d[cnp].append(cod)
#         #sau
#         #d[cnp] += [cod]
#         #sau
#         #d[cnp].extend([cod])
#
#
# genereaza_coduri(D)
# print(D)


## Problema 3

# f = open("pb3.in", "r")
# L_cuv = f.read().split()
# f.close()
# print(L_cuv)
#
# p = int(input("nr litere sufix = "))
# d = {}
# for cuv in L_cuv:
#     sufix = cuv[-p:]
#     if sufix not in d.keys():
#         d[sufix] = [cuv]
#     else:
#         d[sufix].append(cuv)
# print(d)
#
# L_rez = sorted(d.values(), key = lambda L_cuv : -len(L_cuv))
# print(L_rez)
#
# g = open("pb3_rime.txt", "w")
# for L_cuv in L_rez:
#     g.write(" ".join(sorted(L_cuv, reverse = True)) + '\n')
# g.close()

## Problema 4
f = open("pb4.in", "r")
L_cuv = f.read().split()
f.close()
print(L_cuv)

d = {}
for cuv in L_cuv:
    litere = frozenset(cuv)
    if litere not in d.keys():
        d[litere] = [cuv]
    else:
        d[litere].append(cuv)
print(d)

L_rez = [sorted(L_cuv, reverse = True)
    for litere, L_cuv in sorted(d.items(),
                                     key = lambda t : -len(t[0]))
         if len(L_cuv) >= 2]
print(*L_rez, sep = '\n')

