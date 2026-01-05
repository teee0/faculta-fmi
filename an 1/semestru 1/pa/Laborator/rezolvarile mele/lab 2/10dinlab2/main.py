n=int(input("n="))
a=b=None

for _ in range(n):
    x=int(input())
    y=int(input())
    if a is None:
        a,b=x,y
    else:
        a=max(a,x)
        b=min(b,y)

    if a>=b:
        print("c'est n'est pas possible")
        break
else:
    print(f"[{a}, {b}]")
