n = int (input("n="))

minim=None
for i in range(1,n+1):
    x=int(input(f"elementul {i}: "))
    if minim is None or minim >x:
        minim=x
        nr_apariții=1
    elif minim==x:
        nr_apariții+=1

print(f"minimul este {minim} și apare de {nr_apariții} ori.")

