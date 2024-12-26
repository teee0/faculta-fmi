prop= "Ana are 3 mere și 4 pere!".lower()

L=[k for k in prop.split() if k[0] in ("aeiou")]
print (L)