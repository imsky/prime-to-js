package main

object Prime {
  def isPrime (n:Int) : Boolean = {
    for (i <- 2 until n) {
      if (n % i == 0) {
        return false
      }
    }
    return n > 1
  }

  def main (args: Array[String]): Unit = {
    var i : Int = 1
    var found : Int = 0

    while (found < 3333) {
      if (isPrime(i)) {
        found += 1
      }
      i += 1
    }
  }
}
