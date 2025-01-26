l=[1,8,3,1,2,3]

def suma(s,d):
    if s==d: return l[s]
    m = (s+d)//2
    return suma(s,m)+suma(m+1,d)

def suma_mare():
    return suma(0,len(l)-1)

print (suma_mare())
