L=[float(x) for x in input("L: ").split()]

i = 0
k = 0
while i < len(L)+k:
    if L[i]<0:
        L.insert(i,0)
        k+=1
    i+=1

print(L)
