def nrApariții(L, x):
    def primaApariție(L,x,st,dr):
        if L[0] == x:
            return 0
        if st == dr:
            return -1
        mij = (st + dr) // 2
        if L[mij] == x and L[mij - 1] !=x:
            return mij
        if x <= L[mij]:
            return primaApariție(L,x,st,mij-1)
        return primaApariție(L,x,mij+1,dr)

    def ultimaApariție(L, x,st,dr):
        if L[-1] == x:
            return len(L)-1
        if st == dr:
            return -1
        mij = (st+dr)//2
        if L[mij] == x and L[mij+1] != x:
            return mij
        if x< L[mij]:
            return ultimaApariție(L,x,st,mij-1)
        return ultimaApariție(L,x,mij+1,dr)

    s = primaApariție(L,x,0,len(L-1))
    f = ultimaApariție(L,x,0,len(L)-1)
    print(s,f)
    if s== -1 or f==-1:
        return 0
    return f-s+1
#neverificat