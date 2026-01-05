a,b,c=input("Introduceți 3 numere: ").split()
a=int(a)
b=int(b)
c=int(c)
if 0<=a<24  and 0<=b<60 and 0<=c<60 :
    print(f"{a:02}:{b:02}:{c:02}")
else:
    print("Nu-i bun.")