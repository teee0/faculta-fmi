L=[chr(ord("a")+i) for i in range(7)]

L2 = [(L[i],L[i+1])for i in range(len(L)-1)]
print(L2)
