''''
cuvinte = {}
#varianta in  care cheia e cuvantu;
#printu nu e exact cum trebuie
with open("exemplu.txt") as fin:
    for linie in fin:
        for cuv in linie.lower().split():
            cuvinte[cuv] = cuvinte[cuv]+1 if cuv in cuvinte else 1

maxf = max(cuvinte.values())
for f in range(1,maxf+1):
    if f in cuvinte.values():
        print(f"Frecvența {f}: ",end="")
        for cuv in cuvinte:
            if cuvinte[cuv] == f:
                print(cuv, end=", ")
        print("\n")
'''
#varianta in care cheia e frecvența
cuvinte = []
with open("exemplu.txt") as fin:
    for linie in fin:
        cuvinte.extend([cuv for cuv in linie.lower().split()])

frecvențe = {1:[]}

for cuv in cuvinte:
    for f in frecvențe:
        if cuv in frecvențe[f]:
            aux = f
            frecvențe[f].remove(cuv)
            if f+1 not in frecvențe:
                frecvențe[f+1]=[]
            frecvențe[f+1].append(cuv)

            break
    else:
        frecvențe[1].append(cuv)

for f in frecvențe:
    print(f"Frecventa {f}:",*frecvențe[f])
