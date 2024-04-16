#include "mod_field.hpp"
#include <iostream>

const unsigned int p = 1234577;

int main() {
	GF<p> a(1);
	GF<p> b(2);
	std::cout << a / b;
}
