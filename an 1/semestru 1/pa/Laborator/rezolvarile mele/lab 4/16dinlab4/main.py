L=[2,3,45,45,88,88,888,888,88888,90000]
# L=[int(x) for x in input("L=").split()]

# def șterge_duplicate(L):
#     #var 1
#     return list(set(L))
#
# print (șterge_duplicate(L))

def șterge_duplicate2(L):
    #var 2
    last=L[0]
    i=1
    while i<len(L):
        if L[i]==last:
            L.pop(i)
        else:
            last=L[i]
            i += 1
șterge_duplicate2(L)
print(L)
