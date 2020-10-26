def isPrime(n)
  (2...n).each do |i|
    if n % i == 0
      return false
    end
  end
  return n > 1
end

i = 1
found = 0

while found < 3333
  if isPrime(i)
    found += 1
  end
  i += 1
end
