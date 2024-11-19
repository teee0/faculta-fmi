propoziție=input("propoziție=")
s=input("cuvânt de înlocuit= ")
t=input("cuvânt cu care se înlocuiește= ")

poz=propoziție.find(s)

while poz != -1:
    if (poz==0 or not (propoziție[poz-1]).isalnum() ) \
        and (poz+len(s) == len(propoziție) or not (propoziție[poz+len(s)]).isalnum()
    ):
        propoziție = propoziție[:poz] + t + propoziție[poz+len(s) : ]
    poz = propoziție.find(s,poz+len(t))

print(propoziție)