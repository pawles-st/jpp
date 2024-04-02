#include <stdio.h>
#include <assert.h>
#include "datatype.h"

#define FACT_TEST_LEN 11
#define GCD_TEST_LEN 3
#define DIO_TEST_LEN 6

extern int factorial(int n);
extern int gcd(int x, int y);
extern DiophantineSolution solve_dio(int x, int y);

int main() {

	// factorial test

	{
		unsigned long fact_values[FACT_TEST_LEN] = {1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880, 3628800};
		for (int i = 0; i < FACT_TEST_LEN; ++i) {
			assert(factorial(i) == fact_values[i]);
		}
	}

	// gcd test

	{
		unsigned int gcd_values[GCD_TEST_LEN] = {4, 136, 19072};
		unsigned int x_values[GCD_TEST_LEN] = {76, 1438472, 33261568};
		unsigned int y_values[GCD_TEST_LEN] = {44, 82626392, 20082816};
		for (int i = 0; i < GCD_TEST_LEN; ++i) {
			assert(gcd(x_values[i], y_values[i]) == gcd_values[i]);
		}
	}

	// dio test

	{
		DiophantineSolution dio_values[DIO_TEST_LEN] = {{.a = -4, .b = 7, .c = 4}, {.a = 4, .b = 7, .c = -4}, {.a = 4, .b = 7, .c = 4}, {.a = -4, .b = 7, .c = -4}, {.a = -23608, .b = 411, .c = 136}, {.a = -32, .b = 53, .c = 19072}};
		int x_values[DIO_TEST_LEN] = {76, 76, -76, -76, 1438472, 33261568};
		int y_values[DIO_TEST_LEN] = {44, -44, 44, -44, 82626392, 20082816};
		for (int i = 0; i < DIO_TEST_LEN; ++i) {
			DiophantineSolution solution = solve_dio(x_values[i], y_values[i]);
			assert(solution.a == dio_values[i].a);
			assert(solution.b == dio_values[i].b);
			assert(solution.c == dio_values[i].c);
		}
	}

}
