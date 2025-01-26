import copy
#n=int(input("n = "))
n=6
#xc_init,yc_init=[int(x) for x in input().split]
xc_init,yc_init =4,1
tabla =[
    [0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0],
    [0,0,1,0,0,0,1],
    [0,0,0,0,1,0,0],
    [0,0,0,0,0,0,0],
    [0,0,1,1,1,1,1],
    [0,0,0,0,0,1,0]
]

val_max,val_curent=0,0
traseu=[]
traseu_max=[]
def cai(xc,yc):
    global traseu,traseu_max,val_curent,val_max

    traseu.append([xc,yc])
    if yc+1 <= n:
        val_curent+=tabla[xc][yc]
        if xc+2 <= n:
            cai(xc+2,yc+1)
        if xc-2 > 0:
            cai(xc-2,yc+1)
        if yc+2 <= n:
            if xc+1 <= n:
                cai(xc+1,yc+2)
            if xc-1 > 0:
                cai(xc-1,yc+2)
        val_curent-=tabla[xc][yc]
    else:
        if val_curent>val_max:
            traseu_max=[x for x in traseu]
            val_max=val_curent
    traseu.pop()


cai(xc_init,yc_init)
print(traseu_max,val_max)
