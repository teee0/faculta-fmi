a ,b = input().split()

def eVocală(literă):
    return literă in "aeiou"
#șirurile au aceeașî lungime
șablon=""
for i in range(len(a)):
    if eVocală(a[i])==eVocală(b[i])==1:
        șablon+="*"
    elif eVocală(a[i])==eVocală(b[i])==0:
        șablon+="#"
    else:
        șablon+="?"

print(șablon)

