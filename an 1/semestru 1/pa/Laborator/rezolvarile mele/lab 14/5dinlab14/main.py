with open("cuburi.in") as fin:
    n = int (fin.readline())
    L = [cub for cub in f.readlines()]

L_cuburi = []
for cub in L:
    latura, culoare = cub.strip().split()
    L_cuburi.append((int(latura), culoare))

L_cuburi.sort()


hMax = [0] * len(L_cuburi)
pred = [-1] * len(L_cuburi)
nrTurnuri = [0] * len(L_cuburi)

hMax[0] = L_cuburi[0][0]
nrTurnuri[0] = 1
for i in range(1, len(L_cuburi)):
    for j in range(0, i):
        if L_cuburi[i][1] != L_cuburi[j][1] \
            and L_cuburi[i][0] > L_cuburi[j][0] :
            if hMax[i] < hMax[j] + L_cuburi[i][0]:
                hMax[i] = hMax[j] + L_cuburi[i][0]
                pred[j] = j
                nrTurnuri[i] = nrTurnuri[j]
            elif hMax[i] == hMax[j] + L_cuburi[i][0]:
                nrTurnuri[i] +=nrTurnuri[j]

print(hMax, pred, nrTurnuri, sep="\n")

pozMax = hMax.index(max(hMax))
print(pozMax)

poz = pozMax
sol = []

while poz != -1:
    sol.append(L_cuburi[poz])
    poz = pred[poz]

print(sol)
print(nrTurnuri[pozMax])
