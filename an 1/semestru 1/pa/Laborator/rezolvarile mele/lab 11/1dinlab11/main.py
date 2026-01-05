def munte(L, st, dr):
    if dr-st+1<3:
        return False
    mij=(st+dr)//2
    if L[mij-1]<L[mij]>L[mij]:
        return L[mij], mij
    if L[mij-1]>L[mij]:
        return munte(L, st, mij)
    return munte(L, mij, dr)

with open("date.in") as fin:
    n = int(fin.readline()) # pe prima linie din fișier e n
    L = [int(x) for x in fin.readline().split()]
    print(munte(L,0, len(L)-1))
#nu merge