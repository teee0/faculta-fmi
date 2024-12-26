#print(ord("A")) # 65
#print(chr(ord("B"))) # B
#codul lui cezar
text=input("Text de cripat: ")
k=int(input("Cheia: "))

rezultat=""
alf=(ord("z")-ord("a")+1)

for i in range(len(text)):
    x = text[i]
    inceput= ord("A") if x.isupper() else ord("a")

    if x.isalpha():
        x = chr( inceput+ (ord(x)+k- inceput+1) % alf )
    rezultat= rezultat+x

print(rezultat)