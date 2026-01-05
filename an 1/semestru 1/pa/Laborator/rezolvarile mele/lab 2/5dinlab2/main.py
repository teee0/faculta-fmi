n=int(input())
șir=""
for i in range(1, n+1):
    șir+=('' if i==1 else ' ')+str(i)
    print(șir)