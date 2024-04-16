#include "mod_field.hpp"
#include <iostream>

using mod_type = long;

template<mod_type p>
auto GF<p>::operator<=>(const GF<p>& rhs) const {
	return this->value <=> rhs.value;
}

template<mod_type p>
bool GF<p>::operator==(const GF<p>& rhs) const {
	return this->value == rhs.value;
}

template<mod_type p>
GF<p> GF<p>::operator+(const GF<p>& rhs) const {
	return GF(this->value + rhs.value);
}

template<mod_type p>
GF<p> GF<p>::operator-(const GF<p>& rhs) const {
	return GF(this->value - rhs.value);
}

template<mod_type p>
GF<p> GF<p>::operator*(const GF<p>& rhs) const {
	return GF(this->value * rhs.value);
}

template<mod_type p>
GF<p> GF<p>::operator/(const GF<p>& rhs) const {
	return GF(this->value * GF::inverse(rhs.value));
}

template<mod_type p>
GF<p> GF<p>::inverse() const {
	GF::DiophantineSolution solution = solve_dio(p, this->value);
	return GF<p>(solution.b);
}

template<mod_type p>
GF<p>& GF<p>::operator=(const GF<p>& rhs) {
	this->value = rhs.value;
	return this;
}

template<mod_type p>
GF<p>& GF<p>::operator+=(const GF<p>& rhs) {
	*this = *this + rhs;
	return this;
}

template<mod_type p>
GF<p>& GF<p>::operator-=(const GF<p>& rhs) {
	*this = *this - rhs;
	return this;
}

template<mod_type p>
GF<p>& GF<p>::operator*=(const GF<p>& rhs) {
	*this = *this * rhs;
	return this;
}

template<mod_type p>
GF<p>& GF<p>::operator/=(const GF<p>& rhs) {
	*this = *this / rhs;
	return this;
}

template<mod_type p>
std::ostream& operator<<(std::ostream& os, const GF<p>& obj) {
	os << obj.value;
	return os;
}

template<mod_type p>
std::istream& operator>>(std::istream& is, const GF<p>& obj) {
	is >> obj.value;
	return is;
}

template<mod_type p>
static typename GF<p>::DiophantineSolution solve_dio(const long x, const long y) {
	if (y == 0) {
		return typename GF<p>::DiophantineSolution{1, 0, x};
	} else {
		long r = x % y;
		long q = x / y;
		typename GF<p>::DiophantineSolution prev = GF<p>::solve_dio(y, r);
		return typename GF<p>::DiophantineSolution{prev.b, prev.a - q * prev.b, prev.c};
	}
}

template<mod_type p>
static mod_type mod(mod_type value) {
	return (value % p + p) % p;
}
