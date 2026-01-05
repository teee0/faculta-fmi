from exA2 import lista_graf

def dfs(la, vizitate, n):
    vizitate.add(n)
    for x in la[n-1]:
        if x not in vizitate:
            dfs(la, vizitate, x)


def nr_componente_conexe(_mod="neorientat", _fisier="dfs.in"):
    # se itereaza printr-un vector 
    # se face dfs pt fiecare nod nevizitat
    #   se marcheaza toate nodurile din parcurgere ca vizitate

    # daca in momentul iterarii asupra unui nod acesta este nevizitat
    # inseamna ca nodul nu face parte din aceeasi componenta conexa
    #   cu oricare dintre nodurile precedente.
    # deci se pot numara nodurile nevizitate in momentul iterarii 

    nr = 0
    la = lista_graf(mod = _mod, fisier=_fisier)
    vizitate = set()
    for i in range(len(la)):
        if i+1 not in vizitate:
            nr += 1
            dfs(la, vizitate, i+1)
    
    return nr
        

print(nr_componente_conexe())