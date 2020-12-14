
print('this is my_module')

X = 100

def add(*args):
    total = 0
    for d in args:
        total += d

    return total

print(add(10, 20, 30, 40, 50))