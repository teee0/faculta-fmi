L=[1,2,3,4,5,6,7,8]

def doarImpare(L):
    return [int(x) for x in L if x%2==1]

print(doarImpare(L))