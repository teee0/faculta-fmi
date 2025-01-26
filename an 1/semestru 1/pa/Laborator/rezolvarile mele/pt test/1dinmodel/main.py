with open("matrice.in") as fin:
    with open("matrice.out","w") as fout:
        for linie in fin:
            max1=0
            max2=0
            s_linie=[int(x) for x in linie.split()]
            for x in s_linie:
                max2=max(max2,x)
                if max2 > max1:
                     max1,max2=max2,max1

            s_linie.remove(max1)
            s_linie.remove(max2)

            for x in s_linie:
                fout.write(f"{x} ")
            fout.write("\n")
