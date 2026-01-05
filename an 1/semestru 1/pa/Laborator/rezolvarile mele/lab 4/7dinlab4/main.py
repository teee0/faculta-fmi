L=[2,7,3,6,3,77,7,5]

def doarPozImpare(L):
    return [L[i] for i in range(len(L)) if i%2==1]
print(doarPozImpare(L))