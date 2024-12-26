cuv=input()

suf,pref="",""

def palindrom(s):
    for i in range(len(s)//2):
        if s[i]!=s[-i-1]:
            return False
    return True

for i in range(len(cuv)):
    if palindrom(cuv[:i+1]):
        pref=cuv[:i+1]
    if suf=="" and palindrom(cuv[i:]):
        suf=cuv[i:]

print(pref,suf)