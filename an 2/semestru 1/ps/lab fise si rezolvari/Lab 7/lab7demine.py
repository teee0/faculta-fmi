import math
from math import factorial

import numpy as np
import matplotlib.pyplot as plt

def prob(k):
    return lam**k / factorial(k) * np.exp(-lam)

p=1/180
lam = 20
n=3600
N=1000
timpuri=[]
fig,ax = plt.subplots()
for _ in range(N):
    s = np.random.random()
    k = 0
    capat_interval = prob(s)
    while s > capat_interval:
        k+=1
        capat_interval += prob(k)
    timpuri.append(k)

ax.hist(timpuri,bins=100,rwidth=0.9,density=True)
plt.show()