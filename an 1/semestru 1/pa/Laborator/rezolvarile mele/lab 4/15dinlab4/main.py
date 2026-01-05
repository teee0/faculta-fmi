L= [142142,123142,123,-345677,22,34,2,1232,567,5463]
k=3
def remSumMin(L,k):
    subsecv_minima=sum(L[:k])
    for i in range(1,len(L)-k):
        subsecv=sum(L[i:k+i])
        if subsecv < subsecv_minima:
            subsecv_minima = subsecv
            i_min = i
    #ștergerea subsecvenței minime L[i_min:i_min+k]
    L=L[:i_min]+L[i_min+k:]
    return L

print(remSumMin(L,k))