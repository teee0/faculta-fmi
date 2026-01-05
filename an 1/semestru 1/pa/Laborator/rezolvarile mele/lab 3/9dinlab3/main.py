text=input().split()
rez=""
for cuv in text:
    if "A"<=cuv[0]<="Z":
        rez+=cuv[0]

print(rez)
