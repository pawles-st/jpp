#include "iter_module.h"

unsigned long factorial(unsigned int n) {
	if (n == 0) {
		return 1;
	} else {
		unsigned long result = n;
		unsigned int k = n - 1;
		while (k > 1) {
			result *= k;
			k -= 1;
		}
		return result;
	}
}

unsigned int gcd(unsigned int x, unsigned int y) {
	if (x < y) { // swap the numbers if needed to assert x >= y
		unsigned int temp = x;
		x = y;
		y = temp;
	}
	while (y != 0) {
		unsigned int remainder = x % y;
		x = y;
		y = remainder;
	}
	return x;
}

DiophantineSolution solve_dio(int x, int y) {
	if (x < y) {
		unsigned int temp = x;
		x = y;
		y = temp;
	}
	while (y != 0) {
		unsigned int remainder = x % y;
		x = y;
		y = remainder;
	}
	unsigned int tem
}
