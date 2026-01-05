L = [4,6,3,12,5,65,66,462]

# A)
print(sorted(L,key=str))

# B)
print(sorted(L,key=lambda x: str(x)[::1]))

# C)
print( sorted( L,key=lambda x: len(str(x)),reverse=True ) )
print( sorted( L,key=lambda x: -len(str(x)) ) )

# D)
print(sorted(L,key = lambda x: len(set(str(x))) ) )

# E)
print(sorted(L,key = lambda x: (len(str(x)), -x) ) )
