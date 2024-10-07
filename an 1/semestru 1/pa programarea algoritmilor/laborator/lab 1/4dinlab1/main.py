[x,op,y]=input().split()
x,y=int(x),int(y)
if op == '+':
    r=x+y
elif op == '-':
    r=x-y
elif op == '*':
    r=x*y
else:
    raise ValueError("Operator invlid")

print(f"{x} {op} {y} = {r}")