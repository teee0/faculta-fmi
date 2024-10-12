def cmmdc(x,y):
    while y!=0:
        if x>y:
            x=x%y
            x//=y
        else:
            y=y%x
            y//=x
    return x
if __name__ == '__main__':
    l1=int(input())
    l2=int(input())
    nr_plăci=cmmdc(l1,l2)
    print(f"Numărul minim de plăci este {nr_plăci} și latura plăcilor este de {l1*l2/(nr_plăci*nr_plăci)}")