'''
l = [1,2,0,1,2,3,5,2]

def subsir_max(l):
    curent = []
    s_max = []
    for start in range(len(l)):
        curent = [ l[start] ]
        for i in range(start,len(l)):
            if curent[-1] < l[i]:
                curent.append(l[i])
        if len(curent)>len(s_max): s_max=curent
    print(s_max)
subsir_max(l)
'''

l = [3,5,5,2,7,9,10,10,1,2]

def subsir_max(l):
    curent = []
    s_max = []
    for start in range(len(l)):
        curent = [ l[start] ]
        for i in range(start+1,len(l)):
            if curent[-1] < l[i]:
                curent.append(l[i])
            else:
                break
        if len(curent)>len(s_max): s_max=curent
    print(s_max)
subsir_max(l)
