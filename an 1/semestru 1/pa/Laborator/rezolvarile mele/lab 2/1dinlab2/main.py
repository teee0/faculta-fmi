n=int(input())
temp=n
reverse=0
while temp:
    reverse=reverse*10+temp%10
    temp//=10
print("E palindrom" if reverse==n else "Nu e palindrom")