bool isPrime(int n) {
  for (var i = 2; i < n; i++) {
    if (n % i == 0) {
      return false;
    }
  }
  return n > 1;
}

void main () {
  for (var i = 1, found = 0; found < 3333; i++) {
    if (isPrime(i)) {
      found++;
    }
  }
}
