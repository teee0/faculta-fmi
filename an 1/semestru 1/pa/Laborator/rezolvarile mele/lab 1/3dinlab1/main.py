z=int(input("ziua="))
l=int(input("luna="))
a=int(input("an="))

if l in [1,3,5,7,8,10,12]:
#     luna cu 31 de zile
    if z != 31:
        z+=1
    else:
        if l != 12:
            z=1
            l+=1
        else:
            z=1
            l=1
            a+=1
elif l in [4,6,9,11]:
#    luna de 30
    if z != 30:
        z+=1
    else:
       z=1
       l+=1
elif l == 2:
    #feb
    if a%4 == 0 and a%400 != 0 and a%100 == 0:
#   an bisect
        if z != 28:
            z+=1
        else:
            z=1
            l=3
    else:
        if z != 29:
            z+=1
        else:
            z=1
            l=3

print(f"{z:02d}.{l:02d}.{a:04d}")