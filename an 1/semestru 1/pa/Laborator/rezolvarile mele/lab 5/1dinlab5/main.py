# fin=open("text.in")
# fout=open("text.out")

#v2
# while True:
#     linie = fin.readline()
#     if linie == "":
#         fin.close()
#         fout.close()
#         break
#     fout.write(linie)

#v3
with open("text.in") as fin:
    L_lini=fin.readlines()
with open("text.out","w+") as fout:
    fout.write("\n".join(L_lini))
