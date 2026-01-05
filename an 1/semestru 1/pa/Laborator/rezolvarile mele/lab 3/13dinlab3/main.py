with open("baza.in") as fin:
    nr26=fin.read()

p=1
nr10 = 0
for i in range(len(nr26)):
    nr10 += p * int(ord(nr26[-i-1])-ord('a'))
    p *= 26
print(nr10)