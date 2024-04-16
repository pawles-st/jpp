#ifndef MODFIELD
#define MODFIELD

using mod_type = long;

template<mod_type p>
class GF {
	public:

		/// --- CONSTRUCTORS ---

		// default constructor - value initialised to 0
		GF() : value(0) {}

		// value constructor - value is specified by user
		GF(mod_type v) : value(mod(v)) {}

		/// --- COMPARISON OPERATORS ---

		auto operator<=>(const GF<p>& rhs) const;
		bool operator==(const GF<p>& rhs) const;

		/// -- ARITHMETIC OPERATIONS ---

		GF<p> operator+(const GF<p>& rhs) const;
		GF<p> operator-(const GF<p>& rhs) const;
		GF<p> operator*(const GF<p>& rhs) const;
		GF<p> operator/(const GF<p>& rhs) const;
		GF<p> inverse() const;

		/// -- ASSIGNMENT OPERATIONS ---

		GF<p>& operator=(const GF<p>& rhs);
		GF<p>& operator+=(const GF<p>& rhs);
		GF<p>& operator-=(const GF<p>& rhs);
		GF<p>& operator*=(const GF<p>& rhs);
		GF<p>& operator/=(const GF<p>& rhs);

		/// --- 

		mod_type getCharacteristic() {
			return p;
		}
	private:
		mod_type value;

		struct DiophantineSolution {
			long a;
			long b;
			long c;
		};

		static DiophantineSolution solve_dio(const long x, const long y);
		static mod_type mod(mod_type value);


		

};

#endif
