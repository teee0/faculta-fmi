n=int(input())
numere=input().split()

numere=[float(curs) for curs in numere]

ultima=None
creștereMax=None
for zi, curs in enumerate(numere,start=1):
    if ultima is not None:
        creștere=curs-ultima
        if(creștereMax is None or creștereMax[0] < creștere):
            creștereMax = [creștere,zi]
    ultima=curs

print(f"Pentru 𝑛={n} zile și cursul valutar dat de șirul {numere},",
      f"cea mai mare creștere a fost de {creștereMax[0]:.2f} RON,",
      f"între zilele {creștereMax[1]-1} și {creștereMax[1]}.",)