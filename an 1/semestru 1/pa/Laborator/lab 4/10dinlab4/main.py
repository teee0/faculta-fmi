sir = input("șir: ")
def permutări(s):
  return " ".join([sir[i:] + sir[:i] for i in range(len(sir))])
print(permutări(sir))