package main

func isPrime(n int) bool {
	for i := 2; i < n; i++ {
		if n%i == 0 {
			return false
		}
	}
	return n > 1
}

func main() {
	for i, found := 1, 0; found < 3333; i++ {
		if isPrime(i) {
			found++
		}
	}
}
