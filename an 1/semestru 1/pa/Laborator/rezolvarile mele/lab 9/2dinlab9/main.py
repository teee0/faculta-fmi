def citire():
    with open("spectacole.txt") as fin:
        L = []
        for linie in fin:
            ore, nume=linie.strip().split(maxsplit=1)
            inceput, sfarsit=ore.split('-')
            L.append((inceput,sfarsit,nume))
    return L

def greedy(L):
    L.sort(key=lambda t: t[1])
    G=[L[0]]
    for poz in range(1, len(L)):
        if L[poz][0] > G[-1][1]:
            G.append(L[poz])
    return G

def afișare(L):
    with open("programare","+w") as f:
        for inceput,sfarsit,nume in G:
            f.write(f"{inceput}-{sfarsit} {nume}\n")
L=citire()
print(L)

G=greedy(L)
afișare(G)