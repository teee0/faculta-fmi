#a)
def divizori_intern(n):
    l_divizori = []
    for d in range(2, n+1, 1):
        if n%d!=0: continue
        while n%d==0: n//=d
        l_divizori.append(d)

    return l_divizori

def divizori(*numere):
    rez = {}
    for n in numere:
        rez[n]=divizori_intern(n)
    return rez

#print(divizori(2,50,21,90))

# b)

litere_10 = [chr(c+ord('a')) for c in range(10)]
#print(litere_10)

# c)
