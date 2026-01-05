prop = "ana are 4 mere.".lower()
k = 1
lung=ord("z")-ord("a")
L=[chr((ord(c)+k-ord("a"))%(lung)+ord("a")) if c.isalpha() else c for c in prop]
print ("".join(L))