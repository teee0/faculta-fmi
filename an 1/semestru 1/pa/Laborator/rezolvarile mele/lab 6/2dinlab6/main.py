import string
from random import choices

agendă={}

# A)
with open("elevi.in") as fin:
    for linie in fin:
        #cnp,nume,prenume,*note=linie.split() #note e listă de str-uri
        cnp,nume,prenume,note=linie.split(" ",3) #note e str
        cnp=int(cnp)
        L_note=[int(x) for x in note.split()]
        agendă[cnp]=[nume, prenume, L_note]
print(agendă)

# b)

# c)
def adaugă_note(cnp,L_note, agendă):
    if cnp in agendă:
        agendă[cnp][2].extend(L_note)
        return agendă[cnp][2]
# cnp=int(input("cnp: "))
# print(adaugă_note(cnp,[int(x) for x in input().split()],agendă))

# d)
def șterge_elev(cnp,agendă):
    if cnp in agendă:
        del agendă[cnp]

# cnp=int(input("cnp: "))
# șterge_elev(cnp,agendă)

#e)
L_rez = sorted(agendă.values(),
               key=lambda L:(-sum(L[2])/len(L[2]), L[0]))
with open("elevi.out","w") as fout:
    for elev in L_rez:
        fout.write(str(elev)+"\n")

# f)
def generează_coduri(agendă):
    for cnp in agendă:
        cod = ''.join(choices(string.ascii_letters, k=3)
                      + choices("0123456789", k=3) )
        agendă[cnp].append(cod)

generează_coduri(agendă)
print(agendă)