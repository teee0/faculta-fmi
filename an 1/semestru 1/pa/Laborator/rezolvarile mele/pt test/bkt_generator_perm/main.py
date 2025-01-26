def bkt(k):
    global n, s
    for v in range(1,n+1):
        s[k]=v
        if v not in s[:k]: #s[:k] nu s !! pt ca suprascrii vectoru nu stergi si elementu
            if k==n:
                print(s[1:])
                return s#nu mere
            else:
                return bkt(k+1)

n = int(input("n = "))
s = [0] * (n+1)

print(bkt(1))
