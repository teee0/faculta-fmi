from exA1 import afisare_matrice
def chestie_multigraf(mod="neorientat"):
    #cam același cod din exA1
    #singura diferență este că matricea este una de inturi
    #ma[x][y] reprezinta nr de muchii/arce dintre x si y
    #si singurile shimbari sunt:
        # ma[x][y] = z (unde z e implicit 1)

    with open("multigraf.in") as fin:
        #citire nr de noduri (ignora restu liniei)
        n = int(fin.readline().split()[0])

        #construire matrice cu 0-uri
        ma = [ [0 for i in range(n)] for i in range(n)]

        #construire matrice propriu-zis

        for line in fin:
            x,y,*z = [int(el) for el in line.split()]
            z = 1 if z==[] else z[0]

            if mod == "orientat":
                ma[x-1][y-1] == z
            else:
                ma[x-1][y-1] = ma[y-1][x-1] = z
    return ma

ma = chestie_multigraf()
afisare_matrice(ma)
