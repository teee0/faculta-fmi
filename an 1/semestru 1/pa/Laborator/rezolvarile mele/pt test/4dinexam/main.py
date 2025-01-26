def bkt(k):
    global n, s
    for val in range(1, n+1):
        s[k] = val
        if s[k] not in s[:k]:
            if k == n:
                if s[3]==3:
                    print(s[1:])
            else:
                bkt(k+1)

n = int(input("Da o valoare pentru un examen luat: "))
s=[0]*(n+1)
bkt(1)
