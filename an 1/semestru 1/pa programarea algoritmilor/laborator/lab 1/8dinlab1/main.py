[a,b,c]= [int(x) for x in input().split()]

minim=a
maxim=a
for x in [b,c]:
    minim=min(minim,x)
    maxim=max(maxim,x)



print(maxim-minim)