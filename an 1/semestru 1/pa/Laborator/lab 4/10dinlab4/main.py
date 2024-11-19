sir = "abcde"

L = " ".join([sir[i:] + sir[:i] for i in range(len(sir))])
print(L)