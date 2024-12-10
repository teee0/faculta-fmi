șir = input().strip().split(" ")#arg. specificat la split
                        # ca să se poată reconstrui identic

ultim_tk_negol=""
rez=""
l, maxlen = 0, 0
for tk in șir:
    if tk != "":
        if tk != șir[0] and tk[0]!=ultim_tk_negol[-1]:
            rez+=f" {l}"
            rez+=("\n")
            maxlen=max(maxlen,l)
            l=1
        else:
            l+=1
        ultim_tk_negol = tk
    rez+=(tk + " ")
else:
    rez += f" {l}"
    rez += ("\n")
    maxlen = max(maxlen, l)
#afișare
if len(șir)==rez.count("\n")+1:
    print(-1)
else:
    print(rez)