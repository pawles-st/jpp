#include "int_module.h"

unsigned long factorial(unsigned int n) {
	if (n == 0) {
		return 1;
	} else {
		return n * factorial(n - 1);
	}
}

unsigned int gcd(unsigned int x, unsigned int y) {
	if (y == 0) {
		return x;
	} else {
		return gcd(y, x % y);
	}
}
	
DiophantineSolution solve_dio(int x, int y) {
	if (y == 0) {
		DiophantineSolution solution = {.a = 1, .b = 0, .c = x};
		return solution;
	} else {
		int q = x / y;
		int r = x % y;
		DiophantineSolution prev = solve_dio(y, r);
		DiophantineSolution solution = {.a = prev.b, .b = prev.a - q * prev.b, .c = prev.c};
		return solution;
	}
}
