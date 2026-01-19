import numpy as np
import matplotlib.pyplot as plt
import scipy.stats as st

EX = 3

def zar():
    return np.ceil (np.random.uniform(0,6))

if EX == 1:
    NR_ZARURI = 3
    if NR_ZARURI == 2:
        cazuri = [(7,2),(8,2),(8,1),(14,2)]
        for S, V in cazuri:
            count_suma, count_z1 = 0,0
            for _ in range(100000):
                z1 = zar()
                z2 = zar()
                if z1+z2 == S:
                    count_suma +=1
                    if z1 == V:
                        count_z1 +=1
            prob = 0 if count_suma == 0 else count_z1 / count_suma
            print (f"Pentru suma={S} și primul zar={V} probabilitatea e {prob*100:.2f}%")
    elif NR_ZARURI == 3:
        S = 15
        V = 3
        count_suma, count_z1 = 0,0
        for _ in range (100000):
            zaruri = [zar(),zar(),zar()]
            if sum(zaruri) == S:
                count_suma +=1
                if zaruri[0] == V:
                    count_z1 +=1
        prob = 0 if count_suma == 0 else count_z1 / count_suma
        print (f"Pentru suma={S} și primul zar={V} probabilitatea e {prob*100:.2f}%")

elif EX == 2:
    N = 1000000
    a,b,c,ac,bc,abc=0,0,0,0,0,0
    for _ in range(N):
        zaruri = [zar(),zar()]
        A = zaruri[0] == 1
        B = zaruri[1] == 6
        C = sum(zaruri) == 7

        a +=  A
        b +=  B
        c +=  C
        ac += A and C
        bc += B and C
        abc +=A and B and C

    def p(x):
        return x/N 
    def ind(x, y, xy):
        return (p(xy)-(p(x)*p(y))) < 0.001 #cam hardcodat
    print ("a și c", ind(a, c, ac))
    print ("b și c", ind(b, c, bc))
    print ("a și b și c", ind(a*p(b), c,abc))
        
elif EX == 3:
    p = 0.09 
    nr_zile = 30
    N = 100000
    SUBPUNCTU = 3

    if SUBPUNCTU != 3:
        def intalnire():
            return np.random.rand()<=p
        
        v_italniri = np.zeros(nr_zile+1)

        for _ in range(N):
            nr_intalniri = 0
            for _ in range (nr_zile): # într-o lună în cazu ăsta
                nr_intalniri += intalnire()
            
            v_italniri [nr_intalniri] += 1

        print (f"E mai probabil sa ma intalnesc de {0 if v_italniri[0]>v_italniri[5] else 5} ori")
        v_italniri/=N
        fig, ax = plt.subplots()
        ax.bar(range(nr_zile+1),v_italniri)
    else:
        v = np.zeros(nr_zile+1)
        Intalniri = st.binom(nr_zile, p)
        for i in range(0,nr_zile+1):
            v[i] = Intalniri.pmf(i)
        plt.bar(range(31), v)
    plt.show()

    