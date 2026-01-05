fin=open("matrice.in")
m,n=[int(x) for x in fin.readline().split()]

matrice = [[int(x) for x in linie.split()] for linie in fin]

print(matrice)
fin.close()

k=int(input("k = "))
#v1
# matrice[k+1:k+1]=[[0]*n]

#v2
matrice.insert(k+1,[0]*n)
with open("matrice.out","w") as fout:
    fout.writelines([" ".join([str(x) for x in linie])+"\n" for linie in matrice])
print(*matrice,sep="\n")