#include "mod_field.hpp"
#include <iostream>
#include <cassert>

const unsigned int p = 1234577;

int main() {
	GF<p> a;
	GF<p> b(5);
	GF<p> c(11);
	GF<p> d(11);

	assert(static_cast<unsigned long>(a) == 0);
	assert(static_cast<double>(b) == 5);

	assert(a < b);
	assert(b > a);
	assert(b <= c);
	assert(c <= d);
	assert(c == d);
	assert(a != b);

	assert(GF<p>(5) == a + b);
	assert(GF<p>(6) == c - b);
	assert(GF<p>(0) == a * b);
	assert(b * b.inverse() == GF<p>(1));
	assert(GF<p>(1) / d == d.inverse());

	a = 1;
	assert(GF<p>(1) == a);
	a += -5;
	assert(GF<p>(1234573) == a);
	a -= 1;
	assert(GF<p>(1234572) == a);
	a *= 2;
	assert(GF<p>(1234567) == a);
	a /= 2;
	assert(GF<p>(1234572) == a);

	a = 0;
	assert(a.getCharacteristic() == p);
	assert(a.getValue() == 0);

}
