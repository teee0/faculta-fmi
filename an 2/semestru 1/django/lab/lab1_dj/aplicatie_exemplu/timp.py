from datetime import datetime

luni_an = [
    "Ianuarie", "Februarie", "Martie", "Aprilie", "Mai", "Iunie",
    "Iulie", "August", "Septembrie", "Octombrie", "Noiembrie", "Decembrie"
]

zile_saptamana = [
    "Luni", "Marți", "Miercuri", "Joi",
    "Vineri", "Sâmbătă", "Duminică"
]

def afis_data(mod="toata"):
    now = datetime.now()
    rez = ""
    def data():
        return f"{now.day} {luni_an[now.month-1]} {now.year}"
    if mod == "toata":
        rez = f"{zile_saptamana[now.weekday()]}, {data()}"
    elif mod == "timp":
        rez = now.strftime("%H:%M:%S")
    elif mod == "zi":
        rez = data()
    return f"<section>{rez}</section>"

print(afis_data())