L=[1,2,4,1,0,7,4,2,5,0,0,2,4,0,0,2,0]

if L.count(0)>=2:
    primapoz=L.index(0)
    L[ primapoz:L.index(0, primapoz+1)+1 ] = []

print(L)