fin=open("test.in")
fout=open("test.out","w")

nota = 1

for linie in fin:
    aux, rez = linie.split("=")
    a, b = aux.split("*")
    a, b, rez= int(a), int(b), int(rez)

    fout.write(f"{linie.strip()} ")
    if a*b==rez:
        nota+=1
        fout.write("corect\n")
    else:
        fout.write(f"gresit {a*b} \n")