from http.cookiejar import uppercase_escaped_char

prompt = """\
0: traducere din păsărească
1: traducere în păsărească
"""

ispiglatin=""
while ispiglatin not in [0,1]:
    ispiglatin = int(input(prompt))
#apa > apapapa
#apapa>aPApaPApaPA
#papa>papapapa
#prapapa> praPApaPApaPA
text = input("text: ")
rez=""
if ispiglatin:
    for c in text:
        rez+=c
        if "aeiou".find(c.lower()) != -1:
                rez+="p"+c
else:
    poz=text.find("p")
    while poz != -1:
        pass
        #if
        #text.find(, poz + 3)

print(rez)