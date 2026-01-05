from math import log2

a,b=input().split()
a,b=int(a),int(b)

putere=log2(a)
if putere!=int(putere):
    putere+=1
putere=int(putere)

# x e cea mai mică putere din interval
x = 2 << putere-1
while x <= b:
    print(x,end=" ")
    x<<=1