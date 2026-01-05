with open("rime.in") as fin:
    L_cuvinte = fin.read().split()

p = int(input("p = "))
rime = {}

for cuv in L_cuvinte:
    if cuv[-p:] not in rime:
        rime[cuv[-p:]] = [cuv]
    else:
        rime[cuv[-p:]].append(cuv)

L_rezultat= sorted(rime.values(),key=lambda L:-len(-L))
with open("rime.txt","w") as fout:
    fout.write(" ".join(L_rezultat))# nu e gata