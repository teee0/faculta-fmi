from exA1 import *
from exA2 import *
def lista_la_matrice(la):
    n = len(la)
    ma = [ [0 for i in range(n)] for i in range(n)]

    for i in range(n):
        for x in la[i]:
            ma[i][x-1] = ma[x-1][i] = 1
    return ma

def matrice_la_lista(ma):
    n = len(ma)
    la = [ [] for i in range(n)]

    for line in range(n):
        la[line] = [i+1 for i in range(n) if ma[line][i]]
    return la

afisare_lista(matrice_la_lista(matrice_graf()))
afisare_matrice(lista_la_matrice(lista_graf()))

