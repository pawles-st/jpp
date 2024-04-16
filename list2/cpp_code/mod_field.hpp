#ifndef MODFIELD
#define MODFIELD

#include <iostream>

class DivideByZeroException : public std::runtime_error {
	public:
		DivideByZeroException(const std::string& what_arg) : std::runtime_error(what_arg) {}
};

using mod_type = unsigned long;

template<mod_type p>
class GF {
	public:

		/// --- CONSTRUCTORS ---

		// default constructor - value initialised to 0
		GF() : value(0) {}

		// value constructor - value is specified by user
		GF(long v) : value(mod(v)) {}

		/// --- CONVERSION OPERATORS ---

		operator unsigned long() const {
			return this->value;
		}

		/// --- COMPARISON OPERATORS ---

		auto operator<=>(const GF<p>& rhs) const {
			return this->value <=> rhs.value;
		};
		bool operator==(const GF<p>& rhs) const {
			return this->value == rhs.value;
		};

		/// -- ARITHMETIC OPERATIONS ---

		GF<p> operator+(const GF<p>& rhs) const {
			return GF(this->value + rhs.value);
		};
		GF<p> operator-(const GF<p>& rhs) const {
			return GF(this->value - rhs.value);
		};
		GF<p> operator*(const GF<p>& rhs) const {
			return GF(this->value * rhs.value);
		};
		GF<p> operator/(const GF<p>& rhs) const {
			return *this * rhs.inverse();
		};
		GF<p> inverse() const {
			if (this->value == 0) {
				throw DivideByZeroException("Cannot invert a zero element");
			} else {
				DiophantineSolution solution = solve_dio(p, this->value);
				return GF<p>(solution.b);
			}
		};

		/// -- ASSIGNMENT OPERATIONS ---

		GF<p>& operator=(const GF<p>& rhs) {
			this->value = rhs.value;
			return *this;
		};
		GF<p>& operator+=(const GF<p>& rhs) {
			*this = *this + rhs;
			return *this;
		};
		GF<p>& operator-=(const GF<p>& rhs) {
			*this = *this - rhs;
			return *this;
		};
		GF<p>& operator*=(const GF<p>& rhs) {
			*this = *this * rhs;
			return *this;
		};
		GF<p>& operator/=(const GF<p>& rhs) {
			*this = *this / rhs;
			return *this;
		};

		/// --- HELPER METHODS ---

		mod_type getCharacteristic() const {
			return p;
		}

		mod_type getValue() const {
			return value;
		}
	private:
		mod_type value;

		struct DiophantineSolution {
			long a;
			long b;
			long c;
		};

		static DiophantineSolution solve_dio(const long x, const long y) {
			if (y == 0) {
				return DiophantineSolution{1, 0, x};
			} else {
				long r = x % y;
				long q = x / y;
				DiophantineSolution prev = solve_dio(y, r);
				return DiophantineSolution{prev.b, prev.a - q * prev.b, prev.c};
			}
		};
		static mod_type mod(long value) {
			return (value % static_cast<long>(p) + p) % p;
		};
};

/// --- NONMEMBER FUNCTIONS ---

template<mod_type p>
std::ostream& operator<<(std::ostream& os, const GF<p>& obj) {
	os << obj.getValue();
	return os;
}

template<mod_type p>
std::istream& operator>>(std::istream& is, const GF<p>& obj) {
	is >> obj.getValue();
	return is;
}

#endif
