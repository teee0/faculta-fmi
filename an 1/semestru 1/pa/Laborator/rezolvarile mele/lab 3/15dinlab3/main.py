
def areSentencesSimilar(sentence1,  sentence2) :
    sufix_comun=None
    prefix_comun=None

    if len(sentence1) < len(sentence2):
        sentence1,sentence2=sentence2,sentence1

    sentence1=sentence1.split()
    sentence2=sentence2.split()

    for i in range(len(sentence2)):
        if sentence1[i] == sentence2[i]:
            if prefix_comun is None:
                prefix_comun=sentence1[i]
            else:
                prefix_comun =  prefix_comun + sentence1[i] + " "
        else:
            break
    else:
        return True

    for i in range(-1,-len(sentence2)-1,-1):
        if sentence1[i] == sentence2[i]:
            if sufix_comun is None:
                sufix_comun=sentence1[i]
            else:
                sufix_comun = sentence1[i] + " " + sufix_comun
        else:
            break
    else:
        return True
    if prefix_comun is None or sufix_comun is None:
        return False
    temp=prefix_comun+" "+sufix_comun
    return temp==" ".join(sentence1) or temp==" ".join(sentence2)

print(areSentencesSimilar("Hello Jane", "Hello my name is Jane"))
print(areSentencesSimilar("of", "A lot of words"))
print(areSentencesSimilar("Eating right now", "Eating"))
print(areSentencesSimilar("ab bc bc", "ab bc bc bc"))