L=list(range(30))
print(L)
k = int(input("k = "))
for i in range(k):
    L.pop(0)
print(L)

k2 = int(input("k2 = "))
L[:k2]=[]
print(L)