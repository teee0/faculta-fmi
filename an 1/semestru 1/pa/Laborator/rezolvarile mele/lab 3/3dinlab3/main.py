s="abccabcacabcc"
t="abc"

poz = s.find(t)

if poz==-1:
    print("Nu s-a gasit nica")
else :
    while poz != -1:
        print(poz, end=", ")
        poz=s.find(t,poz+len(t))

