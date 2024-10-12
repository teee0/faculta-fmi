a=int(input("a="))
b=int(input("b="))

l1=0
l2=1
l3=1

while l3<a:
    l1,l2,l3=l2,l3,l2+l3#surpinzător merge

if l3<b:
    print(l3)
else:
    print("n'existe pas")