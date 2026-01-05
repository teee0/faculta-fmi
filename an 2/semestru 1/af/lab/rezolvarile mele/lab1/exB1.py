from exA2 import lista_graf
from collections import deque


def distanta_din_n(n=-1):
    with open("bfs.in") as fin:
        nr_n, _, nod_initial = map (int, fin.readline().split() )
    if n != -1:
        nod_initial = n
    la = lista_graf("orientat", fisier="bfs.in") 

    distante = [-1 for i in range(nr_n)]
    distante[nod_initial-1] = 0

    queue = deque()
    queue.append(nod_initial)

    while(len(queue) != 0):       #cât timp coada nu e goală
        nod_curent = queue.popleft()
        
        for x in la[nod_curent-1]:    #adaugă în coadă vecinii nevizitați
            if distante[x-1] == -1:
                queue.append(x)
                distante[x-1] = distante[nod_curent-1] + 1
    return distante


s = int(input("s = "))
x = int(input("x = "))
print(distanta_din_n(s)[x-1])
    