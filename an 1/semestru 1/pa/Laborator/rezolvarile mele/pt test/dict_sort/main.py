d={1:"sd",3:"fd",2:"gf"}
a=dict(sorted(d.items(),key=lambda x:x[0]))#dupa chei
a=dict(sorted(d.items(),key=lambda x:x[1]))#dupa valori
print(a)
