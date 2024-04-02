#ifndef DATATYPE
#define DATATYPE

typedef struct {
	int a;
	int b;
	int c;
} DiophantineSolution;

extern int factorial(int n);
extern int gcd(int x, int y);
extern DiophantineSolution solve_dio(int x, int y);

#endif
