with open("numere.in") as fin:
    n = int(fin.readline())
    L = [int (x) for x in fin.readline().split()]
    suma = int(fin.readline())

d = {} #sumă plătibilă

for nr in L:
    for s in list(d.keys()):
        if nr + s not in d:
            d[nr+s]=nr
    if nr not in d and nr<= suma:
        d[nr]=nr

print(d)

with open("numere.out","w") as fout:
    if suma not in d:
        fout.write(f"Suma {suma} nu poate fi obtinuta din numerele")
    else:
        sol = []
        elem = suma
        while d[elem] != elem:
            sol.append(d[elem])
            elem = d[elem]
        fout.write(" ".join(str(x) for x in sol))
