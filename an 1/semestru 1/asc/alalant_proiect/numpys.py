import numpy as np

def make_mat(n, m):
    return np.random.randint(0, 10, (n, m))

print(np.size(make_mat(3, 4)))


#shape(mat) dimensiune
#size(mat) nr de elemente
