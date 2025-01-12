def mod(text):
	numeric = text.isdigit()
	alfanumeric = numeric or (text.isalnum() and text.isupper())
	byte=True
	return int(numeric)+int(alfanumeric)+int(byte)

while True:
	print(mod(input()))
