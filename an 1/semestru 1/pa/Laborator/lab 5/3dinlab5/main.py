m,n = [int(x) for x in input("m, n: ").split()]
matrice = [[int(x) for x in input(f"linia {i+1}: ").split()] for i in range(m)]

for linie in matrice:
    print(*linie)

L_max=[max(linie) for linie in matrice]

print("\n", *L_max)