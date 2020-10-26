fun isPrime(n: Int): Boolean {
  for (i in 2 until n) {
    if (n.rem(i) == 0) {
      return false
    }
  }
  return n > 1
}

fun main() {
  var i = 1
  var found = 0
  while (found < 3333) {
    if (isPrime(i)) {
      found++
    }
    i++
  }
}
