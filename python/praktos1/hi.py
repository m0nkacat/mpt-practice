print("Введите оператор")
a = str(input())
if (a == "+"):
    n1 = float(input())
    n2 = float(input())
    print(n1+n2)
elif (a == "-"):
    n1 = float(input())
    n2 = float(input())
    print(n1-n2)
elif (a == "*"):
    n1 = float(input())
    n2 = float(input())
    print(n1*n2)
elif (a == "/"):
    n1 = float(input())
    n2 = float(input())
    if (n2 == 0):
        print("Деление на 0 невозможно")
    else:
        print(n1/n2)
elif (a == "//"):
    n1 = float(input())
    n2 = float(input())
    if (n2 == 0):
        print("Деление на 0 невозможно")
    else:
        print(n1//n2)    
elif (a == "%"):
    n1 = float(input())
    n2 = float(input())
    if (n2 == 0):
        print("Деление на 0 невозможно")
    else:
        print(n1%n2)
elif (a == "**"):
    n1 = float(input())
    n2 = float(input())
    print(n1**n2)
elif (a == "=="):
    n1 = float(input())
    n2 = float(input())
    print(n1==n2)
elif (a == "!="):
    n1 = float(input())
    n2 = float(input())
    print(n1!=n2)
elif (a == ">"):
    n1 = float(input())
    n2 = float(input())
    print(n1>n2)
elif (a == "<"):
    n1 = float(input())
    n2 = float(input())
    print(n1<n2)
elif (a == ">="):
    n1 = float(input())
    n2 = float(input())
    print(n1>=n2)
elif (a == "<="):
    n1 = float(input())
    n2 = float(input())
    print(n1<=n2)
elif(a == "and"):
    b1 = bool(input())
    b2 = bool(input())
    print(b1 and b2)
elif(a == "or"):
    b1 = bool(input())
    b2 = bool(input())
    print(b1 or b2)
elif(a == "not"):
    b1 = bool(input())
    print(not b1)
elif(a == "&"):
    n1 = float(input())
    n2 = float(input())
    print(n1&n2)
elif(a == "|"):
    n1 = float(input())
    n2 = float(input())
    print(n1|n2)
elif(a == "~"):
    n1 = float(input())
    print(~n1)
elif(a == "<<"):
    n1 = float(input())
    n2 = float(input())
    print(n1<<n2)
elif(a == ">>"):
    n1 = float(input())
    n2 = float(input())
    print(n1>>n2)
elif(a == "in"):
    n1 = float(input())
    n2 = float(input())
    n1 = str(n1)
    n2 = str(n2)
    print(n1 in n2)
elif(a == "not in"):
    n1 = float(input())
    n2 = float(input())
    n1 = str(n1)
    n2 = str(n2)
    print(n1 not in n2)
elif(a == "is"):
    n1 = float(input())
    n2 = float(input())
    n1 = str(n1)
    n2 = str(n2)
    print(n1 is n2)
elif(a == "is not"):
    n1 = float(input())
    n2 = float(input())
    n1 = str(n1)
    n2 = str(n2)
    print(n1 is not n2)
else: 
    print("Такого оператора нету")