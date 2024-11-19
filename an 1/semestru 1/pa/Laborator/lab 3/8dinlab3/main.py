text=input().split()
def sumă_numere():
    sumă = 0
    # sumă = [int(cuv) for cuv in text if cuv.isdigit()]
    for cuv in text:
        if cuv.isdigit():
            sumă+=int(cuv)
    return sumă
print(sumă_numere())