with open("matrice.in") as fin:
    matrice = [[int(x) for x in linie.split()] for linie in fin]

nr_linii = len(matrice)
nr_coloane = len(matrice[0])

transpusa = [[matrice[i][j] for i in range(nr_linii)]for j in range(nr_coloane)]
print(*transpusa,sep="\n")