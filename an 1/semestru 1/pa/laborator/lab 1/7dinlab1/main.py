#varianta cu depuneri separate
s=int(input())
economii=0
ziua=0

while economii < s:
    ziua+=1
    suma_zilei = int(input())
    economii  += suma_zilei

print(f"Gigel reușește să strângă în pușculiță suma necesară după {ziua} zile,",
      f"suma medie zilnică pe care acesta a depus-o în pușculiță e de {economii/ziua} RON,",
      f"iar suma care îi rămâne după ce își cumpără jucăria este de {economii-s}.")