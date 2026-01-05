# a)
def citire():
    with open ("cinema.in") as fin:
        D_date = {}
        for linie in fin:
            cinema, film, ore = linie.split(" % ")
            L_ore = ore.strip().split()
            if cinema not in D_date:
                D_date[cinema] = {}
            D_date[cinema][film] = L_ore
    return D_date

D_date = citire()
print(D_date)

# b)
def sterge_ore(D_date, cinema, film, multime_ore):
    if cinema in D_date and film in D_date[cinema]:
        for i in range(len(D_date[cinema][film])-1, -1, -1):
            if D_date[cinema][film][i] in multime_ore:
                D_date[cinema][film].pop(i)
        if len(D_date[cinema][film]) == 0:
            del D_date[cinema][film]
    return D_date[cinema].keys()

print(sterge_ore(D_date,"Cinema 1","Buna dimineata", {"09:30"}))

#c)
def cinema_film(D_date,ora_minima,ora_maxima,*cinemauri):
    rez_total = []
    for cinema in cinemauri:
        rez_ore = []
        for film in D_date[cinema]:
            for ora in D_date[cinema][film]:
                if ora_minima <= ora <=ora_maxima:
                    rez_ore.append(ora)
            if len(rez_ore) > 0:
                rez_total.append((film,cinema,rez_ore))
            rez_total.sort(key=lambda t: (t[0], -len(t[2]))
            return rez_ore #vezi print

