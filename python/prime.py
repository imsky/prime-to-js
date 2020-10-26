def isPrime(n):
  for i in range(2, n - 1):
    if n % i == 0:
      return False
  return n > 1

i = 1
found = 0

while found < 3333:
  if isPrime(i):
    found += 1
  i += 1
