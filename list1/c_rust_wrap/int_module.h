#ifndef INTEGER_FUNS
#define INTEGER_FUNS

typedef struct {
	int a;
	int b;
	int c;
} DiophantineSolution;

extern unsigned long factorial(unsigned int n);
extern unsigned int gcd(unsigned int x, unsigned int y);
extern DiophantineSolution solve_dio(int x, int y);
extern void foo();

#endif
