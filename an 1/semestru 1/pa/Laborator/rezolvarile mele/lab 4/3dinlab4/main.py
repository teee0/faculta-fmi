prop= "ana are mere"
prop2="".join([x+"p"+x if x in "aeioiu" else x for x in prop])
print(prop2)