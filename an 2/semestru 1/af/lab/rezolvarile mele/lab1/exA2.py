
def lista_graf(mod="neorientat", fisier="graf.in"):
    with open(fisier) as fin:
        #citire nr de noduri (ignora restu liniei)
        n = int(fin.readline().split()[0])

        #construire lista de liste cu goale
        la = [ [] for _ in range(n)]

        #construire listă propriu-zis

        for line in fin:
            x,y = [int(x) for x in line.split()]
            la[x-1].append(y)
            if mod!="orientat":
               la[y-1].append(x)
    return la

def afisare_lista(l):
    for i in range(len(l)):
        print(f"{i+1}:",l[i])

'''
la = lista_graf("orientat")

afisare_lista(la)
'''