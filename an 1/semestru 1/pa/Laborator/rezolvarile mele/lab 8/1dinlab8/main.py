import re

p=input("parola: ")

def parolă(șir):
    a = re.search(r"^[a-z]{1,5}$",șir)
    A = re.search(r"^[A-Z]{1,5}$",șir)
    z = re.search(r"^[0-9]{1,5}$",șir)

    if a or A or z:
        print(f"parola \"{șir}\" este slabă")
    a = re.search(r"[a-z]",șir)
    A = re.search(r"[A-Z]",șir)
    c = re.search(r"[0-9]",șir)
    t = re.search(r"^[a-zA-Z0-9]{6,9}$",șir)
    if a and A and c and t:
        print(f"parola \"{șir}\" este medie")

parolă(p)