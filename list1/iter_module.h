#ifndef INTEGER_FUNS
#define INTEGER_FUNS

typedef struct {
	int a;
	int b;
	int c;
} DiophantineSolution;

unsigned long factorial(unsigned int n);
unsigned int gcd(unsigned int a, unsigned int b);
DiophantineSolution solve_dio(int x, int y);

#endif
