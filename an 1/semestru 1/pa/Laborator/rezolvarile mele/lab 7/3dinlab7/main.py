def cauta(cuv,nume_iesire,*nume_intrare):
    fout = open(nume_iesire,"w")
    for nume in nume_intrare:
        with open(nume) as fin:
            L = []
            for i, linie in enumerate(fin):
                L_cuv = [c.strip("!.?;:") for c in linie.lower().replace('-',' ').split()]
                if cuv in L_cuv:
                    L.append(i+1)
        fout.write(f"{nume} {'cuvantul nu a fost gasit' if len(L)==0 else ' '.join([str(x) for x in L]) }\n")
        
        
cauta("albastra","rez.txt","paunescu.txt","eminescu.txt")