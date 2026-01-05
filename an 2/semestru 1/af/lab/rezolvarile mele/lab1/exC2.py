from exA2 import lista_graf

def dfs_aux(la, vizitate, rez, n, pred=-1):
    vizitate[n] = True
    for x in la[n]:
        if not vizitate[x-1]:
            dfs_aux(la, vizitate, rez, x-1, n)
        elif x-1 != pred:
            rez.add( tuple(sorted((n+1,x))) )

def dfs(_mod="neorientat", _fisier="exc2.in"):

    la = lista_graf(mod = _mod, fisier=_fisier)
    vizitate = [False for _ in range(len(la))]
    rez=set()
    for i in range(len(la)):
        if not vizitate[i]:
            dfs_aux(la, vizitate, rez, i)
    
    print(rez)
        
dfs()