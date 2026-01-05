import numpy as np
import matplotlib.pyplot as plt

ex = 1

def gen_test(sunt_bolnav : bool):
    test_sensibil = np.random.random() < 98/100
    test_specific = np.random.random() < 99/100

    test_pozitiv = (sunt_bolnav and test_sensibil)\
                or ((not sunt_bolnav) and (not test_specific))

    return test_pozitiv

if ex == 1:

    N = 100000
    cnt_pozitive = 0
    cnt_toate = 0
    nr_teste = 1
    for _ in range(N):
        sunt_bolnav = np.random.random() < 1/1000
        for t in range(nr_teste):
            cnt += gen_test(sunt_bolnav)

