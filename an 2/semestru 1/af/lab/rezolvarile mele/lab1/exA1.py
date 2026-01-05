def matrice_graf(mod="neorientat", fisier= "graf.in"):
    with open(fisier) as fin:
        #citire nr de noduri (ignora restu liniei)
        n = int(fin.readline().split()[0])

        #construire matrice cu 0-uri
        ma = [ [0 for i in range(n)] for i in range(n)]

        #construire matrice propriu-zis

        for line in fin:
            x,y = [int(x)-1 for x in line.split()]
            if mod == "orientat":
                ma[x][y] = 1
            else:
                ma[x][y] = ma[y][x] = 1
    return ma

def afisare_matrice(mat):
    for line in mat:
        print(*line)

'''
ma = matrice_graf("orientat")

afisare_matrice(ma)
'''