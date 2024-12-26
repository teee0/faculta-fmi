a=int(input("a="))
b=int(input("b="))

for i in range(0,100,5):
    if i<a or i>b:
        print(i,end=" ")