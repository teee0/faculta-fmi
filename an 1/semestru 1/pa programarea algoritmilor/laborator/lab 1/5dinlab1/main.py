i1,i2,f1,f2,c1,c2=input().split()

for x in [i1,i2]:
    x=int(x)
for x in [f1,f2]:
    x=float(x)

print(f"{i1} {i2} {f1} {f2} {c1} {c2}")
print(f"{i1} {f1} {c1} {i2} {f2} {c2}")
print(f"{i1}\n{i2}\n{f1}\n{f2}\n{c1}\n{c2}")
print(f"{i1} {i2}\n{f1} {f2}\n{c1} {c2}")