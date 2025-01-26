cinemauri={}
#cinemauri = {cinema={film=lista_ore}}
with open("cinema.in") as fin:
    for linie in fin:
        cinema, film, ore=linie.strip().split(" % ")
        ore=ore.split()
        if cinema not in cinemauri:
            cinemauri[cinema]={}
        cinemauri[cinema][film]=ore

def șterge_ore(cinemauri, cinema, film, ore_de_sters):
    for ora in ore_de_sters:
        cinemauri[cinema][film].remove(ora)
'''
b_cinema=input()
b_nume=input()
b_ora=input()
șterge_ore(cinemauri, b_cinema, b_nume, [b_ora])'''
șterge_ore(cinemauri, "Cinema 2","Gasca Animalutelor", ["15:00","20:00"])

print(cinemauri)


def cinema_film(cinemauri,c_uri,ora_minima,ora_maxim):
    # se pot compara orele neformatate
    # deoarece ":" nu schima ordinea lexicografica
    for c in c_uri:
        cinemauri[c]=0
