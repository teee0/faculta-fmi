def completare(M, i, j, d):
	global k
	if d==1:
		M[0][0]=1
		k+=1
		return
	completare(M,i,		j+d//2,d//2)
	completare(M,i+d//2,j,d//2)
	completare(M,i,		j,d//2)
	completare(M,i+d//2,j+d//2,d//2)

N = int(input("introduceți numărul: "));
M = [[0]*2**N for _ in range(2**N)]
for linie in M:
	print(*linie)
	
k = 1

completare(M,0,0,2**N)
dim_max = 2**N * 2**N
for linie in M:
	for elem in linie:
		print(str(elem).rjust(dim_max),end=' ')
	print()
