n=input()
#fără sortări
maxim=minim=""
for x in range(1,9+1):
    minim=f"{x}" * n.count(f"{x}") + minim
    maxim=maxim+f"{x}" * n.count(f"{x}")

if n.count("0") != 0:
    minim=minim+ "0" * n.count("0")
    maxim=maxim+ "0" * n.count("0")
print(f"Maximu e {maxim} și minimu e {minim}.")