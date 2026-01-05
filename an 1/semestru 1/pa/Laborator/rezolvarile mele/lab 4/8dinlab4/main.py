L=[2,4,1,7,5,1,8,10]
L2=[L[i] for i in range(len(L)) if L[i]%2==i%2]
print(L2)

L2=[nr for poz,nr in enumerate(L) if poz%2==nr%2]
print(L2)