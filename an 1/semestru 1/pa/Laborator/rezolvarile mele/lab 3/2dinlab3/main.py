șir=input()

for i in range(len(șir)//2):
    print(șir[i:len(șir)-i].center(len(șir),"@"))