proc isPrime(n: int): bool =
  var i = 2
  while i < n:
    if n mod i == 0:
      return false
    i += 1
  return n > 1

var i = 1
var found = 0

while found < 3333:
  if isPrime(i):
    found += 1
  i += 1
