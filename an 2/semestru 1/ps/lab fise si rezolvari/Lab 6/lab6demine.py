import numpy as np
import matplotlib.pyplot as plt
import scipy as sp

EX = 2

if EX == 1:
    N = 1000000
    p=0.09
    def intalnire():
        return np.random.random()<=p
    data = np.ones(N, dtype = int)
    for i in range(N):
        while not intalnire(): data[i]+=1

    print(f"P(X=7)={np.count_nonzero(data==7)}")

    fig, ax = plt.subplots()
    ax.hist(data, bins=range(0,data.max()),density=True)


elif EX==2:
    N=10000
    l = 20
    k = 30
    n = 3600
    p = l/n
    def mesaj():
        return np.random.random()<p
    data = np.zeros(N,dtype=int)
    for i in range(N):
        for s in range(n):
            data[i] += mesaj()

    print("Probabilitatea de a primi 30 de msj într-o oră:",
          np.count_nonzero(data==30)/N)

    fig, ax = plt.subplots()
    ax.hist(data, bins = range(0,data.max()),density=True, rwidth=0.9)
    print(f"În medie se primesc {np.mean(data)} mesaje")

    def peste(t):
        return np.exp(-l) * l**t / sp.special.factorial(t) 
    
    capete = np.zeros(n)
    capete[0] = peste(0)
    x=0
    for i in range(1,30):
        capete[i] = capete[i-1] +peste(i)
    print(type(capete[2]))

plt.show()