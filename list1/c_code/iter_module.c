#include "int_module.h"

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
		unsigned int r = x % y;
		x = y;
		y = r;
	}
	return x;
}

DiophantineSolution solve_dio(int x, int y) {
	int s1 = 1;
	int s2 = 0;
	int t1 = 0;
	int t2 = 1;
	while (y != 0) {
		int q = x / y;
		int r = x % y;
		int new_s = s1 - q * s2;
		int new_t = t1 - q * t2;
		s1 = s2;
		s2 = new_s;
		t1 = t2;
		t2 = new_t;
		x = y;
		y = r;
	}
	DiophantineSolution solution = {.a = s1, .b = t1, .c = x};
	return solution;
}
