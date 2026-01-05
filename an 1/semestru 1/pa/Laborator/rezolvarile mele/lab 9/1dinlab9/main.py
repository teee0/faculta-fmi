def citire():
    L=[]
    with open("tis.txt") as fin:
        L.append([int(x) for x in fin.readline()])
    return L

def greedy(L):
    L_sortat=sorted(L, key=lambda t: t[1])
    G_soluție=[]
    s_timp_serivire=0
    s_timp_așteptare=0

    for poz, timp_serivire in L_sortat:
        s_timp_serivire += timp_serivire
        s_timp_așteptare += s_timp_serivire
        G_soluție.append((poz,timp_serivire,s_timp_serivire))
    timp_mediu_așteptare = s_timp_așteptare / len(L_sortat)
    return G_soluție, timp_mediu_așteptare

def afiș(G_soluție,timp_mediu_așteptare):
    print(f"{"Nr. persoană".ljust(11)}"
          f"\t{"T_Serivire".center(9)}"
          f"\tcevaidkvezitu"
          )
    for poz, timp_serivire in G_soluție:
        print()

L=citire()
print(L)