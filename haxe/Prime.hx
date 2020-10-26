package;

class Prime {
  static function isPrime(n:Int):Bool {
    var i = 2;
    while (i < n) {
      if (n % i == 0) {
        return false;
      }
      i++;
    }
    return n > 1;
  }

  static function main() {
    var i = 1;
    var found = 0;
    while (found < 3333) {
      if (isPrime(i)) {
        found++;
      }
      i++;
    }
  }
}
