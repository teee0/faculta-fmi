n=int(input())

max1,max2=None,None

for _ in range(n):
    x=int(input())
    if max1 is None or x>max1:
        max2=max1
        max1=x
    elif x!=max1 and (max2 is None or x>max2):
        max2=x


print(max1, max2)